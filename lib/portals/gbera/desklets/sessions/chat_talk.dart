import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/pages/market/tab_page.dart';
import 'package:gbera/portals/gbera/parts/parts.dart';

class ChatTalk extends StatefulWidget {
  PageContext context;

  ChatTalk({this.context});

  @override
  _ChatTalkState createState() => _ChatTalkState();
}

class _ChatTalkState extends State<ChatTalk> {
  List<Function()> _onTapEvents = [];

  EasyRefreshController _controller;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _scrollController = ScrollController();
    Timer(Duration(milliseconds: 500),
            () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent));
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {}

  @override
  Widget build(BuildContext context) {
    var items = <Widget>[];
    for (var i = 0; i < 50; i++) {
      //接收消息项
      items.add(
        Container(
          margin: EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          padding: EdgeInsets.only(
            left: 10,
            right: 60,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    child: Image.network(
                      'http://47.105.165.186:7100/public/avatar/24f8e8d3f423d40b5b390691fbbfb5d7.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Wrap(
                  runSpacing: 5,
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Text(
                      TimelineUtil.format(
                        DateTime.now().millisecondsSinceEpoch,
                      ),
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: '',
                        children: [
                          TextSpan(
                            text:
                                '新京报快讯 据贵州省卫生健康委员会官方微博消息，1月26日晚，贵州省疫情防控工作领导小组接报，泰国亚洲航空公司FD428航班将于当晚22时50分落地贵阳，机上一名有武汉旅行史的福建旅客林某某（男，44岁）和一名贵州省六盘水市旅客康某某（女，7岁）出现发热状况。',
                          ),
                        ],
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      items.add(
        Container(
          margin: EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          padding: EdgeInsets.only(
            left: 60,
            right: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Wrap(
                  runSpacing: 5,
                  alignment: WrapAlignment.end,
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Text(
                      TimelineUtil.format(
                        DateTime.now().millisecondsSinceEpoch,
                      ),
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: '',
                        children: [
                          TextSpan(
                            text:
                                '据义乌公安，近日，王某成、邵某娟、毛某娟、邵某燕、鲁某科等人因涉嫌销售伪劣产品罪被警方依法刑事拘留，田某军在逃。下ー步，公安机关将加大案件侦办力度，对制假售假行为实行全链条打击',
                          ),
                        ],
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    child: Image.network(
                      'http://47.105.165.186:7100/public/avatar/06aa9aeb1ece0f4bc63a664ddef0404a.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'A Winnie 晴晴',
        ),
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              widget.context.forward('/portlet/chat/sessionsettings');
            },
            icon: Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                _onTapEvents.forEach((cb) {
                  cb();
                });
              },
              behavior: HitTestBehavior.opaque,
              child: EasyRefresh.custom(
                shrinkWrap: true,
                scrollController: _scrollController,
                controller: _controller,
                onRefresh: _onRefresh,
                slivers: items.map((item) {
                  return SliverToBoxAdapter(
                    child: item,
                  );
                }).toList(),
              ),
            ),
          ),
          _ChatSender(
            context: widget.context,
            onTapEvents: _onTapEvents,
            plusPanel: _PlusPannel(),
            stickerPanel: _StickerPanel(),
            textRegionController: _scrollController,
          ),
        ],
      ),
    );
  }
}

class _StickerPanel extends StatefulWidget {
  @override
  __StickerPanelState createState() => __StickerPanelState();
}

class __StickerPanelState extends State<_StickerPanel> {
  @override
  Widget build(BuildContext context) {
    var items = <Widget>[];
    for (var i = 0; i < 50; i++) {
      items.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          alignment: Alignment.center,
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Icon(
                Icons.face,
                size: 30,
                color: Colors.grey[700],
              ),
            ],
          ),
        ),
      );
    }
    return GridView(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        maxCrossAxisExtent: 40,
      ),
      scrollDirection: Axis.vertical,
      children: items.map((item) {
        return item;
      }).toList(),
    );
  }
}

