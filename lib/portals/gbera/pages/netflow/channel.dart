import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';
import 'package:image_picker/image_picker.dart';

class Channel extends StatefulWidget {
  PageContext context;

  Channel({this.context});

  @override
  _ChannelState createState() => _ChannelState();
}

class _ChannelState extends State<Channel> {
  //一定不能放在build中，因为build每次页面跳入跳出均会执行，而flutter就是靠key来保持状态的，如果放到build中则页面无状态
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    var panel = <Widget>[];
    _buildPlatTab(panel, widget, context, _scaffoldKey);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.context.parameters['channel-name'],
        ),
        titleSpacing: 0,
        elevation: 0,
        automaticallyImplyLeading: true,
        actions: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onLongPress: () {
              widget.context.forward('/netflow/channel/publish_article',
                  arguments: {'type': 'text'});
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
                          widget.context.backward(result: {'type': 'text'});
                        },
                      ),
                      DialogItem(
                        text: '拍摄',
                        icon: Icons.photo_camera,
                        color: Colors.grey[500],
                        onPressed: () async {
                          var image = await ImagePicker.pickImage(
                              source: ImageSource.camera);
                          widget.context.backward(result: {'type': 'take','image':image});
                        },
                      ),
                      DialogItem(
                        text: '从相册选择',
                        icon: Icons.image,
                        color: Colors.grey[500],
                        onPressed: () async {
                          var image = await ImagePicker.pickImage(
                              source: ImageSource.gallery);
                          widget.context.backward(result: {'type': 'select','image':image});
                        },
                      ),
                    ],
                  ),
                ).then<void>((value) {
                  // The value passed to Navigator.pop() or null.
                  if (value != null) {
                    widget.context.forward('/netflow/channel/publish_article',
                        arguments: value);
                  }
                });
              },
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        shrinkWrap: true,
//        controller: ScrollController(keepScrollOffset: true),
        slivers: panel,
      ),
    );
  }
}

