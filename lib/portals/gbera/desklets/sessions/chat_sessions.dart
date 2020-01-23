import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class ChatSessionsPortlet extends StatefulWidget {
  Portlet portlet;
  Desklet desklet;
  PageContext desktopContext;

  ChatSessionsPortlet({this.portlet, this.desklet, this.desktopContext});

  @override
  _ChatSessionsPortletState createState() => _ChatSessionsPortletState();
}

class _ChatSessionsPortletState extends State<ChatSessionsPortlet> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('测试'),);
  }
}
