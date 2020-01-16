import 'package:common_utils/common_utils.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/common/swipe_refresh.dart';
import 'package:gbera/portals/gbera/pages/netflow/article_entities.dart';
import 'package:gbera/portals/gbera/parts/parts.dart';
import 'package:gbera/portals/gbera/store/entities.dart';
import 'package:gbera/portals/gbera/store/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ChannelPage extends StatefulWidget {
  PageContext context;

  ChannelPage({this.context});

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  List<ChannelMessage> pageMessages;
  int limit = 10, offset = 0;
  GlobalKey<_ChannelPageState> _scaffoldKey;

  //这是防止flutterBuilder重绘引起的页面状态无保持，致返回到列表页时总是在滚到顶
  Future<List<ChannelMessage>> _onloadFuture;

  @override
  void initState() {
    _scaffoldKey = GlobalKey<_ChannelPageState>();
    pageMessages = <ChannelMessage>[];
    _onloadFuture = _onload();
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldKey = null;
    pageMessages.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Channel channel = widget.context.parameters['channel'];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          channel?.name,
        ),
        titleSpacing: 0,
        elevation: 0,
        automaticallyImplyLeading: true,
        actions: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onLongPress: () {
              widget.context.forward('/netflow/channel/publish_article',
                  arguments: <String, dynamic>{
                    'type': 'text',
                    'channel': channel,
                    'refreshMessages': _refreshMessages
                  });
            },
            child: IconButton(
              icon: Icon(
                Icons.camera_enhance,
                size: 20,
              ),
              onPressed: () {
                showDialog<Map<String, Object>>(
                  context: context,
                  builder: (BuildContext context) => SimpleDialog(
                    title: Text('请选择'),
                    children: <Widget>[
                      DialogItem(
                        text: '文本',
                        subtext: '注：长按窗口右上角按钮便可不弹出该对话框直接发文',
                        icon: Icons.font_download,
                        color: Colors.grey[500],
                        onPressed: () {
                          widget.context.backward(
                              result: <String, dynamic>{'type': 'text'});
                        },
                      ),
                      DialogItem(
                        text: '从相册选择',
                        icon: Icons.image,
                        color: Colors.grey[500],
                        onPressed: () async {
                          var image = await ImagePicker.pickImage(
                              source: ImageSource.gallery);
                          widget.context.backward(result: <String, dynamic>{
                            'type': 'gallery',
                            'mediaFile': MediaFile(
                                type: MediaFileType.image, src: image),
                          });
                        },
                      ),
                    ],
                  ),
                ).then<void>((value) {
                  // The value passed to Navigator.pop() or null.
                  if (value != null) {
                    value['channel'] = channel;
                    value['refreshMessages'] = _refreshMessages;
                    widget.context.forward('/netflow/channel/publish_article',
                        arguments: value);
                  }
                });
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<ChannelMessage>>(
        //为了避免不能页面保持，所以赋予future，当future实例相同时FutureBuilder不再重绘
        future: _onloadFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: Container(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Container(
                width: 40,
                height: 40,
                child: Text('${snapshot.error}'),
              ),
            );
          }
          var slivers = <Widget>[
            SliverToBoxAdapter(
              child: _Header(
                context: widget.context,
              ),
            ),
          ];
          if (snapshot.data.isEmpty) {
            slivers.add(
              SliverFillRemaining(
                child: Container(
                  constraints: BoxConstraints.expand(),
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Text('没有活动'),
                  color: Colors.white,
                ),
              ),
            );
          }
          for (var msg in snapshot.data) {
            slivers.add(
              SliverToBoxAdapter(
                child: _MessageCard(
                  context: widget.context,
                  message: msg,
                  channel: channel,
                  onDeleted: (msg) {
                    snapshot.data.remove(msg);
                    setState(() {});
                  },
                ),
              ),
            );
          }
          return _MySwipeRefresh(
            onSwipeDown: _onSwipeDown,
            onSwipeUp: _onSwipeUp,
            slivers: slivers,
          );
        },
      ),
    );
  }

  _refreshMessages() async {
    this.offset = 0;
    this.pageMessages.clear();
    _onloadFuture = _onload();
  }

  Future<void> _onSwipeDown() async {}

  Future<void> _onSwipeUp() async {
    var onchannel = widget.context.parameters['channel']?.id;
    IChannelMessageService messageService =
        widget.context.site.getService('/channel/messages');
    var messages = await messageService.pageMessage(limit, offset, onchannel);
    if (messages == null || messages.length == 0) {
      return;
    }
    offset += messages.length;
    for (var msg in messages) {
      pageMessages.add(msg);
    }
  }

  Future<List<ChannelMessage>> _onload() async {
    await _onSwipeUp();
    return pageMessages;
  }
}

