import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'errors.dart';

class UserPrincipal {
  final String uid;
  final String accountid;
  final String accountName;
  final String appid;
  final List<Map> ucRoles;
  final List<Map> tenantRoles;
  final List<Map> appRoles;

  const UserPrincipal(
      {this.uid,
      this.accountid,
      this.accountName,
      this.appid,
      this.ucRoles,
      this.tenantRoles,
      this.appRoles});
}

class Security {
  UserPrincipal _userPrincipal;

  UserPrincipal get userPrincipal => _userPrincipal;

  set userPrincipal(UserPrincipal value) {
    _userPrincipal = value;
  }
}

class Portal {
  const Portal({
    @required this.id,
    @required this.name,
    @required this.icon,
    @required this.buildPages,
    @required this.buildThemes,
  });

  final BuildThemes buildThemes;
  final BuildPages buildPages;
  final String id;
  final String name;
  final IconData icon;

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Portal typedOther = other;
    return typedOther.id == id &&
        typedOther.name == name &&
        typedOther.icon == icon;
  }

  @override
  int get hashCode => hashValues(id, name, icon);

  @override
  String toString() {
    return '$runtimeType($id)';
  }
}

class Page {
  Page({
    @required this.title,
    @required this.icon,
    this.subtitle,
    @required this.url,
    @required this.buildPage,
    @required this.buildRoute,
  })  : assert(title != null),
        assert(url != null),
        assert(buildPage != null || buildRoute != null);
  final String title;
  final IconData icon;
  final String subtitle;

  Map<String, Object> _parameters;
  String _portal;

  ///构建页面。如果使用自定义动画则必须使用buildRoute，两个方法必有一个非空；当二者均有实现时则优先buildRoute
  final BuildPage buildPage;

  ///构建路由。如果使用自定义动画则必须使用buildRoute，两个方法必有一个非空；当二者均有实现时则优先buildRoute
  final BuildRoute buildRoute;
  final String url;

  String get portal => _portal;

  @override
  String toString() {
    return '$runtimeType($title $url)';
  }

  void _parseParams(String qs) {
    int pos = qs.indexOf("&");
    var remaining = '';
    var kv = '';
    if (pos < 0) {
      kv = qs;
    } else {
      kv = qs.substring(0, pos);
      remaining = qs.substring(pos + 1, qs.length);
    }
    while (kv.startsWith(" ")) {
      kv = kv.substring(1, kv.length);
    }
    pos = kv.indexOf("=");
    var k = '';
    var v = '';
    if (pos < 0) {
      k = kv;
    } else {
      k = kv.substring(0, pos);
      v = kv.substring(pos + 1, kv.length);
    }
    while (v.startsWith(" ")) {
      v = v.substring(1, v.length);
    }
    while (v.endsWith(" ")) {
      v = v.substring(0, v.length - 1);
    }
    _parameters[k] = v;
    if (!StringUtil.isEmpty(remaining)) {
      _parseParams(remaining);
    }
  }

  Map<String, Object> get parameters => _parameters;

  void $__init(String portalid, String qs) {
    _parameters = Map();
    _portal = portalid;
    if (!StringUtil.isEmpty(qs)) {
      _parseParams(qs);
    }
  }
}

typedef BuildTheme = ThemeData Function(BuildContext context);
typedef BuildStyle = List<Style> Function(BuildContext context);

class ThemeStyle {
  final String url;
  final String title;
  final String desc;
  final BuildTheme buildTheme;
  final BuildStyle buildStyle;

  const ThemeStyle({
    @required this.title,
    @required this.url,
    this.desc,
    @required this.buildTheme,
    @required this.buildStyle,
  })  : assert(title != null),
        assert(url != null),
        assert(buildTheme != null),
        assert(buildStyle != null);
}

typedef GetStyle = Function();

class Style {
  final String url;
  final String desc;
  final GetStyle get;

  const Style({
    @required this.url,
    this.desc,
    @required this.get,
  })  : assert(url != null),
        assert(get != null);
}

