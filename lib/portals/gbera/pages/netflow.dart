import 'dart:io';
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/pages/netflow/channel.dart';
import 'package:gbera/portals/gbera/store/entities.dart';
import 'package:gbera/portals/gbera/store/services.dart';

import '../parts/headers.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'netflow/message_views.dart';

class Netflow extends StatefulWidget {
  PageContext context;

  Netflow({this.context});

  @override
  _NetflowState createState() => _NetflowState();
}

class _NetflowState extends State<Netflow> {
  var _controller;
  var _backgroud_transparent = true;
  bool use_wallpapper = false;

  _NetflowState() {
    _controller = ScrollController(initialScrollOffset: 0.0);
    _controller.addListener(_listener);
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  _listener() {
    if (!use_wallpapper) {
      return;
    }
    if (_controller.offset >= 30) {
      //48是appbar的高度，210是appbar展开发的总高
      if (_backgroud_transparent) {
        setState(() {
          _backgroud_transparent = false;
        });
      }
      return;
    }
    if (_controller.offset < 30) {
      if (!_backgroud_transparent) {
        setState(() {
          _backgroud_transparent = true;
        });
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    use_wallpapper = widget.context.parameters['use_wallpapper'];
    return CustomScrollView(
      controller: _controller,
      slivers: <Widget>[
        _sliverAppBar(),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.only(
              left: 10,
              bottom: 5,
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    widget.context.forward('/netflow/manager/publics',
                        arguments: {'title': '公众活动'});
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          right: 5,
                        ),
                        child: Icon(
                          widget.context
                              .findPage('/netflow/manager/channel_gateway')
                              ?.icon,
                          size: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        '公众活动',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return CupertinoActionSheet(
                            actions: <Widget>[
                              CupertinoActionSheetAction(
                                child: const Text.rich(
                                  TextSpan(
                                    text: '全屏',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(text: '\r\n'),
                                      TextSpan(
                                        text: '长按全屏按钮可直接进入全屏',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  widget.context.backward();
                                  widget.context.forward(
                                      '/netflow/publics/activities',
                                      arguments: {'title': '公众活动'});
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: const Text.rich(
                                  TextSpan(
                                    text: '取消',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(text: '\r\n'),
                                      TextSpan(
                                        text: '',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context, 'Profiteroles');
                                },
                              ),
                            ],
                          );
                        });
                  },
                  onLongPress: () {
                    widget.context.forward('/netflow/publics/activities',
                        arguments: {'title': '公众活动'});
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      right: 15,
                    ),
                    child: Icon(
                      Icons.open_with,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            child: FutureBuilder<List<MessageView>>(
              future: _getMessages(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(
//                    value: 0.3,
                        backgroundColor: Colors.grey[300],
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.grey[600]),
                      ),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error?.toString(),
                    ),
                  );
                }
                var msgviews = snapshot.data;

                return msgviews.length > 0
                    ? _MessagesRegion(context: widget.context, views: msgviews)
                    : Container(
                        height: 40,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 5,
                          bottom: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Text(
                          '无消息',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      );
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.only(
              left: 10,
              bottom: 5,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '我的管道',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: FutureBuilder<List<_ChannelItem>>(
            future: _loadChannels(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Container(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                physics: NeverScrollableScrollPhysics(),
                children: snapshot.data.map((item) {
                  return item;
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<List<_ChannelItem>> _loadChannels() async {
    IChannelService channelService =
        widget.context.site.getService('/external/channels');
    List<Channel> list = await channelService.getAllChannel();
    if (list.isEmpty) {
      await channelService.init(widget.context.userPrincipal);
      list = await channelService.getAllChannel();
    }
    var items = List<_ChannelItem>();
    for (var ch in list) {
      var tips = ch.tips;
      var who = '';
      var newest = '';
      if (tips != null) {
        int pos = tips.indexOf(':>');
        if (pos > -1) {
          who = tips.substring(0, pos);
          newest = tips.substring(pos + 2, tips.length);
        }
      }

      items.add(
        _ChannelItem(
          title: ch.name,
          subtitle: '$newest',
          showNewest: !StringUtil.isEmpty(tips),
          leading: ch.leading,
          time: TimelineUtil.format(
            ch.utime,
            dayFormat: DayFormat.Full,
          ),
          unreadMsgCount: ch.unreadMsgCount ?? 0,
          who: '$who: ',
          loopType: ch.loopType,
          openAvatar: () {
            //如果不是自己的管道则不能改图标
            if (widget.context.userPrincipal.person != ch.owner) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('不可修改图标！原因：不是您创建的管道'),
                ),
              );
              return;
            }
            widget.context.forward(
              '/netflow/channel/avatar',
              arguments: {
                'channel': ch,
              },
            );
          },
          openChannel: () {
            widget.context.forward(
              '/netflow/channel',
              arguments: {'channel': ch},
            );
          },
        ),
      );
    }
    return items;
  }

  _sliverAppBar() {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Text('网流'),
      centerTitle: true,
      actions: <Widget>[
        PopupMenuButton<String>(
          offset: Offset(
            0,
            50,
          ),
          onSelected: (value) async {
            if (value == null) return;
            var arguments = <String, Object>{};
            switch (value) {
              case '/netflow/manager/create_channel':
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text('选择管道类型'),
                        children: <Widget>[
                          DialogItem(
                            text: '开环管道',
                            icon: IconData(
                              0xe604,
                              fontFamily: 'netflow',
                            ),
                            color: Colors.grey[500],
                            subtext: '适用于无穷级网络。自行添加管道出入口的公众',
                            onPressed: () {
                              widget.context.backward(
                                  result: <String, Object>{'type': 'openLoop'});
                            },
                          ),
                          DialogItem(
                            text: '闭环管道',
                            icon: IconData(
                              0xe62f,
                              fontFamily: 'netflow',
                            ),
                            color: Colors.grey[500],
                            subtext:
                                '适用于：点对点聊天、群聊。管道的入口公众全是出口公众，自行添加出口公众同时也会被添加到入口',
                            onPressed: () {
                              widget.context.backward(result: <String, Object>{
                                'type': 'closeLoop'
                              });
                            },
                          ),
                        ],
                      );
                    }).then((v) {
                  print('xxxx-$v');
                  if (v == null) return;
                  widget.context.forward(value, arguments: v);
                });
                break;
              case '/netflow/manager/scan_channel':
                String cameraScanResult = await scanner.scan();
                if (cameraScanResult == null) break;
                arguments['qrcode'] = cameraScanResult;
                widget.context.forward(value, arguments: arguments);
                break;
              case '/netflow/manager/search_channel':
                widget.context.forward(value, arguments: arguments);
                break;
              case '/test/services':
                widget.context.forward(value, arguments: arguments);
                break;
            }
          },
          itemBuilder: (context) => <PopupMenuEntry<String>>[
            PopupMenuItem(
              value: '/netflow/manager/create_channel',
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                    child: Icon(
                      widget.context
                          .findPage('/netflow/manager/create_channel')
                          ?.icon,
                      color: Colors.grey[500],
                      size: 15,
                    ),
                  ),
                  Text(
                    '新建管道',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuDivider(),
            PopupMenuItem(
              value: '/netflow/manager/scan_channel',
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                    child: Icon(
                      widget.context
                          .findPage('/netflow/manager/scan_channel')
                          ?.icon,
                      color: Colors.grey[500],
                      size: 15,
                    ),
                  ),
                  Text(
                    '扫码以连接',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: '/netflow/manager/search_channel',
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                    child: Icon(
                      widget.context
                          .findPage('/netflow/manager/search_channel')
                          ?.icon,
                      color: Colors.grey[500],
                      size: 15,
                    ),
                  ),
                  Text(
                    '搜索以连接',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuDivider(),
            PopupMenuItem(
              value: '/test/services',
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                    child: Icon(
                      widget.context.findPage('/test/services')?.icon,
                      color: Colors.grey[500],
                      size: 15,
                    ),
                  ),
                  Text(
                    '测试网流服务',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
      backgroundColor:
          use_wallpapper && _backgroud_transparent ? Colors.transparent : null,
    );
  }

  Future<List<MessageView>> _getMessages() async {
    IInsiteMessageService messageService =
        widget.context.site.getService('/insite/messages');
    IPersonService personService =
        widget.context.site.getService('/upstream/persons');
    IChannelService channelService =
        widget.context.site.getService('/external/channels');
    var messages = await messageService.pageMessage(4, 0);
    var msgviews = <MessageView>[];
    for (var msg in messages) {
      var person = await personService.getPerson(msg.creator);
      var timeText = TimelineUtil.formatByDateTime(
              DateTime.fromMillisecondsSinceEpoch(msg.ctime),
              locale: 'zh',
              dayFormat: DayFormat.Full)
          .toString();
      var channel = await channelService.getChannel(msg.upstreamChannel);
      var act = MessageView(
        who: person.accountName,
        channel: channel?.name,
        content: msg.digests,
        money: ((msg.wy ?? 0) * 0.00012837277272).toStringAsFixed(2),
        time: timeText,
        picCount: 0,
        loopType: channel.loopType,
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return widget.context
                    .part('/site/insite/request', context, arguments: {
                  'message': msg,
                  'channel': channel,
                  'person': person,
                });
              });
        },
      );
      msgviews.add(act);
    }
    return msgviews;
  }
}

class _MessagesRegion extends StatefulWidget {
  List<MessageView> views = [];
  PageContext context;

  _MessagesRegion({this.views, this.context});

  @override
  _MessagesRegionState createState() => _MessagesRegionState();
}

class _MessagesRegionState extends State<_MessagesRegion> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          margin: EdgeInsets.only(
            bottom: 15,
            left: 10,
            right: 10,
          ),
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Column(
              children: widget.views.map((v) {
                index++;
                bool notBottom = index < widget.views.length;
                if (index >= widget.views.length) {
                  index = 0;
                }
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: v.onTap,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[900],
                                ),
                                text: '${v.content}',
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 6,
                        ),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              !StringUtil.isEmpty(v.time)
                                  ? TextSpan(text: '${v.time}')
                                  : TextSpan(text: ''),
                              !StringUtil.isEmpty(v.money)
                                  ? TextSpan(
                                      text: '  洇金:¥',
                                      children: [
                                        TextSpan(
                                          text: '${v.money}',
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )
                                  : TextSpan(text: ''),
                              TextSpan(
                                text: '  来自:',
                              ),
                              TextSpan(
                                text: '  ${v.who}',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              !StringUtil.isEmpty(v.channel)
                                  ? TextSpan(
                                      text: '',
                                      children: [
                                        TextSpan(
                                            text:
                                                '  ${v.loopType == 'true' ? '开环管道:' : '闭环管道:'}'),
                                        TextSpan(
                                          text: '${v.channel}',
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )
                                  : TextSpan(text: ''),
                              v.picCount > 0
                                  ? TextSpan(text: '  图片${v.picCount}个')
                                  : TextSpan(text: ''),
                            ],
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      notBottom
                          ? Container(
                              child: Divider(
                                height: 1,
                              ),
                              padding: EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                              ),
                            )
                          : Container(
                              width: 0,
                              height: 0,
                            ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _ChannelItem extends StatelessWidget {
  String leading;
  String title;
  String who;
  String subtitle;
  String time;
  bool showNewest;
  String loopType;
  int unreadMsgCount;
  var openAvatar;
  var openChannel;

  _ChannelItem({
    this.leading,
    this.title,
    this.who,
    this.subtitle,
    this.loopType,
    this.unreadMsgCount,
    this.time,
    this.showNewest,
    this.openAvatar,
    this.openChannel,
  });

  @override
  Widget build(BuildContext context) {
    Widget imgSrc = null;
    if (StringUtil.isEmpty(leading)) {
      imgSrc = Icon(
        IconData(
          0xe606,
          fontFamily: 'netflow',
        ),
        size: 32,
        color: Colors.grey[500],
      );
    } else if (leading.startsWith('/')) {
      //本地存储
      imgSrc = Image.file(
        File(leading),
        width: 40,
        height: 40,
      );
    } else {
      imgSrc = Image.network(
        this.leading,
        width: 40,
        height: 40,
      );
    }
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              bottom: 15,
              left: 10,
              right: 10,
              top: 15,
            ),
            child: Row(
              crossAxisAlignment: this.showNewest
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
                    onTap: this.openAvatar,
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
                            showBadge: this.unreadMsgCount != 0,
                            badgeContent: Text(
                              '',
                            ),
                            child: null,
                          ),
                        ),
                        Positioned(
                          bottom: -3,
                          right: -3,
                          child: Icon(
                            IconData(
                              this.loopType == 'closeLoop' ? 0xe62f : 0xe604,
                              fontFamily: 'netflow',
                            ),
                            size: 10,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: openChannel,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 5,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text.rich(
                                TextSpan(
                                  text: this.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        showNewest
                            ? Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.start,
                                spacing: 5,
                                runSpacing: 3,
                                children: <Widget>[
                                  Text.rich(
                                    TextSpan(
                                      text:
                                          '[${this.unreadMsgCount != 0 ? this.unreadMsgCount : ''}条]',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                      children: [
                                        TextSpan(
                                          text: ' ',
                                        ),
                                        TextSpan(
                                          text: '${this.subtitle}',
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${this.time}',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.normal,
                                      fontSize: 11,
                                    ),
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
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            indent: 60,
          ),
        ],
      ),
    );
  }
}
