import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_k_chart/utils/date_format_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'errors.dart';

final String KEY_THEME_SET = '@.set.theme';

typedef OnFrameworkEvents = Function(OnFrameworkEvent event);

class Environment {
  String currentPortal = ''; //当前使用的框架
  String currentThemeUrl = ''; //当前应用的主题路径，是相对于当前portal的路径
  String previousPortal = '';
  String previousThemeUrl = '';
  UserPrincipal userPrincipal;

  Environment({
    this.currentPortal,
    this.currentThemeUrl,
    this.userPrincipal,
    this.previousPortal,
    this.previousThemeUrl,
  });
}

class OnFrameworkEvent {
  String cmd;
  Map<String, Object> parameters = Map();

  OnFrameworkEvent({this.cmd, this.parameters});
}

class NetosSharedPreferences {
  SharedPreferences _sharedPreferences;
  IServiceProvider _site;

  Future<NetosSharedPreferences> init(IServiceProvider site) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    this._site = site;
    return this;
  }

//当多用户切换时以/框架/用户号/当前登录账号/作为key持久化前缀，如: /gbera/00200202002/cj/，用于持久账号私有信息，而以/Shared/ 作为多用户的共享目录
  String _getStoreKey(String key,
      {String portal, bool sharedDir = false, bool portalDir = false}) {
    if (sharedDir == null) {
      sharedDir = false;
    }
    if (portalDir == null) {
      portalDir = false;
    }
    Environment environment = _site.getService('@.environment');
    UserPrincipal _principal = environment?.userPrincipal;
    if ((sharedDir) || _principal == null) {
      return '/Shared/$key';
    }

    String theportal =
        StringUtil.isEmpty(portal) ? environment?.currentPortal : portal;
    if (portalDir) {
      return "/$theportal/${StringUtil.isEmpty(key) ? '' : key}";
    }
    String thekey =
        "/$theportal/${_principal.uid}/${_principal.accountName}/${StringUtil.isEmpty(key) ? '' : key}";
    return thekey;
  }

  Future<bool> setStringList(String key, List<String> value,
      {String portal, bool sharedDir, bool portalDir}) {
    return _sharedPreferences.setStringList(
        _getStoreKey(key,
            sharedDir: sharedDir, portalDir: portalDir, portal: portal),
        value);
  }

  Future<bool> setInt(String key, int value,
      {String portal, bool sharedDir, bool portalDir}) {
    return _sharedPreferences.setInt(
        _getStoreKey(key,
            sharedDir: sharedDir, portalDir: portalDir, portal: portal),
        value);
  }

  Future<bool> setDouble(String key, double value,
      {String portal, bool sharedDir, bool portalDir}) {
    return _sharedPreferences.setDouble(
        _getStoreKey(key,
            sharedDir: sharedDir, portalDir: portalDir, portal: portal),
        value);
  }

  Future<bool> setBool(String key, bool value,
      {String portal, bool sharedDir, bool portalDir}) {
    return _sharedPreferences.setBool(
        _getStoreKey(key,
            sharedDir: sharedDir, portalDir: portalDir, portal: portal),
        value);
  }

  Future<bool> setString(String key, String value,
      {String portal, bool sharedDir, bool portalDir}) {
    return _sharedPreferences.setString(
        _getStoreKey(key,
            sharedDir: sharedDir, portalDir: portalDir, portal: portal),
        value);
  }

  List<String> getStringList(String key,
      {String portal, bool sharedDir, bool portalDir}) {
    return _sharedPreferences.getStringList(_getStoreKey(key,
        sharedDir: sharedDir, portalDir: portalDir, portal: portal));
  }

  int getInt(String key, {String portal, bool sharedDir, bool portalDir}) {
    return _sharedPreferences.getInt(_getStoreKey(key,
        sharedDir: sharedDir, portalDir: portalDir, portal: portal));
  }

  double getDouble(String key,
      {String portal, bool sharedDir, bool portalDir}) {
    return _sharedPreferences.getDouble(_getStoreKey(key,
        sharedDir: sharedDir, portalDir: portalDir, portal: portal));
  }

  bool getBool(String key, {String portal, bool sharedDir, bool portalDir}) {
    return _sharedPreferences.getBool(_getStoreKey(key,
        sharedDir: sharedDir, portalDir: portalDir, portal: portal));
  }

  bool containsKey(String key,
      {String portal, bool sharedDir, bool portalDir}) {
    return _sharedPreferences.containsKey(_getStoreKey(key,
        sharedDir: sharedDir, portalDir: portalDir, portal: portal));
  }

  String getString(String key,
      {String portal, bool sharedDir, bool portalDir}) {
    return _sharedPreferences.getString(_getStoreKey(key,
        sharedDir: sharedDir, portalDir: portalDir, portal: portal));
  }

  dynamic get(String key, {String portal, bool sharedDir, bool portalDir}) {
    _sharedPreferences.get(_getStoreKey(key,
        sharedDir: sharedDir, portalDir: portalDir, portal: portal));
  }

  Future<bool> remove(String key,
      {String portal, bool sharedDir, bool portalDir}) {
    return _sharedPreferences.remove(_getStoreKey(key,
        sharedDir: sharedDir, portalDir: portalDir, portal: portal));
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }

  String toString() {
    return _sharedPreferences.toString();
  }

  Future<void> reload() {
    return _sharedPreferences.reload();
  }

  Set<String> getKeys({String portal, bool sharedDir, bool portalDir}) {
    String prefix = _getStoreKey(null,
        sharedDir: sharedDir, portalDir: portalDir, portal: portal);
    Set<String> keys = _sharedPreferences.getKeys();
    Set<String> set = Set();
    for (String k in keys) {
      if (k.startsWith(prefix)) {
        set.add(k);
      }
    }
    return set;
  }
}

