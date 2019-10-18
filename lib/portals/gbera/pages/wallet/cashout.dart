import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class Cashout extends StatelessWidget {
  PageContext context;
  Cashout({this.context});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.context.page?.title,
        ),
        titleSpacing: 0,
        elevation: 1.0,
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
