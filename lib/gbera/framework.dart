import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../portals/portals.dart';
import 'common.dart';

Map<String, Portal> _allPortals = Map(); //key是portalid
Map<String, Page> _allPages = Map(); //key是全路径
IServiceProvider _site = GberaServiceProvider();

Map<String, WidgetBuilder> buildRoutes() {
  _allPortals.clear();
  _allPages.clear();
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
      _allPages[fullurl] = page;
    }
  }
  return Map(); //仅仅将它当作初始化事件使用，所以直接返回空map，当然也可以为map添加一些初始化的全局页面，比如错误页面
}

Route onGenerateRoute(RouteSettings routeSettings) {
  var fullUrl = routeSettings.name;
  if (fullUrl.indexOf("://") < 0) {
    throw FlutterErrorDetails(
        exception: Exception(
            '非法地址请求。正确格式为：portal://relativeUrl?key=value&key2=value2'));
  }
  Page page = _allPages[fullUrl];
  if (page == null) {
    return null;
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
  return MaterialPageRoute(
    settings: routeSettings.copyWith(
        name: fullUrl, arguments: args, isInitialRoute: false),
    builder: (BuildContext buildContext) {
      PageContext pageContext = PageContext(
        page: page,
        site: _site,
        context: buildContext,
      );
      return page.buildRoute(buildContext, pageContext);
    },
  );
}

Route onUnknownRoute(RouteSettings settings) {
  return null;
}

BaseOptions options = BaseOptions(headers: {
  'Content-Type': "text/html; charset=utf-8",
});
var _dio = Dio(options); //使用base配置可以通

class GberaServiceProvider implements IServiceProvider {
  @override
  getService(String name) {
    if("@.http"==name){
      return _dio;
    }
    if ("@.portals" == name) {
      return _allPortals;
    }
    if ("@.pages" == name) {
      return _allPages;
    }
    return null;
  }
}
