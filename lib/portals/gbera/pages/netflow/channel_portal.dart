import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/common/util.dart';
import 'package:gbera/portals/gbera/parts/parts.dart';

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
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  _scrollListener() {
    var sub = Adapt.screenH() / 3 - 60;
    print('${_controller.offset}----$sub');
    if (_controller.offset > sub) {
      if (!showAppBar) {
        setState(() {
          showAppBar = true;
        });
      }
      return;
    }
    if (_controller.offset < sub) {
      if (showAppBar) {
        setState(() {
          showAppBar = false;
        });
      }
      return;
    }
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
              height: 70,
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
      pinned: true,
      floating: false,
      snap: false,
      elevation: 0,
      expandedHeight: Adapt.screenH() / 3,
      backgroundColor: showAppBar ? Theme.of(context).appBarTheme.color : null,
      automaticallyImplyLeading: true,
      centerTitle: false,
      title: showAppBar ? Text('云台花园') : null,
      flexibleSpace: _Header(
        showAppBar: showAppBar,
        context: widget.context,
      ),
    );
  }
}

class _Header extends StatefulWidget {
  bool showAppBar;
  PageContext context;

  _Header({this.showAppBar, this.context});

  @override
  __HeaderState createState() => __HeaderState();
}

class __HeaderState extends State<_Header> {
  @override
  Widget build(BuildContext context) {
    if (widget.showAppBar) {
      return Container(
        width: 0,
        height: 0,
      );
    }

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
            bottom: -60,
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
                      child: GestureDetector(
                        onTap: () {
                          widget.context.forward('/site/personal');
                        },
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
                Container(
                  padding: EdgeInsets.only(
                    top: 5,
                  ),
                  child: Text.rich(
                    TextSpan(
                      text: '会飞之鱼',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.grey[400],
                      ),
                      children: [
                        TextSpan(text: '\r\n'),
                        TextSpan(text: '的管道'),
                        TextSpan(text: '云台花园'),
                      ],
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
  int maxlines = 4;

  @override
  Widget build(BuildContext context) {
    var images = [
      'https://img10.360buyimg.com/n1/jfs/t1/38567/16/12388/130326/5d395d2fEe96dc911/6dab21a2e90fa6cc.jpg',
      'https://img10.360buyimg.com/n1/jfs/t1/73939/39/6972/87180/5d511125Eb7307102/48b4456cf64402ea.jpg',
      'https://img10.360buyimg.com/n1/jfs/t1/78996/4/5354/106075/5d395d1bE465f0117/59c1c3608f69bded.jpg',
    ];
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
                    child: Text.rich(
                      TextSpan(
                        text:
                            '据香港商报网官博消息，11日，马鞍山一男子疑因政见不同，遭暴徒泼易燃液体点火，造成四成皮肤二级烧伤。由全国政协副主席、前行政长官梁振英发起和成立的803基金，旗下悬红爆料网站803.hk，悬赏30万港币缉拿凶手。                      此外，还有四个新增悬赏案件分别为：11.11在葵芳站运作中的港铁车厢纵火，造成乘客惊恐走避，悬赏30万港币;11.11在路面纵火和向行驶中校巴掷汽油弹，学童和乘客受惊，悬赏30万港币;11.11向行驶中港铁列车及铁轨掷铁枝及单车，险酿意外，悬赏30万港币;11.10沙田美心皇宫被严重“装修”，继续破坏不支持暴行的商户和食肆，悬赏20万港币。',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        recognizer: TapGestureRecognizer()..onTap=(){
                          setState(() {
                            if(maxlines==4) {
                              maxlines=100;
                            }else{
                              maxlines=4;
                            }
                          });
                        },
                      ),
                      maxLines: maxlines,
                      overflow: TextOverflow.ellipsis,
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