class _PlusPannel extends StatefulWidget {
  @override
  _PlusPannelState createState() => _PlusPannelState();
}

class _PlusPannelState extends State<_PlusPannel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var items = <Widget>[];
    for (var i = 0; i < 13; i++) {
      items.add(
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          alignment: Alignment.center,
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Icon(
                Icons.camera_enhance,
                size: 35,
                color: Colors.grey[700],
              ),
              Text(
                '拍照',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
    return GridView(
      shrinkWrap: true,
      padding: EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 30.0,
        maxCrossAxisExtent: 80,
      ),
      scrollDirection: Axis.vertical,
      children: items.map((item) {
        return item;
      }).toList(),
    );
  }
}

enum _Action {
  plus,
  sticker,
}

class _ChatSender extends StatefulWidget {
  PageContext context;
  Widget plusPanel;
  Widget stickerPanel;
  ScrollController textRegionController;
  List<Function()> onTapEvents;

  _ChatSender({
    this.context,
    this.onTapEvents,
    this.plusPanel,
    this.stickerPanel,
    this.textRegionController,
  });

  @override
  __ChatSenderState createState() => __ChatSenderState();
}

class __ChatSenderState extends State<_ChatSender> {
  _Action _action;
  TextEditingController _controller;
  FocusNode _contentFocusNode;

  @override
  void initState() {
    _contentFocusNode = FocusNode();
    _controller = TextEditingController();
    widget.onTapEvents.add(() {
      _action = null;
      _contentFocusNode.unfocus();
      setState(() {});
    });
    _contentFocusNode.unfocus();
    super.initState();
  }

  @override
  void dispose() {
    _contentFocusNode.dispose();
    _controller.dispose();
    widget.onTapEvents.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var panel = null;
    switch (_action) {
      case _Action.plus:
        panel = widget.plusPanel;
        break;
      case _Action.sticker:
        panel = widget.stickerPanel;
        break;
    }
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    ExtendedTextField(
                      controller: _controller,
                      focusNode: _contentFocusNode,
                      maxLines: 1,
                      minLines: 1,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (v) {
                        print('-----$v');
                      },
                      autofocus: false,
                      onTap: () {
                        _action = null;
                        if(widget.textRegionController!=null) {
                          widget.textRegionController.jumpTo(widget.textRegionController.position.maxScrollExtent);
                        }
                        setState(() {});
                      },
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(0),
                            topRight: Radius.circular(20),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 5,
                          right: 38,
                          top: 15,
                          bottom: 15,
                        ),
                        prefixIcon: Icon(
                          Icons.text_fields,
                          size: 25,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 12,
                      child: SizedBox(
                        width: 25,
                        height: 25,
                        child: VoiceFloatingButton(
                          context: widget.context,
                          iconSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if(widget.textRegionController!=null) {
                    widget.textRegionController.jumpTo(widget.textRegionController.position.maxScrollExtent);
                  }
                  _action = _Action.sticker;
                  _contentFocusNode.unfocus();
                  setState(() {});
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 5,
                    top: 2,
                    bottom: 2,
                  ),
                  child: Icon(
                    FontAwesomeIcons.smileBeam,
                    size: 22,
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if(widget.textRegionController!=null) {
                    widget.textRegionController.jumpTo(widget.textRegionController.position.maxScrollExtent);
                  }
                  _action = _Action.plus;
                  _contentFocusNode.unfocus();
                  setState(() {});
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                    right: 10,
                    top: 2,
                    bottom: 2,
                  ),
                  child: Icon(
                    Icons.add_circle_outline,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
          _action == null
              ? Container(
                  width: 0,
                  height: 0,
                )
              : Container(
                  height: 200,
                  constraints: BoxConstraints.tightForFinite(
                    width: double.maxFinite,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  child: panel,
                ),
        ],
      ),
    );
  }
}
