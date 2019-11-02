import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';

import '../parts/headers.dart';

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
    if (_backgroud_transparent && _controller.offset >= 60 - 48) {
      //48是appbar的高度，210是appbar展开发的总高
      setState(() {
        _backgroud_transparent = false;
      });
      return;
    }
    if (!_backgroud_transparent && _controller.offset < 60 - 48) {
      setState(() {
        _backgroud_transparent = true;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    use_wallpapper = widget.context.parameters['use_wallpapper'];
    List<Widget> panel = [
      SliverAppBar(
        pinned: true,
        expandedHeight: 60,
        floating: false,
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
            onSelected: (value) {
              print(value);
              widget.context.forward(value);
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
                    Text('新建管道',style: TextStyle(
                      fontSize: 14,
                    ),),
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
                    Text('扫码以连接管道',style: TextStyle(
                      fontSize: 14,
                    ),),
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
                      '搜索以连接管道',
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
        backgroundColor: use_wallpapper && _backgroud_transparent
            ? Colors.transparent
            : null,
      ),
    ];
    _buildPipelineTab(panel, this);
    return CustomScrollView(
      controller: use_wallpapper ? _controller : null,
      slivers: panel,
    );
  }
}

void _buildPipelineTab(List<Widget> panel, _NetflowState state) {
  panel.add(SliverToBoxAdapter(
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
            '管道',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  ));
  var subItem = <Widget>[];
  panel.add(SliverToBoxAdapter(
    child: Container(
      margin: EdgeInsets.only(
        bottom: 15,
      ),
      color: Colors.white,
      child: Column(
        children: subItem,
      ),
    ),
  ));
  subItem.add(
    Container(
      margin: EdgeInsets.only(
        bottom: 15,
        left: 10,
        right: 10,
        top: 15,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: 10,
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                state.widget.context.forward(
                  '/netflow/channel/avatar',
                );
              },
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  FontAwesomeIcons.ad,
                  color: Colors.grey[500],
                  size: 40,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                state.widget.context.forward(
                  '/netflow/channel',
                  arguments: {'channel-name': '公共'},
                );
              },
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '公共',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '22:14',
                          style: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          right: 5,
                        ),
                        child: Text(
                          'cj:',
                          style: TextStyle(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '这程序写的真不错啊，好爽这程序写的真不错啊，好爽',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
  subItem.add(
    Divider(
      height: 1,
      indent: 60,
    ),
  );
  subItem.add(
    Container(
      margin: EdgeInsets.only(
        bottom: 15,
        left: 10,
        right: 10,
        top: 15,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: 10,
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  FontAwesomeIcons.addressBook,
                  color: Colors.grey[500],
                  size: 40,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '老友',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '2:56',
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        right: 5,
                      ),
                      child: Text(
                        'bill:',
                        style: TextStyle(
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '当你学会 如何使用 后，你可以用 <i> 标签把 Font Awesome 图标放在任意位置。',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
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
  );
  subItem.add(
    Divider(
      height: 1,
      indent: 60,
    ),
  );
  subItem.add(
    Card(
      shape: Border(),
      elevation: 0.0,
      margin: EdgeInsets.only(
        bottom: 15,
        left: 10,
        right: 10,
        top: 15,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: 10,
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: SizedBox(
                child: Icon(
                  FontAwesomeIcons.random,
                  color: Colors.grey[500],
                  size: 30,
                ),
                width: 40,
                height: 40,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '地推',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '2:56',
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        right: 5,
                      ),
                      child: Text(
                        '会飞的鸟:',
                        style: TextStyle(
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '问TextField一个问题【flutter吧】_百度贴吧',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
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
  );
  panel.add(
    SliverList(
      delegate: SliverChildListDelegate.fixed(
        _pipelineContentItemBuilder(),
      ),
    ),
  );
}

List<Widget> _pipelineContentItemBuilder() {
  return [
    Container(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {},
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.image,
                        color: Colors.grey[500],
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '东峻广场',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '2:56',
                              style: TextStyle(
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              right: 5,
                            ),
                            child: Text(
                              'wangx:',
                              style: TextStyle(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '十九届四中全会：递补马正武、马伟明为中央委员。',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
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
          Divider(
            height: 1,
            indent: 60,
          ),
        ],
      ),
    ),
    Container(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {},
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.image,
                        color: Colors.grey[500],
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '广东省政府',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '2:56',
                              style: TextStyle(
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              right: 5,
                            ),
                            child: Text(
                              '青年团:',
                              style: TextStyle(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '中国学者遭申根26国禁入境 曾拒与美情报部门合作',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
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
          Divider(
            height: 1,
            indent: 60,
          ),
        ],
      ),
    ),
    Container(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {},
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.image,
                        color: Colors.grey[500],
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '青年高中',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '2:56',
                              style: TextStyle(
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              right: 5,
                            ),
                            child: Text(
                              '教育部：',
                              style: TextStyle(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '明年高校毕业生预计达874万人 同比增40万',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
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
          Divider(
            height: 1,
            indent: 60,
          ),
        ],
      ),
    ),
    Container(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {},
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.network(
                        'http://img.go007.com/2017/01/10/3b02d2dbdc8c4882_0.jpg',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '欣欣',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '2:56',
                              style: TextStyle(
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              right: 5,
                            ),
                            child: Text(
                              '她说：',
                              style: TextStyle(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '明天你能过来吗？我们谈谈',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
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
          Divider(
            height: 1,
            indent: 60,
          ),
        ],
      ),
    ),
  ];
}
