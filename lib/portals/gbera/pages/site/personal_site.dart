///个人站点
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class PersonalSite extends StatefulWidget {
  PageContext context;

  PersonalSite({this.context});

  @override
  _PersonalSiteState createState() => _PersonalSiteState();
}

class _PersonalSiteState extends State<PersonalSite> {
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
          onPressed: () {
            widget.context.backward();
          },
          icon: Icon(
            Icons.clear,
          ),
        ),
      ),
      body: Container(),
    );
  }
}
