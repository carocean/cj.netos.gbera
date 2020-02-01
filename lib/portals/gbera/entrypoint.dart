import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class EntryPoint extends StatelessWidget {
  PageContext context;

  EntryPoint({this.context});

  @override
  Widget build(BuildContext context) {
    var body;
    var shared = this.context.sharedPreferences();
    var keyStore = shared.getString('key_store');
    if (keyStore == null) {
      //加载主入口部件（有登录和注册选项）
      body = _EntryPointIndex(
        context: this.context,
      );
    }
    //检查过期否（令牌为空也视为过期），如果过期则加载有账号但必须输入密码的界面
    //如果不过期，则直接跳转到桌面
//    var map=jsonDecode(keyStore);
//    if(map['official'])
    return Scaffold(
      body: body,
    );
  }
}

class _EntryPointIndex extends StatelessWidget {
  PageContext context;

  _EntryPointIndex({this.context});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('lib/portals/gbera/images/entrypoint_bk.jpg'),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FlatButton(
                color: Colors.green,
                hoverColor: Colors.grey[100],
                child: Text(
                  '登录',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  this.context.forward('/login3');
                },
              ),
              FlatButton(
                color: Colors.white,
                child: Text(
                  '注册',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                onPressed: () {
                  this.context.forward('/register');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
