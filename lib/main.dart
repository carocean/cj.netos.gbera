import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/netos/framework.dart' as framework;


void main(){
  framework.run(MyApp(
    portal: 'gbera',
    title: 'gbera',
    themeUrl: '/grey',
    welcomeUrl: '/login2',
  ));

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
  Widget build(BuildContext context) {
    var fullThemeUrl = '${widget.portal}:/${widget.themeUrl}';
    var fullWelcomeUrl = '${widget.portal}:/${widget.welcomeUrl}';
//    debugPaintSizeEnabled = false;
    return MaterialApp(
      title: widget.title,
      theme: framework.
      onGenerateThemeStyle(fullThemeUrl, context),
      routes: framework.buildRoutes(),
      onGenerateRoute: framework.onGenerateRoute,
      onUnknownRoute: framework.onUnknownRoute,
      initialRoute: fullWelcomeUrl,
    );
  }

  _MyAppState() {
    framework.onFrameworkRefresh =(props){
      setState(() {
//        ThemeStyle selectedTheme=props['selectedTheme'];
//        if(selectedTheme!=null){
//          widget.themeUrl=selectedTheme.url;
//        }
      });
    };
  }
}
