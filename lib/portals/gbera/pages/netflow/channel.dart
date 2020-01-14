import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/parts/parts.dart';
import 'package:gbera/portals/gbera/store/entities.dart';
import 'package:image_picker/image_picker.dart';

class ChannelPage extends StatefulWidget {
  PageContext context;

  ChannelPage({this.context});

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  //一定不能放在build中，因为build每次页面跳入跳出均会执行，而flutter就是靠key来保持状态的，如果放到build中则页面无状态
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  var maxLines = 4;

  @override
  Widget build(BuildContext context) {
    Channel channel=widget.context.parameters['channel'];
    var panel = <Widget>[];
    _buildPlatTab(panel, widget, context, _scaffoldKey);
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
                  arguments: {'type': 'text','channel':channel});
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
                          widget.context.backward(
                              result: {'type': 'take', 'image': image});
                        },
                      ),
                      DialogItem(
                        text: '从相册选择',
                        icon: Icons.image,
                        color: Colors.grey[500],
                        onPressed: () async {
                          var image = await ImagePicker.pickImage(
                              source: ImageSource.gallery);
                          widget.context.backward(
                              result: {'type': 'select', 'image': image});
                        },
                      ),
                    ],
                  ),
                ).then<void>((value) {
                  // The value passed to Navigator.pop() or null.
                  if (value != null) {
                    value['channel']=channel;
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

  void _buildPlatTab(List<Widget> panel, ChannelPage widget, BuildContext context,
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
    var images=[
      'https://img13.360buyimg.com/n1/s450x450_jfs/t1/19941/13/11811/62942/5c93524eE2f3ea589/3de7edc227e93cc1.jpg',
      'https://img13.360buyimg.com/n1/s450x450_jfs/t1/25838/34/11949/63568/5c935252E474ec0fc/e18e4be5fa437998.jpg',
    ];
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
                                        '/netflow/channel/serviceMenu',
                                        context);
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
                          text:
                              '不走形式，研发中心月度实现目标，由上级主管给出几个目标维度，被考核人自已填本月实际目标，并由主管审核下级目标，最终呈给人事部。工作态度：考核项固定',
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
                      ),
                    ),
                    DefaultTabController(
                      length: images.length,
                      child: PageSelector(
                        images: images,
                        onImageTap: (url) {
                          widget.context.forward(
                            '/images/viewer',
                            arguments: {
                              'imgSrc': url,
                              'text': '',
                            },
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
                                        widget.context
                                            .forward("/site/personal");
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
                                        widget.context
                                            .forward("/site/personal");
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
    panel.add(item);
    panel.add(item);
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
