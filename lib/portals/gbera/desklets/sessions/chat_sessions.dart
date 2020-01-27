import 'dart:io';

import 'package:badges/badges.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';
import 'package:uuid/uuid.dart';

class ChatSessionsPortlet extends StatefulWidget {
  Portlet portlet;
  Desklet desklet;
  PageContext content;

  ChatSessionsPortlet({this.portlet, this.desklet, this.content});

  @override
  _ChatSessionsPortletState createState() => _ChatSessionsPortletState();
}

class _ChatSessionsPortletState extends State<ChatSessionsPortlet> {
  @override
  Widget build(BuildContext context) {
    var items = <_ChatSessionItem>[];
    for (var i = 0; i < 5; i++) {
      items.add(
        _ChatSessionItem(
          context: widget.content,
          title: '一缕云烟',
          leading: Image.network(
            'http://47.105.165.186:7100/public/avatar/341d5e0f2d4fbd21ff5a2acafcf44cdb.jpg',
            fit: BoxFit.fill,
          ),
          time: TimelineUtil.format(
            DateTime.now().millisecondsSinceEpoch,
            dayFormat: DayFormat.Simple,
          ),
          unreadMsgCount: 10,
          showNewest: true,
          subtitle: '哈喽，请问你这边还需要找办公公寓吗',
          who: 'tom',
          onTap: (sid){
            widget.content.forward('/portlet/chat/talk');
          },
        ),
      );
    }
    return ConstrainedBox(
      constraints: BoxConstraints.tightForFinite(
        width: double.maxFinite,
      ),
      child: Card(
        margin: EdgeInsets.only(
          bottom: 10,
          left: 0,
          right: 0,
          top: 0,
        ),
        child: ListView(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 10,
                top: 10,
                right: 15,
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          right: 5,
                        ),
                        child: Icon(
                          Icons.chat_bubble_outline,
                          size: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                      Text('平聊'),
                    ],
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {},
                    child: Icon(
                      Icons.contacts,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            ListView(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: items,
            ),
            _MessagesExpansionPanel(
              context: widget.content,
            ),
          ],
        ),
      ),
    );
  }
}

class _MessagesExpansionPanel extends StatefulWidget {
  PageContext context;

  _MessagesExpansionPanel({this.context});

  @override
  __MessagesExpansionPanelState createState() =>
      __MessagesExpansionPanelState();
}

class __MessagesExpansionPanelState extends State<_MessagesExpansionPanel> {
  bool _isExpaned = false;

