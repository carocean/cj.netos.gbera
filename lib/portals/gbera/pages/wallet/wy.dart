import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class WY extends StatelessWidget {
  PageContext context;
  WY({this.context});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.context.page?.title,
        ),
        titleSpacing: 0,
        elevation: 1.0,
        automaticallyImplyLeading: true,
      ),
      body: Container(),
    );
  }
}
