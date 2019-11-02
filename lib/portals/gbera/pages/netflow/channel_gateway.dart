import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class ChannelGateway extends StatefulWidget {
  PageContext context;

  ChannelGateway({this.context});

  @override
  _ChannelGatewayState createState() => _ChannelGatewayState();
}

class _ChannelGatewayState extends State<ChannelGateway> {
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
