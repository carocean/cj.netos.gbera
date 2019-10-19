import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class Receivables extends StatelessWidget {
  PageContext context;
  Receivables({this.context});
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
