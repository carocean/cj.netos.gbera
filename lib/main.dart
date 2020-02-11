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
      ///默认应用，即终端未指定应用号时登录或注册的目标应用
      '@.prop.entrypoint.app':'gbera.netos',
      '@.prop.ports.uc.auth':'http://47.105.165.186/uc/auth.service',
      '@.prop.ports.uc.register':'http://47.105.165.186/uc/register.service',
      '@.prop.ports.uc.person':'http://47.105.165.186/uc/person/self.service',
      '@.prop.ports.uc.platform':'http://47.105.165.186/uc/platform/self.service',
      '@.prop.fs.delfile':'http://47.105.165.186:7110/del/file/',
      '@.prop.fs.uploader':'http://47.105.165.186:7110/upload/uploader.service',
      '@.prop.fs.reader':'http://47.105.165.186:7100',
    },
    appKeyPair: AppKeyPair(
      appid: 'system.netos',
      appKey: '995C2A861BE8064A1F8A022B5C0D2E36',
      appSecret: '6EA4774EE78DCDF0768CA18ECF3AD1DB',
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
