import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gbera/portals/portals.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common.dart';
import 'errors.dart';

final String KEY_THEME_SET = '@.set.theme';
OnFrameworkRefresh onFrameworkRefresh; //用于内核刷新整个UI
Map<String, Portal> _allPortals = Map(); //key是portalid
Map<String, Page> _allPages = Map(); //key是全路径
Map<String, ThemeStyle> _allThemes = Map(); //key是全路径
Map<String, Style> _allStyles = Map(); //key是全路径
Map<String, Desklet> _allDesklets = Map(); //桌面栏目,key是全路径
SharedPreferences _sharedPreferences = null; //本地存储
var _currentPortal = ''; //当前使用的框架
var _currentThemeUrl = ''; //当前应用的主题路径，是相对于当前portal的路径
var _security = Security();

IServiceProvider _site = GberaServiceProvider();

//事件顺序
//1。先执行onGenerateThemeStyle，如果已绑定的话；
//2。次执行buildRoutes，如果已绑定的话；
//3。再执行onGenerateRoute，如果已绑定的话；
//因此加载顺序为：不论绑定与否，只要3个绑一个就响应框架的加载事件且一次性加载，如果已加载过了则不再加载
//但要考虑到热调试，当重新过来时清空则加载
var loadStep =
    0; //1为执行了onGenerateThemeStyle方法；2为执行了buildRoutes法；3是执行了onGenerateRoute方法。后者检查前序方法是否被执行，否则报错。

run(Widget app) async{
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  _sharedPreferences = await SharedPreferences.getInstance();
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    return RuntimeErrorPage(flutterErrorDetails);
  };

  runApp(app);

  if (onFrameworkRefresh == null) {
    throw FlutterError('客户程序必须实现onFrameworkRefresh事件');
  }
}

_buildPortals(BuildContext context) {
  _allPortals.clear();
  _allPages.clear();
  _allThemes.clear();
  _allStyles.clear();
  _allDesklets.clear();
  _currentThemeUrl = '';
  var _portals = buildPortals(_site);
  for (var item in _portals) {
    var portal = item(_site);
    if (_allPortals.containsKey(portal.id)) {
      throw FlutterErrorDetails(exception: Exception('已存在框架:${portal.id}'));
    }
    _allPortals[portal.id] = portal;
    var pages = portal.buildPages(portal, _site);
    for (Page page in pages) {
      if (page.url == null ||
          !page.url.startsWith("/") ||
          page.url.indexOf("://") > 0) {
        throw FlutterErrorDetails(
            exception: Exception(
                '页面url错误:${page.title}=${page.url}。必须非空，必须以/开头，必须是相对于portal的路径'));
      }
      //去掉queryString
      var url = page.url;
      var pos = url.indexOf("?");
      var withoutQs = '';
      var qs = '';
      if (pos > 0) {
        withoutQs = url.substring(0, pos);
        qs = url.substring(pos + 1, url.length);
      } else {
        withoutQs = url;
      }
      page.$__init(portal.id, qs);
      String fullurl = '${portal.id}:/${withoutQs}';
      if (_allPages.containsKey(fullurl)) {
        throw FlutterErrorDetails(exception: Exception('已存在地址页:$fullurl'));
      }
      _allPages[fullurl] = page;
    }
    var themes = portal.buildThemes(portal, _site);
    for (ThemeStyle themeStyle in themes) {
      if (themeStyle.url == null ||
          !themeStyle.url.startsWith("/") ||
          themeStyle.url.indexOf("://") > 0) {
        throw FlutterErrorDetails(
            exception: Exception(
                '主题url错误:${themeStyle.title}=${themeStyle.url}。必须非空，必须以/开头，必须是相对于portal的路径'));
      }
      var url = themeStyle.url;
      var pos = url.indexOf("?");
      if (pos > -1) {
        throw FlutterErrorDetails(exception: Exception('主题url不能带查询串:$url'));
      }
      String themeurl = '${portal.id}:/$url';
      if (_allThemes.containsKey(themeurl)) {
        throw FlutterErrorDetails(exception: Exception('已存在主题地址:$themeurl'));
      }
      List<Style> styles = themeStyle.buildStyle(context);
      for (Style style in styles) {
        String themeurlSubEndSign = themeurl;
        while (themeurl.endsWith('/')) {
          themeurlSubEndSign = themeurl.substring(0, themeurl.length - 1);
        }
        if (!style.url.startsWith("/")) {
          throw FlutterErrorDetails(
              exception: Exception('非法地址：${style.url}，style的url必须以/开头。'));
        }
        String styleFullUrl = '${themeurlSubEndSign}${style.url}';
        if (_allStyles.containsKey(styleFullUrl)) {
          throw FlutterError('样式地址冲突:$styleFullUrl');
        }
        _allStyles[styleFullUrl] = style;
      }
      _allThemes[themeurl] = themeStyle;
    }
    var desklets = portal.buildDesklets(portal, _site);
    for (var desklet in desklets) {
      if (desklet.url == null ||
          !desklet.url.startsWith("/") ||
          desklet.url.indexOf("://") > 0) {
        throw FlutterErrorDetails(
            exception: Exception(
                '桌面栏目的url错误:${desklet.title}=${desklet.url}。必须非空，必须以/开头，必须是相对于portal的路径'));
      }
      var url = desklet.url;
      var pos = url.indexOf("?");
      if (pos > -1) {
        throw FlutterErrorDetails(exception: Exception('主题url不能带查询串:$url'));
      }
      String deskleturl = '${portal.id}:/$url';
      if (_allDesklets.containsKey(deskleturl)) {
        throw FlutterErrorDetails(
            exception: Exception('已存在桌面栏目地址:$deskleturl'));
      }
      _allDesklets[deskleturl] = desklet;
    }
  }
}

