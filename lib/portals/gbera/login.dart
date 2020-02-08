import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/entities.dart';
import 'package:gbera/portals/gbera/store/pics/downloads.dart';
import 'package:gbera/portals/gbera/store/services/local_principals.dart';
import 'package:uuid/uuid.dart';

class LoginPage extends StatefulWidget {
  PageContext context;

  LoginPage({this.context});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  _LoginMethod _loginMethod = _LoginMethod.password;
  List<Principal> _localPrincipals = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ILocalPrincipalManager _localPrincipalManager =
        widget.context.site.getService('/local/principals');
    List<String> list = _localPrincipalManager.list();
    for (String person in list) {
      _localPrincipals.add(_localPrincipalManager.get(person));
    }
    if (!_localPrincipals.isEmpty && _localPrincipals[0].accessToken != null) {
      _loginMethod = _LoginMethod.existsAccount;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var method;

    ///检测本地存有头像和账号则按第3种模式显示（_LoginMethod.existsAccount)
    switch (_loginMethod) {
      case _LoginMethod.password:
        method = _PasswordPanel(
          context: widget.context,
          onSwitchToVerifyCode: () {
            _loginMethod = _LoginMethod.verifyCode;
            setState(() {});
          },
        );
        break;
      case _LoginMethod.verifyCode:
        method = _VerifyCodePanel(
          context: widget.context,
          onSwitchToPassword: () {
            if (_localPrincipals.isEmpty) {
              _loginMethod = _LoginMethod.password;
            } else {
              _loginMethod = _LoginMethod.existsAccount;
            }
            setState(() {});
          },
        );
        break;
      case _LoginMethod.existsAccount:
        method = _ExistsAccountPanel(
          context: widget.context,
          principals: _localPrincipals,
          onSwitchToVerifyCode: () {
            _loginMethod = _LoginMethod.verifyCode;
            setState(() {});
          },
        );
        break;
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          method,
          Positioned(
            bottom: 0,
            left: 10,
            right: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Text.rich(
                    TextSpan(
                      text: '金证时代中国公司',
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          widget.context.forward('/system/about');
                        },
                    ),
                  ),
                ),
                /*
                FlatButton(
                  child: Text('找回密码'),
                  textColor: Colors.blueGrey,
                  onPressed: () {},
                ),
                SizedBox(
                  height: 14,
                  child: VerticalDivider(
                    width: 1,
                    color: Colors.grey[500],
                  ),
                ),
                FlatButton(
                  child: Text('紧急冻结'),
                  textColor: Colors.blueGrey,
                  onPressed: () {},
                ),

                 */
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _LoginMethod {
  password,
  verifyCode,
  existsAccount,
}

class _PasswordPanel extends StatefulWidget {
  Function() onSwitchToVerifyCode;
  PageContext context;

  _PasswordPanel({this.onSwitchToVerifyCode, this.context});

  @override
  __PasswordPanelState createState() => __PasswordPanelState();
}

class __PasswordPanelState extends State<_PasswordPanel> {
  TextEditingController _accountController;
  TextEditingController _passwordController;
  bool _buttonEnabled = false;
  bool _showPassword = false;

  @override
  void initState() {
    _accountController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    _buttonEnabled = false;
    super.dispose();
  }

  bool _checkRegister() {
    return !StringUtil.isEmpty(_passwordController.text) &&
        !StringUtil.isEmpty(_accountController.text);
  }

  _doLogin() {
    var login = PasswordLoginAction(
        context: widget.context,
        pwd: _passwordController.text,
        user: _accountController.text);
    login.login();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          height: 100,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            left: 20,
          ),
          child: Text(
            '公号/手机号/用户号/邮箱登录',
            softWrap: true,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
            top: 10,
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 70,
                child: Text(
                  '账号',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _accountController,
                  onChanged: (v) {
                    _buttonEnabled = _checkRegister();
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '请填写公号/手机号/用户号/邮箱',
                    hintStyle: TextStyle(
                      fontSize: 16,
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
            top: 10,
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 70,
                child: Text(
                  '密码',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _passwordController,
                  onChanged: (v) {
                    _buttonEnabled = _checkRegister();
                    setState(() {});
                  },
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '请填写密码',
                    hintStyle: TextStyle(
                      fontSize: 16,
                    ),
                    contentPadding: EdgeInsets.all(10),
                    suffix: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _showPassword = !_showPassword;
                        setState(() {});
                      },
                      child: Icon(
                        !_showPassword
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
            top: 10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 30),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: widget.onSwitchToVerifyCode,
                  child: Text(
                    '用短信验证码登录',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: !_buttonEnabled
              ? null
              : () {
                  _doLogin();
                },
          child: Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _buttonEnabled ? Colors.green[300] : Colors.grey[300],
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: Text(
              '登录',
              style: TextStyle(
                fontSize: 18,
                color: _buttonEnabled ? Colors.white : Colors.grey[500],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _VerifyCodePanel extends StatefulWidget {
  PageContext context;
  Function() onSwitchToPassword;

  _VerifyCodePanel({this.context, this.onSwitchToPassword});

  @override
  __VerifyCodePanelState createState() => __VerifyCodePanelState();
}

class __VerifyCodePanelState extends State<_VerifyCodePanel> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          height: 100,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            left: 20,
          ),
          child: Text(
            '手机号登录',
            softWrap: true,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
            top: 10,
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 70,
                child: Text(
                  '手机号',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '请填写手机号',
                    hintStyle: TextStyle(
                      fontSize: 16,
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
            top: 10,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 70,
                      child: Text(
                        '验证码',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '请填写短信验证码',
                          hintStyle: TextStyle(
                            fontSize: 16,
                          ),
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 7,
                    bottom: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    '获取验证码',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
            top: 10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 30),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: widget.onSwitchToPassword,
                  child: Text(
                    '用密码登录',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: Text(
              '登录',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[500],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ExistsAccountPanel extends StatefulWidget {
  Function() onSwitchToVerifyCode;
  PageContext context;
  List<Principal> principals;

  _ExistsAccountPanel(
      {this.onSwitchToVerifyCode, this.context, this.principals});

  @override
  __ExistsAccountPanelState createState() => __ExistsAccountPanelState();
}

class __ExistsAccountPanelState extends State<_ExistsAccountPanel> {
  TextEditingController _passwordController;
  bool _buttonEnabled = false;
  bool _showPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var principal = widget.principals[0];
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 30,
            top: 30,
          ),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                child: Image.file(
                  File(principal.lavatar),
                  width: 70,
                  height: 70,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  '${principal.nickName}',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
            top: 10,
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 70,
                child: Text(
                  '密码',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _passwordController,
                  onChanged: (v) {
                    _buttonEnabled = !StringUtil.isEmpty(v);
                    setState(() {});
                  },
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '请填写密码',
                    hintStyle: TextStyle(
                      fontSize: 16,
                    ),
                    contentPadding: EdgeInsets.all(10),
                    suffix: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _showPassword = !_showPassword;
                        setState(() {});
                      },
                      child: Icon(
                        !_showPassword
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
            top: 10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 30),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: widget.onSwitchToVerifyCode,
                  child: Text(
                    '用短信验证码登录',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: !_buttonEnabled
              ? null
              : () {
                  _doLogin(principal);
                },
          child: Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _buttonEnabled ? Colors.green[300] : Colors.grey[300],
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: Text(
              '登录',
              style: TextStyle(
                fontSize: 18,
                color: _buttonEnabled ? Colors.white : Colors.grey[500],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _doLogin(Principal principal) async {
    var login = PasswordLoginAction(
      context: widget.context,
      pwd: _passwordController.text,
      user: principal.accountCode,
    );
    login.login();
  }
}

class PasswordLoginAction {
  final String user;
  final String pwd;
  final PageContext context;

  const PasswordLoginAction({this.user, this.pwd, this.context});

  login() {
    int pos = user.lastIndexOf("@");
    var account = '';
    if (pos < 0) {
      account = user;
    } else {
      account = user.substring(0, pos);
    }
    AppKeyPair appKeyPair = this.context.site.getService('@.appKeyPair');
    var nonce = MD5Util.generateMd5(Uuid().v1());
    context.ports(
      'get http://47.105.165.186/uc/auth.service http/1.1',
      restCommand: 'auth',
      headers: {
        'app-id': appKeyPair.appid,
        'app-key': appKeyPair.appKey,
        'app-nonce': nonce,
        'app-sign': appKeyPair.appSign(nonce),
      },
      parameters: {
        "accountCode": account,
        "password": pwd,
        "device": appKeyPair.device,
      },
      onsucceed: ({dynamic rc, dynamic response}) {
        forwardOK(rc);
      },
      onerror: ({e, stack}) {
        forwardError(e);
      },
      onReceiveProgress: (i, j) {
        print('$i-$j');
      },
    );
  }

  void forwardOK(rc) async {
    var map = jsonDecode(rc['dataText']);

    Map<String, dynamic> subject = map['subject'];
    Map<String, dynamic> token = map['token'];

    ILocalPrincipalManager manager =
        context.site.getService('/local/principals');
    var list = subject['roles'];
    var roles = <String>[];
    for (var r in list) {
      roles.add(r);
    }
    Dio dio = context.site.getService('@.http');
    String localAvatarFile = await Downloads.downloadPersonAvatar(
        dio: dio, avatarUrl: '${subject['avatar']}?accessToken=${token['accessToken']}');
    manager.add(
      subject['person'],
      ltime: DateTime.now().millisecondsSinceEpoch,
      expiretime: token['expireTime'],
      pubtime: token['pubTime'],
      signature: subject['signature'],
      remoteAvatar: '${subject['avatar']}',
      localAvatar: localAvatarFile,
      refreshToken: token['refreshToken'],
      accessToken: token['accessToken'],
      roles: roles,
      appid: subject['appid'],
      nickName: subject['nickName'],
      accountCode: subject['accountCode'],
      uid: subject['uid'],
    );
    manager.setCurrent(subject['person']);
    context.setLogin();
    context.forward("gbera://scaffold/withbottombar", clearHistoryPageUrl: '/');
  }

  void forwardError(e) {
    context.forward(
      "gbera://error",
      arguments: {
        'error': e,
      },
    );
//    context.forward("gbera://error.page", arguments: {"error": '$e'});
  }
}
