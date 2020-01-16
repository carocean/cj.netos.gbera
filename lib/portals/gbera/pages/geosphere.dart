import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/parts/CardItem.dart';
import 'package:gbera/portals/gbera/parts/parts.dart';
import 'package:gbera/portals/gbera/store/entities.dart';
import 'package:image_picker/image_picker.dart';

import 'netflow/channel.dart';

class Geosphere extends StatefulWidget {
  PageContext context;

  Geosphere({this.context});

  @override
  _GeosphereState createState() => _GeosphereState();
}

class _GeosphereState extends State<Geosphere> with AutomaticKeepAliveClientMixin{
  var _controller;
  var _backgroud_transparent = true;
  bool use_wallpapper = false;

  @override
  bool get wantKeepAlive {
    return true;
  }

  @override
  void initState() {
    _controller = ScrollController(initialScrollOffset: 0.0);
    _controller.addListener(_listener);
  }

  _listener() {
    if (!use_wallpapper) {
      return;
    }
    if (_backgroud_transparent && _controller.offset >= 40) {
      //48是appbar的高度，210是appbar展开发的总高
      if (_backgroud_transparent) {
        setState(() {
          _backgroud_transparent = false;
        });
      }
      return;
    }
    if (!_backgroud_transparent && _controller.offset < 40) {
      if (!_backgroud_transparent) {
        setState(() {
          _backgroud_transparent = true;
        });
      }
      return;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    use_wallpapper = widget.context.parameters['use_wallpapper'];
    return CustomScrollView(
      controller: _controller,
      slivers: <Widget>[
        SliverAppBar(
          title: Text('地圈'),
          pinned: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          backgroundColor: use_wallpapper && _backgroud_transparent
              ? Colors.transparent
              : null,
          actions: <Widget>[
            _PopupMenu(
              context: widget.context,
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: _GeoRegion(
            context: widget.context,
            onTapFountain: () {
              widget.context.forward('/geosphere/fountain');
            },
            onTapYuanbao: () {
              widget.context.forward('/geosphere/yuanbao');
            },
          ),
        ),
        SliverToBoxAdapter(
          child: _Content(
            context: widget.context,
            onTapMarchant: (value) {
              widget.context.forward('/site/personal');
            },
            onTapDiscovery: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return widget.context.part('/geosphere/discovery', context);
                  }).then((v) {
                print('----$v');
              });
            },
            onTapGeoCircle: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return widget.context.part('/geosphere/settings', context);
                  }).then((v) {
                print('----$v');
              });
            },
          ),
        ),
      ],
    );
  }
}

class _PopupMenu extends StatelessWidget {
  PageContext context;

  _PopupMenu({this.context});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPress: () {
        this.context.forward('/netflow/channel/publish_article',
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
                    this.context.backward(result: {'type': 'text'});
                  },
                ),
                DialogItem(
                  text: '拍摄',
                  icon: Icons.photo_camera,
                  color: Colors.grey[500],
                  onPressed: () async {
                    var image =
                        await ImagePicker.pickImage(source: ImageSource.camera);
                    this
                        .context
                        .backward(result: {'type': 'take', 'image': image});
                  },
                ),
                DialogItem(
                  text: '从相册选择',
                  icon: Icons.image,
                  color: Colors.grey[500],
                  onPressed: () async {
                    var image = await ImagePicker.pickImage(
                        source: ImageSource.gallery);
                    this
                        .context
                        .backward(result: {'type': 'select', 'image': image});
                  },
                ),
              ],
            ),
          ).then<void>((value) {
            // The value passed to Navigator.pop() or null.
            if (value != null) {
              this.context.forward('/netflow/channel/publish_article',
                  arguments: value);
            }
          });
        },
      ),
    );
  }
}

class _GeoRegion extends StatelessWidget {
  PageContext context;
  Function() onTapFountain;
  Function() onTapYuanbao;

