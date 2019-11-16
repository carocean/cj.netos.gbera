import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class ActivitiesGatewaySettings extends StatefulWidget {
  PageContext context;

  ActivitiesGatewaySettings({this.context});

  @override
  _ActivesSitesState createState() => _ActivesSitesState();
}

class _ActivesSitesState extends State<ActivitiesGatewaySettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.context.page.title),
        elevation: 0.0,
        titleSpacing: 0,
      ),
      body: Container(),
    );
  }
}
