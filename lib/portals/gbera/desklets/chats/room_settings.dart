import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/parts/CardItem.dart';

class ChatRoomSettings extends StatefulWidget {
  PageContext context;

  ChatRoomSettings({this.context});

  @override
  _ChatRoomSettingsState createState() => _ChatRoomSettingsState();
}

class _ChatRoomSettingsState extends State<ChatRoomSettings> {
  bool _showNickName = false;

  @override
  Widget build(BuildContext context) {
    var contacts_servicers = <Widget>[];
    for (var i = 0; i < 4; i++) {
      contacts_servicers.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                bottom: 2,
              ),
              child: SizedBox(
                width: 40,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  child: Image.network(
                    'http://47.105.165.186:7100/public/avatar/24f8e8d3f423d40b5b390691fbbfb5d7.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              '黄荣晖gggg3232332',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }
    contacts_servicers.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              widget.context.forward('/portlet/chat/friends');
            },
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 2,
              ),
              child: SizedBox(
                width: 40,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      border: Border.all(
                        color: Colors.grey[300],
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            '',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
    var contacts_members = <Widget>[];
    for (var i = 0; i < 19; i++) {
      contacts_members.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                bottom: 2,
              ),
              child: SizedBox(
                width: 40,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  child: Image.network(
                    'http://47.105.165.186:7100/public/avatar/24f8e8d3f423d40b5b390691fbbfb5d7.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              '黄荣晖gggg3232332',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }
    contacts_members.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              widget.context.forward('/portlet/chat/friends');
            },
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 2,
              ),
              child: SizedBox(
                width: 40,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      border: Border.all(
                        color: Colors.grey[300],
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            '',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              '聊天室',
            ),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white,
            pinned: true,
            floating: false,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              padding: EdgeInsets.all(10),
              child: GridView(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 70,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                children: contacts_servicers.map((c) {
                  return c;
                }).toList(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(
                left: 10,
                bottom: 2,
              ),
              child: Text(
                '成员',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              padding: EdgeInsets.all(10),
              child: GridView(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 70,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                children: contacts_members.map((c) {
                  return c;
                }).toList(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              child: Column(
                children: <Widget>[
                  CardItem(
                    paddingLeft: 15,
                    paddingRight: 15,
                    title: '聊天室名称',
                    tipsText: '未命名',
                  ),
                  Divider(
                    height: 1,
                    indent: 15,
                  ),
                  CardItem(
                    paddingLeft: 15,
                    paddingRight: 15,
                    title: '群二维码',
                    tipsIconData: FontAwesomeIcons.qrcode,
                  ),
                  Divider(
                    height: 1,
                    indent: 15,
                  ),
                  CardItem(
                    paddingLeft: 15,
                    paddingRight: 15,
                    title: '公告',
                    tipsText: '未设置',
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              child: Column(
                children: <Widget>[
                  CardItem(
                    paddingLeft: 15,
                    paddingRight: 15,
                    title: '我在本群的昵称',
                    tipsText: 'cj',
                  ),
                  Divider(
                    height: 1,
                    indent: 15,
                  ),
                  CardItem(
                    paddingLeft: 15,
                    paddingRight: 15,
                    title: '显示聊天室成员昵称',
                    tail: SizedBox(
                      height: 25,
                      child: Switch.adaptive(
                        value: _showNickName,
                        onChanged: (showNickName) {
                          setState(() {
                            _showNickName = showNickName;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              child: Column(
                children: <Widget>[
                  CardItem(
                    paddingLeft: 15,
                    paddingRight: 15,
                    title: '设置当前聊天背景',
                    tipsText: '',
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      print('empty--');
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                      ),
                      child: Center(
                        child: Text(
                          '清空聊天记录',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      print('remove--');
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                      ),
                      child: Center(
                        child: Text(
                          '删除',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