//主题是第一个响应，次是初始化路由表
ThemeData onGenerateThemeStyle(String url, BuildContext context) {
  //由于主题是最先加载，因此铁定都要执行初始化。所以在调试时如添加了新的page或主题样式支持reload hot热调试
  _buildPortals(context);
  loadStep = 1;
  var fullUrl = url;
  var pos = fullUrl.indexOf('://');
  if (pos < 0) {
    throw FlutterErrorDetails(
        exception: Exception('非法地址请求。正确格式为：portal://relativeUrl'));
  }
  _currentPortal = fullUrl.substring(0, pos);
  var _storedThemeUrl=_sharedPreferences.getString(KEY_THEME_SET);
  if(!StringUtil.isEmpty(_storedThemeUrl)){
    _currentThemeUrl=_storedThemeUrl;
    fullUrl='$_currentPortal:/$_currentThemeUrl';
  }else {
    _currentThemeUrl = fullUrl.substring(pos + 2, fullUrl.length);
  }
  ThemeStyle themeStyle = _allThemes[fullUrl];
  if (themeStyle == null) return null;

  return themeStyle.buildTheme(context);
}

Map<String, Widget Function(BuildContext)> buildRoutes() {
  if (loadStep < 1) {
    throw FlutterErrorDetails(
        exception: Exception('主widget未绑定onGenerateThemeStyle方法'));
  }
  loadStep = 2;
  return {}; //仅仅将它当作初始化事件使用，所以直接返回空map，当然也可以为map添加一些初始化的全局页面，比如错误页面
}

Route onGenerateRoute(RouteSettings routeSettings) {
  if (loadStep < 2) {
    throw FlutterErrorDetails(exception: Exception('主widget未绑定buildRoutes方法'));
  }
  loadStep = 3;
  var fullUrl = routeSettings.name;
  if ("/" == fullUrl) {
    return null;
  }
  if (fullUrl.indexOf("://") < 0) {
    throw FlutterErrorDetails(
        exception: Exception(
            '非法地址请求:$fullUrl。正确格式为：portal://relativeUrl?key=value&key2=value2'));
  }
  Page page = _allPages[fullUrl];
  if (page == null) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (BuildContext buildContext) {
        return ErrorPage404();
      },
    );
  }
  Map<String, Object> args = Map();
  if (page.parameters.length > 0) {
    args.addAll(page.parameters);
  }
  if (routeSettings.arguments != null) {
    if (routeSettings.arguments is Map) {
      args.addAll(routeSettings.arguments);
    } else {
      args[routeSettings.arguments.toString()] = routeSettings.arguments;
    }
  }
  RouteSettings settings =
      RouteSettings(name: fullUrl, isInitialRoute: false, arguments: args);
  BuildRoute buildRoute = page?.buildRoute;
  if (buildRoute != null) {
    return buildRoute(settings, page, _site);
  }
  BuildPage buildPage = page?.buildPage;
  if (buildPage == null) {
    return null;
  }
  return MaterialPageRoute(
    settings: routeSettings.copyWith(
        name: fullUrl, arguments: args, isInitialRoute: false),
    builder: (BuildContext buildContext) {
      PageContext pageContext = PageContext(
        page: page,
        site: _site,
        context: buildContext,
      );
      return buildPage(pageContext);
    },
  );
}

Route onUnknownRoute(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (BuildContext buildContext) {
      return ErrorPage404();
    },
  );
}

BaseOptions options = BaseOptions(headers: {
  'Content-Type': "text/html; charset=utf-8",
});
var _dio = Dio(options); //使用base配置可以通

class GberaServiceProvider implements IServiceProvider {
  @override
  getService(String name) {
    if ("@.http" == name) {
      return _dio;
    }
    if ("@.portals" == name) {
      return _allPortals;
    }
    if ("@.pages" == name) {
      return _allPages;
    }
    if ("@.themes" == name) {
      return _allThemes;
    }
    if ("@.styles" == name) {
      return _allStyles;
    }
    if ("@.desklets" == name) {
      return _allDesklets;
    }
    if ("@.current.theme" == name) {
      return _currentThemeUrl;
    }
    if ('@.security' == name) {
      return _security;
    }
    if ('@.framework.refresh' == name) {
      return onFrameworkRefresh;
    }
    if('@.sharedPreferences'==name){
      return _sharedPreferences;
    }
    return null;
  }
}