  _GeoRegion({this.context, this.onTapYuanbao, this.onTapFountain});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              bottom: 30,
              left: 10,
              right: 10,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.location_on,
                    size: 14,
                    color: Colors.grey,
                  ),
                  padding: EdgeInsets.only(
                    right: 5,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '广州',
                    children: [
                      TextSpan(
                        text: '·',
                      ),
                      TextSpan(
                        text: '天河区',
                      ),
                    ],
                  ),
                  softWrap: true,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (this.onTapFountain != null) {
                      this.onTapFountain();
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        child: Image.asset(
                          'lib/portals/gbera/images/penquan.png',
                          color: Colors.grey[600],
                          width: 20,
                          height: 20,
                        ),
                        padding: EdgeInsets.only(
                          right: 5,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                child: Text(
                                  '金证喷泉',
                                ),
                                padding: EdgeInsets.only(
                                  right: 5,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Text(
                              '2个',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (onTapYuanbao == null) {
                      return;
                    }
                    onTapYuanbao();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        child: Image.asset(
                          'lib/portals/gbera/images/yuanbao.png',
                          color: Colors.grey[600],
                          width: 20,
                          height: 20,
                        ),
                        padding: EdgeInsets.only(
                          right: 5,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                child: Text(
                                  '元宝',
                                ),
                                padding: EdgeInsets.only(
                                  right: 5,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Text(
                              '129个',
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
          Container(
//            color: Colors.white54,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return this
                              .context
                              .part('/geosphere/region', context);
                        });
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: CardItem(
                      title: '市场',
                      paddingBottom: 12,
                      paddingTop: 12,
                      titleColor: Colors.grey[600],
                      leading: Icon(
                        FontAwesomeIcons.trademark,
                        color: Colors.grey[500],
                        size: 20,
                      ),
                      tail: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey[400],
                        size: 18,
                      ),
                      tipsText: '本地区有3个',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatefulWidget {
  PageContext context;
  Function() onTapDiscovery;
  Function() onTapGeoCircle;
  Function(Object args) onTapMarchant;

  _Content(
      {this.context,
      this.onTapDiscovery,
      this.onTapMarchant,
      this.onTapGeoCircle});

  @override
  __ContentState createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 5,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (widget.onTapGeoCircle != null) {
                        widget.onTapGeoCircle();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        right: 10,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              right: 10,
                            ),
                            child: Text(
                              '我的地圈',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 5,
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.streetView,
                                    size: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '半径5公里',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (widget.onTapDiscovery != null) {
                      widget.onTapDiscovery();
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          child: Text(
                            '发现|1930个',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 5,
                        ),
                        child: Icon(
                          FontAwesomeIcons.filter,
                          size: 12,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.yellowAccent[100],
            ),
            constraints: BoxConstraints.tightForFinite(width: double.maxFinite),
            margin: EdgeInsets.only(
              top: 5,
              bottom: 10,
              left: 20,
              right: 20,
            ),
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 5,
              bottom: 5,
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (widget.onTapMarchant != null) {
                  widget.onTapMarchant({"uid": '出租车王师傅'});
                }
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '出租车王师傅',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(text: ':'),
                    TextSpan(text: '进入您的地圈'),
                  ],
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          _ListRegion(
            context: widget.context,
          ),
        ],
      ),
    );
  }
}

class _ListRegion extends StatefulWidget {
  PageContext context;

  _ListRegion({this.context});

  @override
  __ListRegionState createState() => __ListRegionState();
}

class __ListRegionState extends State<_ListRegion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _MessageCard(
            context: widget.context,
          ),
          _MessageCard(
            context: widget.context,
          ),
        ],
      ),
    );
  }
}

class _MessageCard extends StatefulWidget {
  PageContext context;

  _MessageCard({this.context});

  @override
  __MessageCardState createState() => __MessageCardState();
}

class __MessageCardState extends State<_MessageCard> {
  var maxLines = 4;

  @override
  Widget build(BuildContext context) {
    var images = [
      Media(null,'image','https://img12.360buyimg.com/n1/jfs/t1/64956/8/15150/216341/5dcbfa37Ec377dabf/b37dc8a39696eadb.jpg',null,null,null),
      Media(null,'image','https://img12.360buyimg.com/n1/jfs/t30010/114/1514509429/178688/f90faa12/5ce22d74N5a7de92f.jpg',null,null,null),
      Media(null,'image','https://img14.360buyimg.com/n5/s75x75_jfs/t21145/102/253959384/30146/76597635/5b07771aNbbad67a3.jpg',null,null,null),
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
                        text:
                            '不走形式，研发中心月度实现目标，由上级主管给出几个目标维度，不走形式，研发中心月度实现目标，由上级主管给出几个目标维度，被考核人自已填本月实际目标，并由主管审核下级目标，最终呈给人事部。工作态度：考核项固定',
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
                  DefaultTabController(
                    length: images.length,
                    child: PageSelector(
                      medias: images,
                      onMediaTap: (media) {
                        widget.context.forward(
                          '/images/viewer',
                          arguments: {
                            'media': media,
                            'others': images,
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
                          Scaffold.of(context).showSnackBar(SnackBar(
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
    );
  }
}
