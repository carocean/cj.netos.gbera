import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';

import '../parts/headers.dart';

class Netflow2 extends StatefulWidget {
  PageContext context;

  Netflow2({this.context});

  @override
  _Netflow2State createState() => _Netflow2State();
}

class _Netflow2State extends State<Netflow2> {
  var _controller;
  var _backgroud_transparent = true;
  bool use_wallpapper = false;

  _Netflow2State() {
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
    if (_backgroud_transparent && _controller.offset >= 100 - 48) {
      //48是appbar的高度，210是appbar展开发的总高
      setState(() {
        _backgroud_transparent = false;
      });
      return;
    }
    if (!_backgroud_transparent && _controller.offset < 100 - 48) {
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
        expandedHeight: 100,
        floating: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('网流'),
        centerTitle: true,
        backgroundColor: use_wallpapper && _backgroud_transparent
            ? Colors.transparent
            : null,
      ),
    ];
    _buildPipelineTab(panel);
    return CustomScrollView(
      controller: use_wallpapper ? _controller : null,
      slivers: panel,
    );
  }
}

void _buildPipelineTab(List<Widget> panel) {
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
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  size: 20,
                  color: Colors.grey[600],
                ),
              ),
            ],
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
              onTap: () {},
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  FontAwesomeIcons.odnoklassnikiSquare,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
              onTap: () {},
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  FontAwesomeIcons.grav,
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
                        '熟人圈',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
  panel.add(SliverFixedExtentList(
    itemExtent: 75, // I'm forcing item heights
    delegate: SliverChildBuilderDelegate(
      _pipelineContentItemBuilder,
      childCount: 50,
    ),
  ));
}

Widget _pipelineContentItemBuilder(BuildContext context, int index) {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      FontAwesomeIcons.grav,
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
                            '熟人圈',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
        Divider(
          height: 1,
          indent: 60,
        ),
      ],
    ),
  );
}