void _buildPlatTab(List<Widget> panel, Channel widget, BuildContext context,
    GlobalKey<ScaffoldState> _scaffoldKey) {
  var header = SliverToBoxAdapter(
    child: Container(
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
              widget.context.forward('/netflow/manager/channel_gateway',
                  arguments: {'title': '公共'});
            },
            child: Padding(
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
          ),
        ],
      ),
    ),
  );
  var nopass = SliverToBoxAdapter(
    child: Card(
      shape: Border(),
      elevation: 0,
      margin: EdgeInsets.only(bottom: 15),
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '云台花园[¥6.25]:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return widget.context
                              .part('/site/insite/request', context);
                        });
                  },
                children: [
                  TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    text:
                        '日前，世界文化遗产、日本冲绳县那霸市首里城发生大火，主要建筑物付之一炬。目前，冲绳县警方已基本确定起火点位于首里城正殿一层.',
                  ),
                ],
              ),
              TextSpan(text: '\r\n'),
              TextSpan(
                text: '东山学校[¥12.30]:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return widget.context
                              .part('/site/insite/request', context);
                        });
                  },
                children: [
                  TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      text: '7万亿市值没了！中石油A股又创历史新低，暴跌90%，跌去了5个茅台！'),
                ],
              ),
            ],
          ),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ),
  );
  var item = SliverToBoxAdapter(
    child: Card(
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
                          '波涛旅行Hotel',
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
                                      '/network/channel/serviceMenu', context);
                                }).then((value){
                              print('-----$value');
                              widget.context.forward('/micro/app',arguments: value);
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
                    child: Text(
                      '不走形式，研发中心月度实现目标，由上级主管给出几个目标维度，被考核人自已填本月实际目标，并由主管审核下级目标，最终呈给人事部。工作态度：考核项固定',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        return Wrap(
                          //多媒体区
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                widget.context.forward(
                                  '/images/viewer',
                                  arguments: {
                                    'imgSrc':
                                        'http://www.zdyrs.com/uploadfile/2015/1205/20151205012936705.jpg',
                                    'text':
                                        '【#越南偷渡幸存者曾被发刀片#，随时准备逃生：为谋生要接受死亡】11月1日，英国警方发表声明称，早前死亡#货车内39名遇难者均为越南人#。越南方面称具体身份仍需查清，这是一场严重的人道惨剧。越南人Tran Khanh Toan2006年曾藏身集装箱偷渡到英国，但到了英国后因无法维持生计，又回到越南。他对梨视频拍客讲述了自己偷渡时有人在跳下集装箱时被卷入车轮，不幸遇难。而且藏身帆布货车的偷渡者，往往会被发刀片随时用来划开帆布跳车逃生',
                                  },
                                ).then((value) {
                                  print('--------');
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Image(
                                  image: NetworkImage(
                                      'http://www.zdyrs.com/uploadfile/2015/1205/20151205012936705.jpg'),
                                  width: (constraint.biggest.width / 2) - 20,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.context.forward(
                                  '/images/viewer',
                                  arguments: {
                                    'imgSrc':
                                        'http://dingyue.nosdn.127.net/vvRjNcu9VBGgAevyEl5kQ0PO4ndOa4p3KJcED=yrAyXUP1529905129060compressflag.jpg',
                                    'text':
                                        '据英国天空新闻报道，埃塞克斯警方发表声明称，早些时候集装箱货车内发现的39具遗体应全为越南公民。声明称，警方正与越南政府联系，并“直接联系”一些越南遇难者家属。另据越通社11月1日报道，越南中部河静省公安部门已拘捕两名涉嫌组织介绍他人非法出境或在境外非法滞留的人员。',
                                  },
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Image(
                                  image: NetworkImage(
                                      'http://dingyue.nosdn.127.net/vvRjNcu9VBGgAevyEl5kQ0PO4ndOa4p3KJcED=yrAyXUP1529905129060compressflag.jpg'),
                                  width: (constraint.biggest.width / 2) - 20,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.context.forward(
                                  '/images/viewer',
                                  arguments: {
                                    'imgSrc':
                                        'http://pic1.win4000.com/mobile/2019-03-20/5c91fe81d2606.jpg',
                                    'text':
                                        '近年来，小珍（化名）一直以吸收社会大量资金，“拆东墙补西墙”，吸收的资金一度高达5亿余元，资金缺口达1亿余元，一直到资金链断裂才主动自首，自首时账面上只剩下一千多元。',
                                  },
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Image(
                                  image: NetworkImage(
                                      'http://pic1.win4000.com/mobile/2019-03-20/5c91fe81d2606.jpg'),
                                  width: (constraint.biggest.width / 2) - 20,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.context.forward(
                                  '/images/viewer',
                                  arguments: {
                                    'imgSrc':
                                        'http://pic1.win4000.com/mobile/5/557802a8d8569.jpg',
                                  },
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Image(
                                  image: NetworkImage(
                                      'http://pic1.win4000.com/mobile/5/557802a8d8569.jpg'),
                                  width: (constraint.biggest.width / 2) - 20,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Row(
                    //内容坠
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: '1小时前',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[400],
                            ),
                            children: [
                              TextSpan(text: '  '),
                              TextSpan(text: '¥0.24'),
                              TextSpan(text: '\r\n'),
                              TextSpan(
                                text: '来自',
                                children: [
                                  TextSpan(
                                    text: '大飞果果',
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
                                  TextSpan(text: '的管道'),
                                  TextSpan(
                                    text: '水葫芦凉茶店',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        widget.context
                                            .forward("/channel/viewer");
                                      },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          softWrap: true,
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(
                          Icons.linear_scale,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        offset: Offset(
                          0,
                          35,
                        ),
                        onSelected: (value) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Container(
                              child: Text('$value'),
                            ),
                          ));
                        },
                        itemBuilder: (context) => <PopupMenuEntry<String>>[
                          PopupMenuItem(
                            value: 'like',
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
                                  '点赞',
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
//                          PopupMenuDivider(),
                        ],
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
                        Column(
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
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 5,
                              ),
                              child: Text.rich(
                                //评论区
                                TextSpan(
                                  text: '天空的云:',
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
                                      text:
                                          '学习一门新的语言，第一个呈现基本都是“hello world”。那么我们知道这个是文本显示的。所以第一个我们学习Text,话不多说，直接上代码',
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
    ),
  );
  panel.add(header);
  panel.add(nopass);
  panel.add(item);
  panel.add(item);
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