class UserPrincipal {
  final String uid;
  final String accountid;
  final String accountName;
  final String appid;
  final String tenantid;
  final List<Map> ucRoles;
  final List<Map> tenantRoles;
  final List<Map> appRoles;

  final String accessToken;

  const UserPrincipal({
    this.uid,
    this.accountid,
    this.accountName,
    this.accessToken,
    this.appid,
    this.tenantid,
    this.ucRoles,
    this.tenantRoles,
    this.appRoles,
  });
}

class Security {
  UserPrincipal _userPrincipal;

  UserPrincipal get userPrincipal => _userPrincipal;

  set userPrincipal(UserPrincipal value) {
    _userPrincipal = value;
  }
}

class ServiceSite implements IServiceProvider {
  IServiceProvider parent;
  Map<String, dynamic> services;
  FloorDatabase database;
  void Function() onready;

  ServiceSite({this.parent, this.services, this.database});

  @override
  getService(String name) {
    if (services != null) {
      var obj = services[name];
      if (obj != null) {
        return obj;
      }
    }
    return parent?.getService(name);
  }
}

class Portal {
  const Portal({
    @required this.id,
    @required this.name,
    @required this.icon,
    @required this.buildDesklets,
    @required this.buildPages,
    @required this.buildThemes,
    @required this.buildPortalStore,
  });

  final BuildPortalStore buildPortalStore;
  final BuildDesklets buildDesklets;
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

//桌面栏
class Desklet {
  final String title;
  final IconData icon;
  final String subtitle;
  final String desc;
  final String url;
  final BuildDesklet buildDesklet;

  @override
  String toString() {
    return '$runtimeType($title $url)';
  }

  Desklet({
    @required this.title,
    @required this.icon,
    this.subtitle,
    this.desc,
    @required this.url,
    @required this.buildDesklet,
  })  : assert(title != null),
        assert(url != null),
        assert(icon != null),
        assert(buildDesklet != null);
}

class Page {
  Page({
    @required this.title,
    @required this.icon,
    this.subtitle,
    this.previousTitle,
    this.desc,
    @required this.url,
    @required this.buildPage,
    @required this.buildRoute,
  })  : assert(title != null),
        assert(url != null),
        assert(buildPage != null || buildRoute != null);
  final String title;
  final IconData icon;
  final String subtitle;
  final String previousTitle;
  final String desc;
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
  final Color iconColor;
  final BuildTheme buildTheme;
  final BuildStyle buildStyle;

