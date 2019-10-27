import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/parts/bottoms.dart';

class MyBusinessScaffold extends StatefulWidget {
  PageContext context;

  MyBusinessScaffold({this.context});

  @override
  _MyBusinessScaffoldState createState() => _MyBusinessScaffoldState();
}

class _MyBusinessScaffoldState extends State<MyBusinessScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.context.page?.title,
        ),
        titleSpacing: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            size: 18,
          ),
          onPressed: (){
            widget.context.forward('gbera://scaffold/withbottombar');
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text('这是我的生意框架'),
      ),
    );
  }
}
