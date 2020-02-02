import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class LoginPage3 extends StatefulWidget {
  PageContext context;

  LoginPage3({this.context});

  @override
  _LoginPage3State createState() => _LoginPage3State();
}

class _LoginPage3State extends State<LoginPage3> {
  _LoginMethod _loginMethod = _LoginMethod.password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            _loginMethod = _LoginMethod.password;
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
  _doLogin(){
    var login = PasswordLoginAction(
        context: widget.context, pwd: _passwordController.text, user: _accountController.text);
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
                    _buttonEnabled=_checkRegister();
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
                    _buttonEnabled=_checkRegister();
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '请填写密码',
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


class PasswordLoginAction {
  final String user;
  final String pwd;
  final PageContext context;

  const PasswordLoginAction({this.user, this.pwd, this.context});

  login() {
    int pos = user.lastIndexOf("@");
    var account = '';
    var appid = '';
    if (pos < 0) {
      account = user;
    } else {
      account = user.substring(0, pos);
      appid = user.substring(pos + 1, user.length);
    }
    if (appid == null || appid == '') {
      appid = 'gbera';
    }
    context.ports(
      'get http://47.105.165.186/uc/auth?appid=$appid http/1.1',
      restCommand: 'auth',
      parameters: {
        "accountName": account,
        "password": pwd,
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

  void forwardOK(rc) {
    var map = jsonDecode(rc['dataText']);

    List<Map> appRoles = [];
    List<Map> tenantRoles = [];
    List<Map> ucRoles = [];
    List _appRoles = map['appRoles'];
    _appRoles.forEach((value) {
      appRoles.add(value);
    });
    List _tenantRoles = map['tenantRoles'];
    _tenantRoles.forEach((value) {
      tenantRoles.add(value);
    });
    List _ucRoles = map['ucRoles'];
    _ucRoles.forEach((value) {
      ucRoles.add(value);
    });
    UserPrincipal userPrincipal = UserPrincipal(
      uid: map['uid'],
      accessToken: map['accessToken'],
      accountid: map['accountid'],
      accountName: map['accountName'],
      appid: map['appid'],
      tenantid: map['tenantid'],
      appRoles: appRoles,
      tenantRoles: tenantRoles,
      ucRoles: ucRoles,
      avatar: map['avatar'],
      nickName: map['nickName'],
      signature: map['signature'],
    );

    context.setLogin(userPrincipal);
    context.forward("gbera://scaffold/withbottombar",
        clearHistoryPageUrl: '/');
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
