///商户站点
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class MarchantSite extends StatefulWidget {
  PageContext context;

  MarchantSite({this.context});

  @override
  _MarchantSiteState createState() => _MarchantSiteState();
}

class _MarchantSiteState extends State<MarchantSite> {
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
