import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gbera/portals/portals.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common.dart';
import 'errors.dart';

OnFrameworkEvents onFrameworkEvents; //用于内核刷新整个UI
Map<String, Portal> _allPortals = Map(); //key是portalid
Map<String, PortalStore> _allPortalStores = Map(); //key是 portalid
Map<String, ServiceSite> _allServiceSites = Map(); //key是 portalid
Map<String, Page> _allPages = Map(); //key是全路径
Map<String, ThemeStyle> _allThemes = Map(); //key是全路径
Map<String, Style> _allStyles = Map(); //key是全路径
Map<String, Desklet> _allDesklets = Map(); //桌面栏目,key是全路径
NetosSharedPreferences _sharedPreferences = null; //本地存储
Map<String, dynamic> _props;
IServiceProvider _site = GberaServiceProvider();

///上下文环境
Environment _environment = Environment();

run(Widget app, {Map<String, dynamic> props}) async {
  if (props == null) {
    props = {};
  }
  _props = props;
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  await _init();

  runApp(app);

  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    return RuntimeErrorWidget(flutterErrorDetails: flutterErrorDetails);
  };
}

///仅加载一次，不受hot reload影响，所以不支持热部署，如添加页面等资源时可使用hot restart快速重启应用
_init() async {
  WidgetsFlutterBinding.ensureInitialized();
  _sharedPreferences = await NetosSharedPreferences().init(_site);
  _allPortals.clear();
  _allServiceSites.clear();
  _allPortalStores.clear();
  _allPages.clear();
  _allThemes.clear();
  _allStyles.clear();
  _allDesklets.clear();
  var _portals = buildPortals(_site);
  for (var item in _portals) {
    var portal = item(_site);
    if (_allPortals.containsKey(portal.id)) {
      throw FlutterErrorDetails(exception: Exception('已存在框架:${portal.id}'));
    }
    _allPortals[portal.id] = portal;

    ServiceSite site = ServiceSite(parent: _site);
    await site.init(portal);
    _allServiceSites[portal.id] = site;

    var pages = portal.buildPages(portal, site);
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
    var themes = portal.buildThemes(portal, site);
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
      List<Style> styles = themeStyle.buildStyle(portal, site);
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
    var desklets = portal.buildDesklets(portal, site);
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
///themeUrl必须是带框架名的全路径
ThemeData onGenerateThemeStyle(String themeUrl, BuildContext context) {
  var fullUrl = themeUrl;
  var pos = fullUrl.indexOf('://');
  if (pos < 0) {
    throw FlutterErrorDetails(
        exception: Exception('非法地址请求:$fullUrl。正确格式为：portal://relativeUrl'));
  }
  var portal = fullUrl.substring(0, pos);
  if (_environment.userPrincipal != null) {
    //加载用户个性化主题
    var _storedThemeUrl =
        _sharedPreferences.getString(KEY_THEME_SET, portal: portal);
    if (!StringUtil.isEmpty(_storedThemeUrl)) {
      fullUrl = '$portal:/$_storedThemeUrl';
    }
  }
  ThemeStyle themeStyle = _allThemes[fullUrl];
  if (themeStyle == null) {
    throw FlutterError('未发现主题: $fullUrl');
  }
  _environment.previousPortal = _environment.currentPortal;
  _environment.previousThemeUrl = _environment.currentThemeUrl;
  _environment.currentThemeUrl = themeStyle.url;
  _environment.currentPortal = fullUrl.substring(0, pos);
  return themeStyle.buildTheme(context);
}

Route onGenerateRoute(RouteSettings routeSettings) {
  var url = routeSettings.name;
  if ("/" == url) {
    //在指定初始化路由时如果在路由表中未指定，则flutter会采用默认/来搜索路由,因此要求在指定初始化路由时一定保证路由表中有，由于路由为空（buildRoutes方法），所以出现/这种情况
    throw FlutterError('初始化路由（initialRoute）必须是全路径。');
  }
  String fullUrl;
  if (url.indexOf("://") < 0) {
    fullUrl = '${_environment.currentPortal}:/$url';
  } else {
    fullUrl = url;
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
      var site = _allServiceSites[page.portal];
      PageContext pageContext = PageContext(
        page: page,
        site: site,
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

NavigatorObserver navigatorObserver() {
  return FrameworkNavigatorObserver();
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
    if ('@.environment' == name) {
      return _environment;
    }
    if ('@.framework.events' == name) {
      return onFrameworkEvents;
    }
    if ('@.sharedPreferences' == name) {
      return _sharedPreferences;
    }
    if (name.startsWith('@.prop.')) {
      return _props[name];
    }
    return null;
  }
}

class FrameworkNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    //检查在页面返回时是否需要切换框架
//    print('.......$route.....$previousRoute......');
    super.didPop(route, previousRoute);
    String fullUrl = route.settings.name;
    if (fullUrl == null) {
      return;
    }
    String prevFullUrl = previousRoute.settings.name;

    var portal = '';
    if (prevFullUrl == null) {
      portal = fullUrl.substring(0, fullUrl.indexOf('://'));
    } else {
      portal = prevFullUrl.substring(0, prevFullUrl.indexOf('://'));
    }
    if (fullUrl.startsWith(portal)) {
      //同一框架则不切换
      return;
    }
    if (onFrameworkEvents == null) {
      return;
    }
    //跳转总是前后页间跳，由于每次都在跳入之前记录了前次所以返回时下次的portal一定与previousPortal相同
    var _storeThemeUrl =
        _sharedPreferences.getString(KEY_THEME_SET, portal: portal);
    if (StringUtil.isEmpty(_storeThemeUrl)) {
      onFrameworkEvents(OnFrameworkEvent(
        cmd: 'switchTheme',
        parameters: {
          'portal': _environment.previousPortal,
          'themeUrl': _environment.previousThemeUrl,
        },
      ));
    } else {
      onFrameworkEvents(OnFrameworkEvent(
        cmd: 'switchTheme',
        parameters: {
          'portal': portal,
          'themeUrl': _storeThemeUrl,
        },
      ));
    }
  }

  @override
  void didPush(Route route, Route previousRoute) {
    // TODO: implement didPush
    super.didPush(route, previousRoute);
    if (previousRoute == null) {
      return;
    }
    String fullUrl = route.settings.name;
    if (fullUrl == null) {
      return;
    }
    String prevFullUrl = previousRoute.settings.name;

    var portal = fullUrl.substring(0, fullUrl.indexOf('://'));
    if (prevFullUrl != null && prevFullUrl.startsWith(portal)) {
      //同一框架则不切换
      return;
    }
    if (onFrameworkEvents == null) {
      return;
    }
    if (route.settings.arguments == null) {
      return;
    }
    var themeUrl = (route.settings.arguments as Map)['themeUrl'];
    if (StringUtil.isEmpty(themeUrl)) {
      themeUrl = _sharedPreferences.getString(KEY_THEME_SET, portal: portal);
      if (StringUtil.isEmpty(themeUrl)) {
        if (_environment.previousPortal == portal) {
          themeUrl = _environment.previousThemeUrl;
        }
        if (StringUtil.isEmpty(themeUrl)) {
          return;
        }
      }
    }
    //如果不是当前的框架则切换框架,而且在跳转后再切换
    onFrameworkEvents(OnFrameworkEvent(
      cmd: 'switchTheme',
      parameters: {'themeUrl': themeUrl, 'portal': portal},
    ));
  }
}
