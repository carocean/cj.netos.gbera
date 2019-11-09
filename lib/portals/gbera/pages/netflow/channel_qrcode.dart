import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class QrcodeChannel extends StatefulWidget {
  PageContext context;

  QrcodeChannel({this.context});

  @override
  _QrcodeChannelState createState() => _QrcodeChannelState();
}

class _QrcodeChannelState extends State<QrcodeChannel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.context.page.title,),
        titleSpacing: 0,
        elevation: 0.0,
        automaticallyImplyLeading: true,
      ),
      body: Container(),
    );
  }
}
