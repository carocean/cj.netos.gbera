import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class ProfileMore extends StatefulWidget {
  PageContext context;

  ProfileMore({this.context});

  @override
  _ProfileMoreState createState() => _ProfileMoreState();
}

class _ProfileMoreState extends State<ProfileMore> {
  @override
  Widget build(BuildContext context) {
    var bb = widget.context.page.parameters['back_button'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.context.page?.title,
        ),
        titleSpacing: 0,
        elevation: 0,
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
        widget.context.backward();
      },
      icon: Icon(
        Icons.clear,
        size: 18,
      ),
    );
  }
}
