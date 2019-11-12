import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/common/util.dart';

class ChannelPortal extends StatefulWidget {
  PageContext context;

  ChannelPortal({this.context});

  @override
  _ChannelPortalState createState() => _ChannelPortalState();
}

class _ChannelPortalState extends State<ChannelPortal> {
  _ChannelPortalState()
      : _controller = ScrollController(initialScrollOffset: 0.0),
        showAppBar = false {
    _controller.addListener(() {
      print('----${_controller.position.toString()}');
      var sub=70;
      if (_controller.offset >= sub) {
        setState(() {
          showAppBar = true;
        });
        return;
      }
      if (_controller.offset < sub) {
        setState(() {
          showAppBar = false;
        });
        return;
      }
    });
  }

  ScrollController _controller;
  bool showAppBar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: <Widget>[
          _getAppBar(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 80,
            ),
          ),
          SliverToBoxAdapter(
            child: _Body(
              context: widget.context,
            ),
          ),
        ],
      ),
    );
  }

  _getAppBar() {
    return SliverAppBar(
      titleSpacing: 0,
      pinned: showAppBar?true:false,
      floating: true,
      snap: true,
      elevation: 0,
      expandedHeight: Adapt.screenH() / 3,
      backgroundColor: showAppBar ? Theme.of(context).appBarTheme.color : null,
      automaticallyImplyLeading: true,
      centerTitle: true,
      title: showAppBar ? Text('猎头黄沾') : null,
      flexibleSpace: showAppBar ? null : _Header(),
    );
  }
}

class _Header extends StatefulWidget {
  @override
  __HeaderState createState() => __HeaderState();
}

class __HeaderState extends State<_Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.screenH() / 3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573584350457&di=348e3a088908202dd5e5aae49ff6fe17&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F2017-11-17%2F5a0e94afc140c.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            bottom: -40,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        right: 10,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.network(
                          'http://cdn1.mmia.com/spfocusimg/2012/914/renwu7121.jpg',
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        '没有行囊，没有目的，我孤独的走在路上。',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                  ),
                  child: Text(
                    '猎头黄沾',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
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

class _Body extends StatefulWidget {
  PageContext context;

  _Body({this.context});

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _ListRegion(
        context: widget.context,
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
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide.none,
      ),
      elevation: 2,
      borderOnForeground: true,
      semanticContainer: false,
      margin: EdgeInsets.only(
        bottom: 15,
        left: 10,
        right: 10,
      ),
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
                          '今天 12:30',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[900],
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Divider(
                      height: 1,
                    ),
                  ),
                  Container(
                    //内容区
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '据香港商报网官博消息，11日，马鞍山一男子疑因政见不同，遭暴徒泼易燃液体点火，造成四成皮肤二级烧伤。由全国政协副主席、前行政长官梁振英发起和成立的803基金，旗下悬红爆料网站803.hk，悬赏30万港币缉拿凶手。                      此外，还有四个新增悬赏案件分别为：11.11在葵芳站运作中的港铁车厢纵火，造成乘客惊恐走避，悬赏30万港币;11.11在路面纵火和向行驶中校巴掷汽油弹，学童和乘客受惊，悬赏30万港币;11.11向行驶中港铁列车及铁轨掷铁枝及单车，险酿意外，悬赏30万港币;11.10沙田美心皇宫被严重“装修”，继续破坏不支持暴行的商户和食肆，悬赏20万港币。',
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
                                        'http://cms-bucket.ws.126.net/2019/11/11/5f8050a570554d2688a673d30477da92.png?imageView&thumbnail=550x0',
                                    'text':
                                        '据英国天空新闻报道，埃塞克斯警方发表声明称，早些时候集装箱货车内发现的39具遗体应全为越南公民。声明称，警方正与越南政府联系，并“直接联系”一些越南遇难者家属。另据越通社11月1日报道，越南中部河静省公安部门已拘捕两名涉嫌组织介绍他人非法出境或在境外非法滞留的人员。',
                                  },
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Image(
                                  image: NetworkImage(
                                      'http://cms-bucket.ws.126.net/2019/11/11/5f8050a570554d2688a673d30477da92.png?imageView&thumbnail=550x0'),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
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
