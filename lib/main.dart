import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/netos/framework.dart' as framework;

void main()  {
  framework.run(
    MyApp(
      portal: 'gbera',
      title: 'gbera',
      themeUrl: '/grey',
      welcomeUrl: '/entrypoint',
    ),
    props: {
      '@.prop.isTest': true,
      '@.prop.ports.uc.auth':'http://47.105.165.186/uc/auth.service',
      '@.prop.ports.uc.register':'http://47.105.165.186/uc/register.service',
      '@.prop.ports.uc.person':'http://47.105.165.186/uc/person/self.service',
      '@.prop.ports.uc.platform':'http://47.105.165.186/uc/platform/self.service',
      '@.prop.fs.delfile':'http://47.105.165.186:7110/del/file/',
      '@.prop.fs.uploader':'http://47.105.165.186:7110/upload/uploader.service',
      '@.prop.fs.reader':'http://47.105.165.186:7100',
      //网易云短信接口应在uc中心注册
//      '@.prop.api.netease.im.url.sendcode':'https://api.netease.im/sms/sendcode.action',
//      '@.prop.api.netease.im.url.verifycode':'https://api.netease.im/sms/verifycode.action',
//      '@.prop.api.netease.im.appKey':'f54c7223b49c68b8d2af7b7f2ecb834e',
//      '@.prop.api.netease.im.appSecret':'fec5cc11d9e4',
    },
    appKeyPair: AppKeyPair(
      appid: 'gbera.netos',
      appKey: '92D9F2B8078D039A7405AC0498F71059',
      appSecret: '9402073ADEF6DEEB35E2FDBAC7051471',
    ),
  );
}

class MyApp extends StatefulWidget {
  String themeUrl;
  String welcomeUrl;
  String title;
  String portal;

  MyApp({this.themeUrl, this.welcomeUrl, this.title, this.portal});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    framework.onFrameworkEvents = (event) {
      switch (event.cmd) {
        case 'switchTheme':
          setState(() {
            widget.portal = event.parameters['portal'];
            widget.themeUrl = event.parameters['themeUrl'];
          });
          break;
      }
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var fullThemeUrl = '${widget.portal}:/${widget.themeUrl}';
    var fullWelcomeUrl = '${widget.portal}:/${widget.welcomeUrl}';
//    debugPaintSizeEnabled = false;
    return MaterialApp(
      title: widget.title,
      navigatorObservers: [
        framework.navigatorObserver(),
      ],
      theme: framework.onGenerateThemeStyle(fullThemeUrl, context),
      onGenerateRoute: framework.onGenerateRoute,
      onUnknownRoute: framework.onUnknownRoute,
      initialRoute: fullWelcomeUrl,
    );
  }
}
