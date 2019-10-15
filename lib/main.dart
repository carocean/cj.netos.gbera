import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'netos/framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
//    debugPaintSizeEnabled = false;
    return MaterialApp(
      title: 'gbera',
      theme: onGenerateThemeStyle('gbera://gray', context),
      routes: buildRoutes(),
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: onUnknownRoute,
      initialRoute: 'gbera://login2',
    );
  }
}
