import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class CreateChannel extends StatefulWidget {
  PageContext context;

  CreateChannel({this.context});

  @override
  _CreateChannelState createState() => _CreateChannelState();
}

class _CreateChannelState extends State<CreateChannel> {
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
