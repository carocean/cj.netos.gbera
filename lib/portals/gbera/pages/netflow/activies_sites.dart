import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class ActivitiesSites extends StatefulWidget {
  PageContext context;

  ActivitiesSites({this.context});

  @override
  _ActivesSitesState createState() => _ActivesSitesState();
}

class _ActivesSitesState extends State<ActivitiesSites> {
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