class _MySwipeRefresh extends StatefulWidget {
  Future<void> Function() onSwipeDown;
  Future<void> Function() onSwipeUp;
  List<Widget> slivers;

  _MySwipeRefresh({this.onSwipeDown, this.onSwipeUp, this.slivers});

  @override
  __MySwipeRefreshState createState() => __MySwipeRefreshState();
}

class __MySwipeRefreshState extends State<_MySwipeRefresh> {
  @override
  Widget build(BuildContext context) {
    return SwipeRefreshLayout(
      onSwipeDown: () async {
        await widget.onSwipeDown();
        setState(() {});
      },
      onSwipeUp: () async {
        await widget.onSwipeUp();
        setState(() {});
      },
      child: CustomScrollView(
        shrinkWrap: true,
//        controller: ScrollController(keepScrollOffset: true),
        slivers: widget.slivers,
      ),
    );
  }
}

class DialogItem extends StatelessWidget {
  const DialogItem(
      {Key key, this.icon, this.color, this.text, this.subtext, this.onPressed})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final String subtext;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 36.0, color: color),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: Text(text),
                  ),
                  subtext == null
                      ? Container(
                          width: 0,
                          height: 0,
                        )
                      : Container(
                          constraints: BoxConstraints.tightForFinite(
                            width: double.maxFinite,
                          ),
                          child: Text(
                            subtext,
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.grey[300],
                            ),
                            softWrap: true,
//                            overflow: TextOverflow.ellipsis,
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

class _Header extends StatelessWidget {
  PageContext context;

  _Header({this.context});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(
        top: 20,
        left: 15,
        bottom: 10,
        right: 15,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              this.context.forward('/netflow/manager/channel_gateway',
                  arguments: {'title': '公共'});
            },
            child: Padding(
              padding: EdgeInsets.only(
                right: 5,
              ),
              child: Icon(
                this.context.findPage('/netflow/manager/channel_gateway')?.icon,
                size: 18,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageCard extends StatefulWidget {
  PageContext context;
  ChannelMessage message;
  Channel channel;
  void Function(ChannelMessage message) onDeleted;

  _MessageCard({
    this.context,
    this.channel,
    this.message,
    this.onDeleted,
  });

  @override
  __MessageCardState createState() => __MessageCardState();
}

class __MessageCardState extends State<_MessageCard> {
  int maxLines = 4;
  Future<Person> _future_getPerson;
  Future<List<Media>> _future_getMedias;
  var _is_show_comment_editor = false;

  @override
  void initState() {
    _future_getPerson = _getPerson();
    _future_getMedias = _getMedias();
    super.initState();
  }

  @override
  void dispose() {
    _future_getPerson = null;
    _future_getMedias = null;
    _is_show_comment_editor = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var images = [
      'https://img13.360buyimg.com/n1/s450x450_jfs/t1/19941/13/11811/62942/5c93524eE2f3ea589/3de7edc227e93cc1.jpg',
      'https://img13.360buyimg.com/n1/s450x450_jfs/t1/25838/34/11949/63568/5c935252E474ec0fc/e18e4be5fa437998.jpg',
    ];
    return Card(
      shape: Border(),
      elevation: 0,
      margin: EdgeInsets.only(bottom: 15),
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                widget.context.forward('/site/marchant');
              },
              child: Padding(
                padding: EdgeInsets.only(top: 5, right: 5),
                child: ClipOval(
                  child: Image(
                    image: NetworkImage(
                        'https://sjbz-fd.zol-img.com.cn/t_s208x312c5/g5/M00/01/06/ChMkJ1w3FnmIE9dUAADdYQl3C5IAAuTxAKv7x8AAN15869.jpg'),
                    height: 35,
                    width: 35,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          widget.context.forward('/site/marchant');
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Text(
                          '${widget.message.creator}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return widget.context.part(
                                      '/netflow/channel/serviceMenu', context);
                                }).then((value) {
                              print('-----$value');
                              if (value == null) return;
                              widget.context
                                  .forward('/micro/app', arguments: value);
                            });
                          },
                          icon: Icon(
                            Icons.art_track,
                            size: 20,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    //内容区
                    padding: EdgeInsets.only(top: 5, bottom: 10),
                    alignment: Alignment.topLeft,
                    child: Text.rich(
                      TextSpan(
                        text: '${widget.message.text}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              if (maxLines == 4) {
                                maxLines = 100;
                              } else {
                                maxLines = 4;
                              }
                            });
                          },
                      ),
                      maxLines: maxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  FutureBuilder<List<Media>>(
                    future: _future_getMedias,
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Container(
                          width: 0,
                          height: 0,
                        );
                      }
                      if (snapshot.hasError) {
                        print('${snapshot.error}');
                        return Container(
                          width: 0,
                          height: 0,
                        );
                      }
                      if (snapshot.data.isEmpty) {
                        return Container(
                          width: 0,
                          height: 0,
                        );
                      }
                      return DefaultTabController(
                        length: snapshot.data.length,
                        child: PageSelector(
                          medias: snapshot.data,
                          onMediaTap: (media) {
                            widget.context.forward(
                              '/images/viewer',
                              arguments: {
                                'media': media,
                                'others': snapshot.data,
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Row(
                    //内容坠
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: FutureBuilder<Person>(
                            future: _future_getPerson,
                            builder: (ctx, snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                return Container(
                                  width: 0,
                                  height: 0,
                                );
                              }
                              if (snapshot.hasError) {
                                print('${snapshot.error}');
                                return Container(
                                  width: 0,
                                  height: 0,
                                );
                              }
                              return Text.rich(
                                TextSpan(
                                  text: '${TimelineUtil.format(
                                    widget.message.ctime,
                                    dayFormat: DayFormat.Full,
                                  )}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[400],
                                  ),
                                  children: [
                                    TextSpan(text: '  '),
                                    TextSpan(
                                        text:
                                            '¥${(widget.message.wy * 0.001).toStringAsFixed(2)}'),
                                    TextSpan(text: '\r\n'),
                                    TextSpan(
                                      text:
                                          '${widget.context.userPrincipal?.uid == snapshot.data.uid ? '创建自 ' : '来自 '}',
                                      children: [
                                        TextSpan(
                                          text:
                                              '${widget.context.userPrincipal?.uid == snapshot.data.uid ? '我' : snapshot.data.accountName}',
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              widget.context
                                                  .forward("/site/personal");
                                            },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                softWrap: true,
                              );
                            }),
                      ),
                      _MessageOperatorRegion(
                        message: widget.message,
                        context: widget.context,
                        onDeleted: () {
                          if (widget.onDeleted != null) {
                            widget.onDeleted(widget.message);
                          }
                        },
                        onComment: () {
                          _is_show_comment_editor = true;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: Color(0xFFF5F5F5),
                    ),
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 5,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //相关操作区
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                right: 5,
                              ),
                              child: Icon(
                                FontAwesomeIcons.thumbsUp,
                                color: Colors.grey[500],
                                size: 16,
                              ),
                            ),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '吉儿',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          widget.context
                                              .forward("/site/personal");
                                        },
                                    ),
                                    TextSpan(text: ';  '),
                                    TextSpan(
                                      text: '布谷鸟',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          widget.context
                                              .forward("/site/personal");
                                        },
                                    ),
                                    TextSpan(text: ';  '),
                                    TextSpan(
                                      text: '大飞果果',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          widget.context
                                              .forward("/site/personal");
                                        },
                                    ),
                                    TextSpan(text: ';  '),
                                    TextSpan(
                                      text: '中国好味道',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          widget.context
                                              .forward("/site/personal");
                                        },
                                    ),
                                    TextSpan(text: ';  '),
                                  ],
                                ),
//                                maxLines: 4,
//                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 6,
                            top: 6,
                          ),
                          child: Divider(
                            height: 1,
                          ),
                        ),
                        ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 5,
                              ),
                              child: Text.rich(
                                //评论区
                                TextSpan(
                                  text: 'carocean:',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      widget.context.forward("/site/personal");
                                    },
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueGrey,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '当实现具备实时性需求时，我们一般会选择长连接的通信方式',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                softWrap: true,
                              ),
                            ),
                            _is_show_comment_editor
                                ? _CommentEditor(
                                    onFinished: () {
                                      _is_show_comment_editor = false;
                                      setState(() {});
                                    },
                                  )
                                : Container(
                                    width: 0,
                                    height: 0,
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Person> _getPerson() async {
    IPersonService personService =
        widget.context.site.getService('/upstream/persons');
    var person = '';
    if (!StringUtil.isEmpty(widget.message.upstreamPerson)) {
      person = widget.message.upstreamPerson;
    }
    if (StringUtil.isEmpty(person)) {
      person = widget.message.creator;
    }
    if (StringUtil.isEmpty(person)) {
      return null;
    }
    return await personService.getPerson(person);
  }

  Future<List<Media>> _getMedias() async {
    IChannelMediaService channelMediaService =
        widget.context.site.getService('/channel/messages/medias');
    return await channelMediaService.getMedias(widget.message.id);
  }
}

