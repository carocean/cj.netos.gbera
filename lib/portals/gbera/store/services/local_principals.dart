import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/entities.dart';
import 'package:gbera/portals/gbera/store/services.dart';
import 'package:uuid/uuid.dart';

mixin ILocalPrincipalManager {
  //在IPrincipalService的构造中初始化
  Principal get(String person);

  void remove(String person);

  List<String> list();

  String current();

  void setCurrent(String person) {}

  bool isEmpty();

  //请求远程刷新token并存储
  Future<void> doRefreshToken();

  //刷入信息到本地
  void add(
    final String person, {
    final String uid,
    final String accountCode,
    final String nickName,
    final String appid,
    final List<String> roles,
    final String accessToken,
    final String refreshToken,
    final String remoteAvatar,
    final String localAvatar,
    final String signature,
    final int ltime,
    final int pubtime,
    final int expiretime,
    final String device,
  }) {}
}

class DefaultLocalPrincipalManager implements ILocalPrincipalManager {
  IPrincipalService _principalService;
  Map<String, Principal> _cached = {};
  List<String> _indexed = [];
  String _current;
  IServiceProvider _site;

  DefaultLocalPrincipalManager({ServiceSite site}) {
    _site = site;
    site.onready.add(() async {
      _principalService = site.getService('/principals');
      await init();
    });
  }

  init() async {
    List<Principal> list = await _principalService.getAll();
    for (var p in list) {
      _cached[p.person] = p;
      _indexed.add(p.person);
    }
  }

  @override
  String current() {
    return _current;
  }

  @override
  Future<void> doRefreshToken() async {
    Dio dio = _site.getService('@.http');
    AppKeyPair appKeyPair = _site.getService('@.appKeyPair');
    //强制刷新所有账户的访问令牌
    String person = _current;
    Principal principal = await _principalService.get(person);
    var appNonce = MD5Util.generateMd5(Uuid().v1()).toUpperCase();
    var response = await dio
        .post(
      'http://47.105.165.186/uc/auth.service',
      queryParameters: {
        'refreshToken': principal.refreshToken,
      },
      options: Options(
        headers: {
          'rest-command': 'refreshToken',
          'app-id': appKeyPair.appid,
          'app-key': appKeyPair.appKey,
          'app-nonce': appNonce,
          'app-sign': appKeyPair.appSign(appNonce),
        },
      ),
    )
        .catchError((e) {
      print(e);
    });
    if (response.statusCode >= 400) {
      print('刷新失败：${response.statusCode} ${response.statusMessage}');
      return;
    }
    var data = response.data;
    var map = jsonDecode(data);
    if (map['status'] as int >= 400) {
      print('刷新失败：${map['status']} ${map['message']}');
      return;
    }
    var json = map['dataText'];
    var result = jsonDecode(json);
    String accessToken = result['accessToken'];
    String refreshToken = result['refreshToken'];
    await _principalService.updateToken(refreshToken, accessToken, person);
    //更新缓冲
    Principal exists = _cached[person];
    var createone = Principal(
      exists.person,
      exists.uid,
      exists.accountCode,
      exists.nickName,
      exists.appid,
      exists.roles,
      accessToken,
      refreshToken,
      exists.ravatar,
      exists.lavatar,
      exists.signature,
      exists.ltime,
      exists.pubtime,
      exists.expiretime,
      exists.device,
    );
    _cached[createone.person] = createone;
  }

  @override
  Principal get(String person) {
    return _cached[person];
  }

  @override
  void add(String person,
      {String uid,
      String accountCode,
      String nickName,
      String appid,
      List<String> roles,
      String accessToken,
      String refreshToken,
      String remoteAvatar,
      String localAvatar,
      String signature,
      int ltime,
      int pubtime,
      int expiretime,
      String device}) {
    var p = Principal(
        person,
        uid,
        accountCode,
        nickName,
        appid,
        jsonEncode(roles ?? []),
        accessToken,
        refreshToken,
        remoteAvatar,
        localAvatar,
        signature,
        ltime,
        pubtime,
        expiretime,
        device);

    _cached[p.person] = p;
    if (!_indexed.contains(p.person)) {
      _indexed.add(p.person);
    }
    _flushOne(p);
  }

  @override
  bool isEmpty() {
    return _cached.isEmpty;
  }

  @override
  List<String> list() {
    return _indexed.toList();
  }

  @override
  void remove(String person) {
    _cached.remove(person);
    _indexed.remove(person);
    if (_current == person) {
      _current = null;
    }
  }

  @override
  void setCurrent(String person) {
    _current = person;
    Environment environment = _site.getService('@.environment');
    UserPrincipal userPrincipal = UserPrincipal(
      manager: this,
    );
    environment.principal = userPrincipal;
  }

  Future<void> _flushOne(Principal p) async {
    Principal exists = await _principalService.get(p.person);
    if (exists != null) {
      _principalService.remove(p.person);
    }
    _principalService.add(p);
  }
}
