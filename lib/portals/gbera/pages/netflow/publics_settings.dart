import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class PublicsSettings extends StatefulWidget {
  PageContext context;

  PublicsSettings({this.context});

  @override
  _PublicsSettingsState createState() => _PublicsSettingsState();
}

class _PublicsSettingsState extends State<PublicsSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            widget.context.backward();
          },
          icon: Icon(
            Icons.close,
          ),
        ),
        centerTitle: false,
        title: Text(
          widget.context.page.title,
        ),
      ),
      body: Container(),
    );
  }
}
