import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class RenameChannel extends StatefulWidget {
  PageContext context;

  RenameChannel({this.context});

  @override
  _RenameChannelState createState() => _RenameChannelState();
}

class _RenameChannelState extends State<RenameChannel> {
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
