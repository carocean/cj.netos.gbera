import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class GeoYuanbao extends StatelessWidget {
  PageContext context;


  GeoYuanbao({this.context});
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
            this.context.backward();
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