mixin StringUtil {
  static bool isEmpty(String qs) {
    return qs == null || '' == qs;
  }
}

mixin IServiceProvider {
  getService(String name);
}

class PageContext {
  final Page page;
  final IServiceProvider site;
  final BuildContext context;

  const PageContext({this.page, this.site, this.context});

  UserPrincipal get userPrincipal =>
      site.getService('@.security')?.userPrincipal;

  ///真实传过来的参数
  get parameters => ModalRoute.of(context).settings.arguments;
  ///真实传入的地址
  String get url => ModalRoute.of(context).settings.name;

  Future<T> forward<T extends Object>(
    String pagePath, {
    Map<String, Object> arguments,
    bool notManagerPreviousPage,
  }) {
    if (pagePath.indexOf("://") < 0) {
      if (!pagePath.startsWith("/")) {
        pagePath = '/$pagePath';
      }
      pagePath = '${page.portal}:/$pagePath';
    }
    var ret = Navigator.pushNamed(context, pagePath, arguments: arguments);
    if (notManagerPreviousPage != null && notManagerPreviousPage) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        pagePath,
        (route) => route == null,
      );
    }
    return ret;
  }

  String themeUrl() {
    return site.getService("@.current.theme");
  }

  ///url为样式定义路径，里面不含portalid也不含主题路径；即：样式永远使用的是当前上下文的portal和主题下的样式定义。
  style(String url) {
    if (!url.startsWith("/")) {
      throw FlutterError('路径没有以/开头');
    }
    Map<String, Style> styles = site.getService("@.styles");
    var themeurl = themeUrl();
    if (themeurl.endsWith("/")) {
      themeurl = themeurl.substring(0, themeurl.length - 1);
    }
    var fullurl = '${page.portal}:/${themeUrl()}${url}';
    var style = styles[fullurl]?.get();
    if (style == null) {
      throw FlutterError('样式未被发现:$url，在主题:$themeurl');
    }
    return style;
  }

  ///部件作为页面的界面元素被嵌入，因此不支持页面跳转动画，因为它在调用时不被作为路由页。
  Widget part(String pageUrl, PageContext pageContext) {
    Map<String, Page> pages = site.getService("@.pages");
    Page page = pages[pageUrl];
    if (page == null) return null;
    if (page.buildPage == null) {
      return null;
    }
    page._parameters['From-Page-Url'] = pageContext.page.url;
    PageContext pageContext2 = PageContext(
      page: page,
      site: site,
      context: pageContext.context,
    );
    Widget widget = page.buildPage(pageContext2);
    return widget;
  }

  ports(
    ///请求头，格式，如：get http://localhost:8080/uc/p1.service?name=cj&age=33 http/1.1
    String headline, {

    ///远程服务的方法名
    String restCommand,
    Map<String, String> headers,
    Map<String, String> parameters,
    Map<String, Object> content,
    void Function({dynamic rc, dynamic response}) onsucceed,
    void Function({dynamic e, dynamic stack}) onerror,
    void Function(int, int) onReceiveProgress,
    void Function(int, int) onSendProgress,
  }) async {
    String cmd = '';
    String uri = '';
    String protocol = '';
    String hl = headline;
    while (hl.startsWith(" ")) {
      hl = hl.substring(1, hl.length);
    }
    int pos = hl.indexOf(" ");
    if (pos < 0) {
      throw FlutterErrorDetails(
          exception: Exception(
              '请求行格式错误，缺少uri和protocol，错误请求行为：$hl,合法格式应为：get|post uri http/1.1'));
    }
    cmd = hl.substring(0, pos);
    hl = hl.substring(pos + 1, hl.length);
    while (hl.startsWith(" ")) {
      hl = hl.substring(1, hl.length);
    }
    pos = hl.indexOf(" ");
    if (pos < 0) {
      throw FlutterErrorDetails(
          exception: Exception(
              '请求行格式错误，缺少protocol，错误请求行为：$hl,合法格式应为：get|post uri http/1.1'));
    }
    uri = hl.substring(0, pos);
    if (uri.indexOf("://") < 0) {
      throw FlutterErrorDetails(
          exception:
              Exception('不是正确的请求地址：${hl},合法格式应为：https://sss/ss/ss?ss=ss'));
    }
    hl = hl.substring(pos + 1, hl.length);
    while (hl.startsWith(" ")) {
      hl = hl.substring(1, hl.length);
    }
    while (hl.endsWith(" ")) {
      hl = hl.substring(0, hl.length - 1);
    }
    if (StringUtil.isEmpty(hl)) {
      throw FlutterErrorDetails(exception: Exception('请求行缺少协议:$hl'));
    }
    protocol = hl;

    Dio _dio = site.getService("@.http");
    Options options = Options(
      headers: headers,
    );
    options.headers['Rest-Command'] = restCommand;
    cmd = cmd.toUpperCase();
    switch (cmd) {
      case 'GET':
        try {
          var response = await _dio.get(
            uri,
            queryParameters: parameters,
            onReceiveProgress: onReceiveProgress,
            options: options,
          );
          var data = response.data;
          Map<String, Object> rc = jsonDecode(data);
          int status = rc['status'];
          if ((status >= 200 && status < 300) || status == 304) {
            if (onsucceed != null) {
              onsucceed(rc: rc, response: response);
            }
          } else {
            if (onerror != null) {
              onerror(
                  e: OpenportsException(
                    state: status,
                    message: rc['message'],
                    cause: rc['dataText'],
                  ),
                  stack: null);
            }
          }
        } on DioError catch (e, stack) {
          if (e.response != null) {
            // Something happened in setting up or sending the request that triggered an Error
            if (onerror != null) {
              onerror(e: e, stack: stack);
              return;
            }
            FlutterErrorDetails details =
                FlutterErrorDetails(exception: e, stack: stack);
            FlutterError.reportError(details);
            return;
          }
          throw FlutterError(e.error);
        }
        break;
      case 'POST':
        options.headers['Content-Type'] =
            'application/x-www-form-urlencoded; charset=UTF-8';
        try {
          var response = await _dio.post(
            uri,
            data: content ?? json.encode(content),
            queryParameters: parameters,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
            options: options,
          );
          var data = response.data;
          Map<String, Object> rc = jsonDecode(data);
          int status = rc['status'];
          if ((status >= 200 && status < 300) || status == 304) {
            if (onsucceed != null) {
              var dataText = jsonDecode(rc['dataText']);
              onsucceed(rc: rc, response: response);
            }
          } else {
            if (onerror != null) {
              onerror(
                  e: OpenportsException(
                    state: status,
                    message: rc['message'],
                    cause: rc['dataText'],
                  ),
                  stack: null);
            }
          }
        } on DioError catch (e, stack) {
          if (e.response != null) {
            // Something happened in setting up or sending the request that triggered an Error
            if (onerror != null) {
              onerror(e: e, stack: stack);
              return;
            }
            FlutterErrorDetails details =
                FlutterErrorDetails(exception: e, stack: stack);
            FlutterError.reportError(details);
            return;
          }
          throw FlutterError(e.error);
        }
        break;
      default:
        throw FlutterErrorDetails(exception: Exception('不支持的命令:$cmd'));
    }
  }

  Page findPage(String fullUrl) {
    Map<String, Page> pages = site.getService("@.pages");
    return pages[fullUrl];
  }
}

typedef BuildPage = Widget Function(PageContext pageContext);
typedef BuildRoute = ModalRoute Function(
    RouteSettings settings, Page page, IServiceProvider site);
typedef BuildPortal = Portal Function(IServiceProvider site);
typedef BuildPages = List<Page> Function(Portal protal, IServiceProvider site);
typedef BuildThemes = List<ThemeStyle> Function(
    Portal protal, IServiceProvider site);
