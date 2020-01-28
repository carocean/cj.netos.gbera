import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/parts/CardItem.dart';

class AddFriend extends StatefulWidget {
  PageContext context;

  AddFriend({this.context});

  @override
  _AddFriendState createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加朋友'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            CardItem(
              leading: Icon(
                Icons.group,
              ),
              title: '公众',
              subtitle: Text(
                '向网流或地圈中的公众申请成为朋友',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
            ),
            Divider(
              height: 1,
              indent: 40,
            ),
            CardItem(
              leading: Icon(
                FontAwesomeIcons.qrcode,
              ),
              title: '扫一扫',
              subtitle: Text(
                '扫描二维码名片',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
            ),
            Divider(
              height: 1,
              indent: 40,
            ),
            CardItem(
              leading: Icon(
                FontAwesomeIcons.phone,
              ),
              title: '手机通讯录',
              subtitle: Text(
                '从手机通讯录中添加，需要授予权限',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