  @override
  Widget build(BuildContext context) {
    var items = <_ChatSessionItem>[];
    for (var i = 0; i < 3; i++) {
      items.add(
        _ChatSessionItem(
          context: widget.context,
          title: '会议纪要讨论确认',
          leading: Icon(
            Icons.group,
          ),
          time: TimelineUtil.format(
            DateTime.now().millisecondsSinceEpoch,
            dayFormat: DayFormat.Simple,
          ),
          unreadMsgCount: 10,
          showNewest: true,
          subtitle: '对老用户会有这个影响 新用户没有什么影响的',
          who: '李修缘',
        ),
      );
    }
    return ListView(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        _isExpaned
            ? GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _isExpaned = false;
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(
                    right: 10,
                    top: 10,
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 24,
                    color: Colors.grey[500],
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.loose,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _isExpaned = true;
                        setState(() {});
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 10,
                              top: 1,
                              bottom: 1,
                            ),
                            child: Text.rich(
                              TextSpan(
                                text: '李修缘:',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text: '[前天]',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  TextSpan(
                                    text: '对老用户会有这个影响 新用户没有什么影响的',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 10,
                              top: 1,
                              bottom: 1,
                            ),
                            child: Text.rich(
                              TextSpan(
                                text: '南鸾:',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text: '[星期五]',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '道友们，推荐一下呗，自家哥哥压岁钱多，说送我一套帮忙推荐一下呗，有两套白色',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Badge(
                    position: BadgePosition.topLeft(
                      left: 19,
                      top: 2,
                    ),
                    elevation: 0,
                    showBadge: true,
                    badgeContent: Text(
                      '',
                    ),
                    child: IconButton(
                      onPressed: () {
                        _isExpaned = true;
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.more_horiz,
                        size: 24,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
        !_isExpaned
            ? Container(
                width: 0,
                height: 0,
              )
            : Column(
                children: items,
              ),
        !_isExpaned
            ? Container(
                width: 0,
                height: 0,
              )
            : GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _isExpaned = false;
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(
                    bottom: 10,
                    right: 10,
                    top: 10,
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    size: 24,
                    color: Colors.grey[500],
                  ),
                ),
              ),
      ],
    );
  }
}

class _ChatSessionItem extends StatefulWidget {
  PageContext context;
  Widget leading;
  String title;
  String who;
  String subtitle;
  String time;
  bool showNewest;
  int unreadMsgCount;
  Function(String sessionid) onTap;

  _ChatSessionItem({
    this.context,
    this.leading,
    this.title,
    this.who,
    this.subtitle,
    this.unreadMsgCount,
    this.time,
    this.showNewest,
    this.onTap,
  });

  @override
  State createState() {
    return __ChatSessionItem();
  }
}
class __ChatSessionItem extends State<_ChatSessionItem>{
  @override
  Widget build(BuildContext context) {
    Widget imgSrc = null;
    if (widget.leading == null) {
      imgSrc = Icon(
        IconData(
          0xe606,
          fontFamily: 'netflow',
        ),
        size: 32,
        color: Colors.grey[500],
      );
    } else {
      imgSrc = widget.leading;
    }
    var item = Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(behavior: HitTestBehavior.opaque,onTap: (){
            if(widget.onTap!=null) {
              widget.onTap('xxx');
            }
          },child: Container(
            margin: EdgeInsets.only(
              bottom: 15,
              left: 10,
              right: 10,
              top: 15,
            ),
            child: Row(
              crossAxisAlignment: widget.showNewest
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: imgSrc,
                          ),
                        ),
                        Positioned(
                          top: -10,
                          right: -3,
                          child: Badge(
                            position: BadgePosition.topRight(
                              right: -3,
                              top: 3,
                            ),
                            elevation: 0,
                            showBadge: widget.unreadMsgCount != 0,
                            badgeContent: Text(
                              '',
                            ),
                            child: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 5,
                          right: 5,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text.rich(
                              TextSpan(
                                text: widget.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              '${widget.time}',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.normal,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      widget.showNewest
                          ? Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.start,
                        spacing: 5,
                        runSpacing: 3,
                        children: <Widget>[
                          Text.rich(
                            TextSpan(
                              text:
                              '[${widget.unreadMsgCount != 0 ? widget.unreadMsgCount : ''}条]',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              children: [
                                TextSpan(
                                  text: ' ',
                                ),
//                                      TextSpan(
//                                        text: '${this.who}: ',
//                                      ),
                                TextSpan(
                                  text: '${widget.subtitle}',
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                          : Container(
                        width: 0,
                        height: 0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),),
          Divider(
            height: 1,
            indent: 60,
          ),
        ],
      ),
    );
    return Dismissible(
      key: Key('key_${Uuid().v1()}'),
      child: item,
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.endToStart) {
          return await _showConfirmationDialog(context) == 'yes';
        }
        return false;
      },
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(
          right: 10,
        ),
        child: Icon(
          Icons.delete_sweep,
          size: 16,
        ),
      ),
      background: Container(),
      onDismissed: (direction) {
        switch (direction) {
          case DismissDirection.endToStart:
            print('---------do deleted');
            break;
          case DismissDirection.vertical:
            // TODO: Handle this case.
            break;
          case DismissDirection.horizontal:
            // TODO: Handle this case.
            break;
          case DismissDirection.startToEnd:
            // TODO: Handle this case.
            break;
          case DismissDirection.up:
            // TODO: Handle this case.
            break;
          case DismissDirection.down:
            // TODO: Handle this case.
            break;
        }
      },
    );
  }

  Future<String> _showConfirmationDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text.rich(
          TextSpan(
            text: '是否删除该管道？',
            children: [
              TextSpan(text: '\r\n'),
              TextSpan(
                text: '删除管道同时会删除管道内数据！',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text(
              '取消',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            onPressed: () {
              Navigator.pop(context, 'no');
            },
          ),
          FlatButton(
            child: const Text(
              '确定',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            onPressed: () {
              Navigator.pop(context, 'yes');
            },
          ),
        ],
      ),
    );
  }
}