  const ThemeStyle({
    @required this.title,
    @required this.url,
    this.desc,
    this.iconColor,
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
      site.getService('@.environment')?.userPrincipal;

  ///真实传过来的参数
  get parameters => ModalRoute.of(context).settings.arguments;

  ///真实传入的地址，特别是在part页中见到的地址实际上是其主页地址，而page才是part页
  String get url => ModalRoute.of(context).settings.name;

  ///存储器
  NetosSharedPreferences sharedPreferences() {
    return site.getService('@.sharedPreferences');
  }

  ///当前框架id
  String currentPortal() {
    return site.getService("@.environment")?.currentPortal;
  }

  ///当前主题url，为相对于框架的地址
  String currentTheme() {
    return site.getService("@.environment")?.currentThemeUrl;
  }

  ///url为样式定义路径，里面不含portalid也不含主题路径；即：样式永远使用的是当前上下文的portal和主题下的样式定义。
  style(String url) {
    if (!url.startsWith("/")) {
      throw FlutterError('路径没有以/开头');
    }
    Map<String, Style> styles = site.getService("@.styles");
    var themeurl = currentTheme();
    if (themeurl.endsWith("/")) {
      themeurl = themeurl.substring(0, themeurl.length - 1);
    }
    var fullurl = '${page.portal}:/${currentTheme()}${url}';
    var style = styles[fullurl]?.get();
    if (style == null) {
      throw FlutterError('样式未被发现:$url，在主题:$themeurl');
    }
    return style;
  }

  Desklet desklet(String deskletUrl) {
    String fullurl = deskletUrl;
    if (fullurl.indexOf("://") < 0) {
      fullurl = '${this.page.portal}:/$deskletUrl';
    }
    Map<String, Desklet> desklets = site.getService("@.desklets");
    return desklets[fullurl];
  }

  ///部件作为页面的界面元素被嵌入，因此不支持页面跳转动画，因为它在调用时不被作为路由页。
  Widget part(String pageUrl, BuildContext context,
      {Map<String, Object> arguments}) {
    Map<String, Page> pages = site.getService("@.pages");
    String fullurl = pageUrl;
    if (fullurl.indexOf("://") < 0) {
      fullurl = '${this.page.portal}:/$pageUrl';
    }
    int pos = fullurl.lastIndexOf('?');
    if (pos > 0) {
      String qs = fullurl.substring(pos + 1, fullurl.length);
      fullurl = fullurl.substring(0, pos);
      if (arguments == null) {
        arguments = Map();
      }
      _parseQureystringAndFillParams(qs, arguments);
    }
    Page page = pages[fullurl];
    if (page == null) return null;
    if (page.buildPage == null) {
      return null;
    }
    if (arguments != null) {
      page.parameters.addAll(arguments);
    }
    PageContext pageContext2 = PageContext(
      page: page,
      site: site,
      context: context,
    );
    Widget widget = page.buildPage(pageContext2);
    return widget;
  }

  _parseQureystringAndFillParams(qs, arguments) {
    while (qs.startsWith(' ')) {
      qs = qs.substring(1, qs.length);
    }
    if (StringUtil.isEmpty(qs)) {
      return;
    }
    int pos = qs.indexOf("&");
    String kv = '';
    if (pos < 0) {
      kv = qs;
      qs = '';
    } else {
      kv = qs.substring(0, pos);
      qs = qs.substring(pos + 1, qs.length);
    }
    pos = kv.indexOf('=');
    String k = '';
    String v = '';
    if (pos < 0) {
      k = kv;
      v = '';
    } else {
      k = kv.substring(0, pos);
      v = kv.substring(pos + 1, kv.length);
    }
    arguments[k] = v;
    if (!StringUtil.isEmpty(qs)) {
      _parseQureystringAndFillParams(qs, arguments);
    }
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
      throw FlutterError(
          '请求行格式错误，缺少uri和protocol，错误请求行为：$hl,合法格式应为：get|post uri http/1.1');
    }
    cmd = hl.substring(0, pos);
    hl = hl.substring(pos + 1, hl.length);
    while (hl.startsWith(" ")) {
      hl = hl.substring(1, hl.length);
    }
    pos = hl.indexOf(" ");
    if (pos < 0) {
      throw FlutterError(
          '请求行格式错误，缺少protocol，错误请求行为：$hl,合法格式应为：get|post uri http/1.1');
    }
    uri = hl.substring(0, pos);
    if (uri.indexOf("://") < 0) {
      throw FlutterError('不是正确的请求地址：${hl},合法格式应为：https://sss/ss/ss?ss=ss');
    }
    hl = hl.substring(pos + 1, hl.length);
    while (hl.startsWith(" ")) {
      hl = hl.substring(1, hl.length);
    }
    while (hl.endsWith(" ")) {
      hl = hl.substring(0, hl.length - 1);
    }
    if (StringUtil.isEmpty(hl)) {
      throw FlutterError('请求行缺少协议:$hl');
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

  Page findPage(String url) {
    Map<String, Page> pages = site.getService("@.pages");
    String fullurl = url;
    if (fullurl.indexOf("://") < 0) {
      fullurl = '${this.page.portal}:/$url';
    }
    return pages[fullurl];
  }

  ///@clearHistoryPageUrl 清除历史路由页，按路径前缀来匹配，如果是/表示清除所有历史
  ///                     注意：如果该参数非空将不能传递result参数给前页
  ///@result 放入返回给前页的结果
  bool backward({
    String clearHistoryPageUrl,
    result,
  }) {
    NavigatorState state = Navigator.of(context);
    if (!state.canPop()) {
      return false;
    }
    if (StringUtil.isEmpty(clearHistoryPageUrl)) {
      return state.pop(result);
    }
    state.popUntil(_checkHistoryRoute(clearHistoryPageUrl));
    return true;
  }

  bool refreshRoot({OnFrameworkEvent event}) {
    OnFrameworkEvents refresh = site.getService('@.framework.events');
    if (refresh == null) return false;
    refresh(event);
    return true;
  }

  ///@pagePath 使用此主题pagePath必须是指定了框架的全路径，主题路径是相对于该框架的路径
  ///@clearHistoryPageUrl 清除历史路由页，按路径前缀来匹配，如果是/表示清除所有历史
  Future<T> forward<T extends Object>(
    String pagePath, {
    String themeUrl,
    Map<String, Object> arguments,
    String clearHistoryPageUrl,
  }) {
    if (pagePath.indexOf("://") < 0) {
      if (!pagePath.startsWith("/")) {
        pagePath = '/$pagePath';
      }
      pagePath = '${page.portal}:/$pagePath';
    }
//如果不是当前的框架则切换框架,而且在跳转后再切换
    if (!pagePath.startsWith(currentPortal())) {
      if (arguments == null) {
        arguments = Map();
      }
      arguments['themeUrl'] = themeUrl;
      //一定设为true，在其后清除上一个框架的历史页，否则会导致上一个框架页刷新而找样式，而此时已启用下一个框架页的样式，导致在下一框架页中找上一个框架样的样式
      //所以框架的切换不能使用历史回退，如果新框架要返回，必须使用forward
      clearHistoryPageUrl = '/';
    }
    dynamic ret;
    if (!StringUtil.isEmpty(clearHistoryPageUrl)) {
      ret = Navigator.of(context).pushNamedAndRemoveUntil(
        pagePath,
//        (route) => route == null,
        _checkHistoryRoute(clearHistoryPageUrl),
        arguments: arguments,
      );
    } else {
      ret = Navigator.pushNamed(
        context,
        pagePath,
        arguments: arguments,
      );
    }

    return ret;
  }

  RoutePredicate _checkHistoryRoute(String url) {
    return (Route<dynamic> route) {
      return !route.willHandlePopInternally &&
          route is ModalRoute &&
          _checkUrl(route, url);
    };
  }

  bool _checkUrl(ModalRoute route, String url) {
    String name = route.settings.name;
    if (StringUtil.isEmpty(name)) {
      return false;
    }
    int pos = name.indexOf('://');
    if (pos < 0) {
      return false;
    }
    String reurl = name.substring(pos + 2, name.length);
    return !reurl.startsWith(url);
  }

  bool switchTheme(String url) {
    String fullurl = url;
    if (fullurl.indexOf("://") < 0) {
      fullurl = '${this.page.portal}:/$url';
    }
    Map<String, ThemeStyle> themes = site.getService("@.themes");
    var theme = themes[fullurl];
    if (themes == null) {
      return false;
    }
    Environment environment = site.getService('@.environment');
    sharedPreferences()
        .setString(KEY_THEME_SET, theme.url, portal: environment.currentPortal);
    //立即刷新界面呈现效果，如果不在此刷新就要等到页面跳转时才生效
    refreshRoot(
        event: OnFrameworkEvent(
      cmd: 'switchTheme',
      parameters: {'themeUrl': theme.url, 'portal': environment.currentPortal},
    ));
    return true;
  }

  //设置登录，方法将根据当前登录用户加载个性化配置
  void setLogin(UserPrincipal userPrincipal) {
    Environment environment = site.getService('@.environment');
    environment.userPrincipal = userPrincipal;
    OnFrameworkEvents events = site.getService('@.framework.events');
    events(OnFrameworkEvent(
      cmd: 'switchTheme',
      parameters: {
        'portal': environment.currentPortal,
        'themeUrl': environment.currentThemeUrl,
      },
    ));
  }
}

class Portlet {
  final String id;
  final String title;
  final String imgSrc;
  final String subtitle;
  final String desc;

  ///渲染门户栏目由桌面栏目渲染
  final String deskletUrl;
  final Map<String, String> props = {};

  Portlet({
    @required this.id,
    @required this.title,
    this.imgSrc,
    this.subtitle,
    this.desc,
    @required this.deskletUrl,
  })  : assert(id != null),
        assert(title != null),
        assert(deskletUrl != null);

  Widget build({
    @required PageContext context,
  }) {
    if (context == null) {
      throw FlutterError('缺少必选参数');
    }
    var desklet = context.desklet(deskletUrl);
    if (desklet == null) {
      debugPrint('桌面栏目未定义:' + deskletUrl);
      return null;
    }
    return desklet.buildDesklet(this, desklet, context);
  }

  toMap() {
    var map = {};
    map['id'] = id;
    map['title'] = title;
    map['imgSrc'] = imgSrc;
    map['subtitle'] = subtitle;
    map['desc'] = desc;
    map['deskletUrl'] = deskletUrl;
//    map['props']=this.props;
    return map;
  }
}

class PortalStore {
  Map<String, dynamic> services;
  Future<FloorDatabase> Function() loadDatabase;

  PortalStore({this.services, this.loadDatabase});
}

typedef BuildPage = Widget Function(PageContext pageContext);
typedef BuildRoute = ModalRoute Function(
    RouteSettings settings, Page page, IServiceProvider site);
typedef BuildPortal = Portal Function(IServiceProvider site);
typedef BuildPortalStore = PortalStore Function(
    Portal protal, IServiceProvider site);
typedef BuildPages = List<Page> Function(Portal protal, IServiceProvider site);
typedef BuildThemes = List<ThemeStyle> Function(
    Portal protal, IServiceProvider site);
typedef BuildDesklets = List<Desklet> Function(
    Portal protal, IServiceProvider site);
typedef BuildDesklet = Widget Function(
    Portlet portlet, Desklet desklet, PageContext desktopContext);
