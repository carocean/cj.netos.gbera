import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class Wallpappers extends StatelessWidget {
  PageContext context;
  Wallpappers({this.context});
  @override
  Widget build(BuildContext context) {

    var bb = this.context.parameters['back_button'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.context.page?.title,
        ),
        titleSpacing: 0,
        elevation: 1.0,
        automaticallyImplyLeading: bb == null ? true : false,
        leading: getLeading(bb),
      ),
      body: Container(),
    );
  }

  getLeading(bb) {
    if (bb == null) return null;
    return IconButton(
      onPressed: () {
        this.context.goBack();
      },
      icon: Icon(
        Icons.clear,
        size: 18,
      ),
    );
  }
}
