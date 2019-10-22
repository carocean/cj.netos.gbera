import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class DeskletsSettings extends StatefulWidget {
  PageContext context;

  DeskletsSettings({this.context});

  @override
  _DeskletsSettingsState createState() => _DeskletsSettingsState();
}

class _DeskletsSettingsState extends State<DeskletsSettings> {
  @override
  Widget build(BuildContext context) {
    var bb = widget.context.parameters['back_button'];
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
      body: Container(
        child: ListView.separated(
          itemBuilder: _itemBuilder,
          separatorBuilder: _separatorBuilder,
          itemCount: 10,
          shrinkWrap: true,
        ),
      ),
    );
  }

  getLeading(bb) {
    if (bb == null) return null;
    return IconButton(
      onPressed: () {
        widget.context.goBack();
      },
      icon: Icon(
        Icons.clear,
        size: 18,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
//          widget.context.switchTheme(selected.url);
        });
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 15,
          bottom: 15,
          left: 10,
          right: 10,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                    child: Icon(
                      widget.context.findPage('/system/themes').icon,
                      size: 30,
                      color: Colors.green,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: Text(
                          '我',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        '说明',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return Divider(
      height: 1,
      indent: 50,
    );
  }
}
