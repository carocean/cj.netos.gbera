import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';

class RegisterPage extends StatefulWidget {
  PageContext context;

  RegisterPage({this.context});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _agree = true;
  TextEditingController _nickNameController;
  TextEditingController _phoneController;
  TextEditingController _passwordController;
  String _avatarRemoteFile;
  bool _buttonEnabled = false;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _nickNameController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nickNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _buttonEnabled = false;
    _showPassword = false;
    super.dispose();
  }

  bool _checkRegister() {
    return !StringUtil.isEmpty(_avatarRemoteFile) &&
        !StringUtil.isEmpty(_nickNameController.text) &&
        !StringUtil.isEmpty(_phoneController.text) &&
        !StringUtil.isEmpty(_passwordController.text) &&
        _agree;
  }

  Future<void> _doRegister() async {
    await widget.context.ports(
      'post http://47.105.165.186/uc/register/ http/1.1',
      restCommand: 'registerByIphone',
      parameters: {
        'appid': 'gbera',
        'phone': _phoneController.text,
        'password': _passwordController.text,
        'nickName': _nickNameController.text,
        'avatar': _avatarRemoteFile,
      },
      onerror: ({e, stack}) {
        widget.context.deleteRemoteFile(_avatarRemoteFile);
        print('-----$e');
      },
      onsucceed: ({rc, response}) {
        print('-----$response');
        widget.context.forward('/login3');
        _buttonEnabled=false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: ListView(
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
              '手机号注册',
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
                Expanded(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 70,
                        child: Text(
                          '昵称',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _nickNameController,
                          onChanged: (v) {
                            _buttonEnabled = _checkRegister();
                            setState(() {});
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '例如：狗丢儿',
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
                _AvatarRegion(
                  context: widget.context,
                  onAfterUpload: (avatarFile) {
                    _avatarRemoteFile = avatarFile;
                  },
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
                    '手机号',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    onChanged: (v) {
                      _buttonEnabled = _checkRegister();
                      setState(() {});
                    },
                    keyboardType: TextInputType.phone,
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
                    keyboardType: TextInputType.text,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Checkbox(
                  value: _agree,
                  onChanged: (v) {
                    _agree = v;
                    _buttonEnabled = _checkRegister();
                    setState(() {});
                  },
                ),
                Text.rich(
                  TextSpan(
                    text: '已阅读并同意',
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                    children: [
                      TextSpan(
                        text: '《软件许可及服务协议》',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            widget.context.forward('/system/user/contract');
                          },
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
                    _doRegister();
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
                '注册',
                style: TextStyle(
                  fontSize: 18,
                  color: _buttonEnabled ? Colors.white : Colors.grey[500],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarRegion extends StatefulWidget {
  PageContext context;
  Function(String avatarFile) onAfterUpload;

  _AvatarRegion({this.onAfterUpload, this.context});

  @override
  __AvatarRegionState createState() => __AvatarRegionState();
}

class __AvatarRegionState extends State<_AvatarRegion> {
  String _avatarFile;
  String _per;

  Future<String> _doUploadAvatar(String avatarFile) async {
    var dir = '/public';
    var map = await widget.context.upload(dir, <String>[avatarFile],
        appid: 'gbera',
        accessToken:
            'eyJhbGciOiJIUzI1NiJ9.eyJhcHAtcm9sZXMiOltdLCJhY2NvdW50aWQiOiIwMDE5MTAxMzEyNDcyNzIxIiwic3ViIjoiMDAxOTA5MjcxNTE3NDI2MCIsInRlbmFudC1yb2xlcyI6W10sImFjY291bnROYW1lIjoic3VwZXJhZG1pbiIsImFwcGlkIjoic3lzdGVtIiwiaXNzIjoidWl0Y2wiLCJ1Yy1yb2xlcyI6W3sicm9sZUlkIjoiYWRtaW5pc3RyYXRvcnMiLCJyb2xlTmFtZSI6Iui2hee6p-euoeeQhuWRmCIsImlzSW5oZXJpdGFibGUiOnRydWV9LHsicm9sZUlkIjoidGVuYW50QWRtaW5pc3RyYXRvcnMiLCJyb2xlTmFtZSI6Iuenn-aIt-euoeeQhuWRmCIsImlzSW5oZXJpdGFibGUiOnRydWV9XSwiZXhwIjoxNTgwNzE4MDU1LCJpYXQiOjE1ODA2MzE2NTUsImp0aSI6ImVjMWI3YThjLTE1ZjUtNGU3OC1hNDlmLTU5YzdmNjM4OTllYSJ9.srnSogouMhoTw3XnA779c7iAraRfvR0SXU5RIBZGBOg',
        onSendProgress: (i, j) {
      _per = '${((i * 1.0 / j) * 100.00).toStringAsFixed(0)}%';
      setState(() {});
    });
    if (map == null || map.isEmpty) {
      return null;
    }
    return map[avatarFile];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: <Widget>[
        Container(
          color: Colors.grey[300],
          child: IconButton(
            padding: EdgeInsets.all(!StringUtil.isEmpty(_avatarFile) ? 0 : 20),
            iconSize: !StringUtil.isEmpty(_avatarFile) ? 40 : 20,
            splashColor: Colors.grey[400],
            hoverColor: Colors.transparent,
            color: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: !StringUtil.isEmpty(_avatarFile)
                ? Image.file(
                    File(_avatarFile),
                  )
                : Icon(
                    Icons.camera_alt,
                    color: Colors.grey[500],
                  ),
            onPressed: () {
              widget.context.forward('/widgets/avatar').then((avatar) async {
                if (StringUtil.isEmpty(avatar)) {
                  return;
                }
                _avatarFile = avatar;
                setState(() {});
                var remoteAvatar = await _doUploadAvatar(avatar);
                if (widget.onAfterUpload != null) {
                  widget.onAfterUpload(remoteAvatar);
                }
              });
            },
          ),
        ),
        if (_per != null)
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Align(
              child: Text(
                '$_per',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              alignment: Alignment.center,
            ),
          ),
      ],
    );
  }
}
