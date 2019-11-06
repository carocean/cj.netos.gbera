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
                      '扫码以连接管道',
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
                '管道',
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
        child: Container(
          margin: EdgeInsets.only(
            bottom: 15,
          ),
          color: Colors.white,
          child: Column(
            children: [
              _ChannelItem(
                subtitle: '这程序写的真不错啊，好爽这程序写的真不错啊，好爽',
                title: '公共',
                imgSrc: Icon(
                  FontAwesomeIcons.ad,
                  color: Colors.grey[500],
                  size: 40,
                ),
                time: '22:14',
                who: 'carocean: ',
                openAvatar: () {
                  widget.context.forward(
                    '/netflow/channel/avatar',
                  );
                },
                openChannel: () {
                  widget.context.forward(
                    '/netflow/channel',
                    arguments: {'channel-name': '公共'},
                  );
                },
              ),
              Divider(
                height: 1,
                indent: 60,
              ),
              _ChannelItem(
                title: '朋友圈',
                subtitle: '当你学会 如何使用 后，你可以用 <i> 标签把 Font Awesome 图标放在任意位置。',
                imgSrc: Icon(
                  FontAwesomeIcons.addressBook,
                  color: Colors.grey[500],
                  size: 40,
                ),
                time: '6:27',
                who: 'bill: ',
                openAvatar: () {
                  widget.context.forward(
                    '/netflow/channel/avatar',
                  );
                },
                openChannel: () {
                  widget.context.forward(
                    '/netflow/channel',
                    arguments: {'channel-name': '朋友圈'},
                  );
                },
              ),
              Divider(
                height: 1,
                indent: 60,
              ),
              _ChannelItem(
                title: '地推',
                subtitle: '问TextField一个问题【flutter吧】_百度贴吧',
                imgSrc: Icon(
                  FontAwesomeIcons.random,
                  color: Colors.grey[500],
                  size: 40,
                ),
                time: '6:27',
                who: '会飞的鸟: ',
                openAvatar: () {
                  widget.context.forward(
                    '/netflow/channel/avatar',
                  );
                },
                openChannel: () {
                  widget.context.forward(
                    '/netflow/channel',
                    arguments: {'channel-name': '地推'},
                  );
                },
              ),
            ],
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate.fixed(
          _pipelineContentItemBuilder(widget),
        ),
      ),
    ];
//    _buildPipelineTab(panel, this);
    return CustomScrollView(
      controller: use_wallpapper ? _controller : null,
      slivers: panel,
    );
  }
}

List<Widget> _pipelineContentItemBuilder(widget) {
  return [
    _ChannelItem2(
      title: '欣欣',
      subtitle: '明天你能过来吗？我们谈谈',
      imgSrc: Image.network(
        'http://img.go007.com/2017/01/10/3b02d2dbdc8c4882_0.jpg',
        width: 40,
        height: 40,
      ),
      time: '7:57',
      who: '她说: ',
      openAvatar: () {
        widget.context.forward(
          '/netflow/channel/avatar',
        );
      },
      openChannel: () {
        widget.context.forward(
          '/netflow/channel',
          arguments: {'channel-name': '欣欣'},
        );
      },
    ),
    _ChannelItem2(
      title: '东峻广场',
      subtitle: '十九届四中全会：递补马正武、马伟明为中央委员',
      imgSrc: Icon(
        Icons.image,
        color: Colors.grey[500],
        size: 40,
      ),
      time: '12:32',
      who: 'wangx: ',
      openAvatar: () {
        widget.context.forward(
          '/netflow/channel/avatar',
        );
      },
      openChannel: () {
        widget.context.forward(
          '/netflow/channel',
          arguments: {'channel-name': '东峻广场'},
        );
      },
    ),
    _ChannelItem2(
      title: '青年高中',
      subtitle: '明年高校毕业生预计达874万人 同比增40万',
      imgSrc: Icon(
        Icons.image,
        color: Colors.grey[500],
        size: 40,
      ),
      time: '14:22',
      who: '教育部: ',
      openAvatar: () {
        widget.context.forward(
          '/netflow/channel/avatar',
        );
      },
      openChannel: () {
        widget.context.forward(
          '/netflow/channel',
          arguments: {'channel-name': '青年高中'},
        );
      },
    ),
  ];
}

class _ChannelItem extends StatelessWidget {
  Widget imgSrc;
  String title;
  String who;
  String subtitle;
  String time;
  var openAvatar;
  var openChannel;

  _ChannelItem({
    this.imgSrc,
    this.title,
    this.who,
    this.subtitle,
    this.time,
    this.openAvatar,
    this.openChannel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              onTap: openAvatar,
              child: SizedBox(
                width: 40,
                height: 40,
                child: imgSrc,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: openChannel,
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
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          time,
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
                          who,
                          style: TextStyle(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          this.subtitle,
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
    );
  }
}

class _ChannelItem2 extends StatelessWidget {
  Widget imgSrc;
  String title;
  String who;
  String subtitle;
  String time;
  var openAvatar;
  var openChannel;

  _ChannelItem2({
    this.imgSrc,
    this.title,
    this.who,
    this.subtitle,
    this.time,
    this.openAvatar,
    this.openChannel,
  });

  @override
  Widget build(BuildContext context) {
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
                    behavior: HitTestBehavior.opaque,
                    onTap: this.openAvatar,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: imgSrc,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: openChannel,
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
                                this.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                this.time,
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
                                this.who,
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                this.subtitle,
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
          Divider(
            height: 1,
            indent: 60,
          ),
        ],
      ),
    );
  }
}
