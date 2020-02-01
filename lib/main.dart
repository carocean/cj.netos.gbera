import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/netos/framework.dart' as framework;

void main() {
  framework.run(
    MyApp(
      portal: 'gbera',
      title: 'gbera',
      themeUrl: '/grey',
      welcomeUrl: '/entrypoint',
    ),
    props: {
      '@.prop.isTest': true,
    },
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
