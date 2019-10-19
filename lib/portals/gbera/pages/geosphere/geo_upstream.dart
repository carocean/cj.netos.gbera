import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class GeoUpstream extends StatelessWidget {
  PageContext context;


  GeoUpstream({this.context});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.context.page?.title,
        ),
        titleSpacing: 0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            this.context.goBack();
          },
          icon: Icon(
            Icons.clear,
            size: 18,
          ),
        ),
      ),
      body: Container(),
    );
  }
}