class _CommentEditor extends StatefulWidget {
  void Function() onFinished;

  _CommentEditor({this.onFinished});

  @override
  __CommentEditorState createState() => __CommentEditorState();
}

class __CommentEditorState extends State<_CommentEditor> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Flexible(
            //解决了无法计算边界问题
            fit: FlexFit.tight,
            child: ExtendedTextField(
              controller: _controller,
              autofocus: true,
              style: TextStyle(
                fontSize: 14,
              ),
              maxLines: 50,
              minLines: 4,
              decoration: InputDecoration(
                prefixText: '说道>',
                prefixStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                labelText: 'carocean',
                labelStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500,
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: '输入您的评论',
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.tag_faces,
                  size: 14,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.check,
                  size: 14,
                ),
                onPressed: () {
                  if (widget.onFinished != null) {
                    widget.onFinished();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MessageOperatorRegion extends StatefulWidget {
  ChannelMessage message;
  PageContext context;
  void Function() onDeleted;
  void Function() onComment;

  _MessageOperatorRegion(
      {this.message, this.context, this.onDeleted, this.onComment});

  @override
  __MessageOperatorRegionState createState() => __MessageOperatorRegionState();
}

class __MessageOperatorRegionState extends State<_MessageOperatorRegion> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Map<String, bool>> _getOperatorRights() async {
    bool isLiked = await _isLiked();
    return {
      'isLiked': isLiked,
      'canComment': true,
      'canDelete':
          widget.message.creator == widget.context.userPrincipal.person,
    };
  }

  Future<bool> _isLiked() async {
    IChannelLikeService likeService =
        widget.context.site.getService('/channel/messages/likes');
    return await likeService.isLiked(
        widget.message.id, widget.context.userPrincipal.person);
  }

  Future<void> _like() async {
    IChannelLikeService likeService =
        widget.context.site.getService('/channel/messages/likes');
    LikePerson likePerson = LikePerson(
        '${Uuid().v1()}',
        widget.context.userPrincipal.person,
        widget.context.userPrincipal.avatar,
        widget.message.id,
        DateTime.now().millisecondsSinceEpoch);
    await likeService.like(likePerson);
  }

  Future<void> _unlike() async {
    IChannelLikeService likeService =
        widget.context.site.getService('/channel/messages/likes');
    await likeService.unlike(
        widget.message.id, widget.context.userPrincipal.person);
  }

  Future<void> _deleteMessage() async {
    IChannelMessageService messageService =
        widget.context.site.getService('/channel/messages');
    messageService.removeMessage(widget.message.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getOperatorRights(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError) {
          print('${snapshot.error}');
        }
        var rights = snapshot.data;

        return PopupMenuButton<String>(
          icon: Icon(
            Icons.linear_scale,
            size: 14,
            color: Colors.grey[600],
          ),
          offset: Offset(
            0,
            35,
          ),
          onSelected: (value) async{
            if (StringUtil.isEmpty(value)) {
              return;
            }
            switch (value) {
              case 'like':
                _like().whenComplete(() {
                  setState(() {});
                });
                break;
              case 'unlike':
                _unlike().whenComplete(() {
                  setState(() {});
                });
                break;
              case 'comment':
                if (widget.onComment != null) {
                  widget.onComment();
                }
                break;
              case 'delete':
                _deleteMessage().whenComplete(() {
                  if (widget.onDeleted != null) {
                    widget.onDeleted();
                  }
                });
                break;
              default:
                print('未支付的操作:$value');
                break;
            }
          },
          itemBuilder: (context) => <PopupMenuEntry<String>>[
            PopupMenuItem(
              value: rights['isLiked'] ? 'unlike' : 'like',
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                    child: Icon(
                      FontAwesomeIcons.thumbsUp,
                      color: Colors.grey[500],
                      size: 15,
                    ),
                  ),
                  Text(
                    rights['isLiked'] ? '取消点赞' : '点赞',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'comment',
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                    child: Icon(
                      FontAwesomeIcons.comment,
                      color: Colors.grey[500],
                      size: 15,
                    ),
                  ),
                  Text(
                    '评论',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            rights['canDelete']
                ? PopupMenuDivider()
                : Container(
                    height: 0,
                    width: 0,
                  ),
            rights['canDelete']
                ? PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                          ),
                          child: Icon(
                            FontAwesomeIcons.comment,
                            color: Colors.grey[500],
                            size: 15,
                          ),
                        ),
                        Text(
                          '删除',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: 0,
                    height: 0,
                  ),
          ],
        );
      },
    );
  }
}
