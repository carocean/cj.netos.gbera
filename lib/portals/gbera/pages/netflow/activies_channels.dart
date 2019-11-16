import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class ActivitiesChannels extends StatefulWidget {
  PageContext context;

  ActivitiesChannels({this.context});

  @override
  _ActivesSitesState createState() => _ActivesSitesState();
}

class _ActivesSitesState extends State<ActivitiesChannels> {
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
