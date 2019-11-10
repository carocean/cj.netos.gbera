import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/pages/netflow/channel.dart';

import '../parts/headers.dart';
import 'package:qrscan/qrscan.dart' as scanner;

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
    var activities = <Activity>[
      Activity(
        who: '会飞的猪',
        money: '50.32',
        picCount: 0,
        time: '30秒前',
        content:
            '日前，世界文化遗产、日本冲绳县那霸市首里城发生大火，主要建筑物付之一炬。目前，冲绳县警方已基本确定起火点位于首里城正殿一层.',
        channel: '世界建筑',
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return widget.context
                    .part('/site/insite/request', context);
              });
        },
      ),
      Activity(
        who: '大理-家丽',
        money: '6.25',
        picCount: 1,
        time: '1分钟前',
        channel: '随便漫谈',
        content: '人间忽晚   山河已秋～        今晚大理的云，是哪位大神飞升上仙了吧...          晚安。',
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return widget.context
                    .part('/site/insite/request', context);
              });
        },
      ),
      Activity(
        who: 'YouTube精彩视频',
        money: '50.32',
        picCount: 1,
        time: '3分钟前',
        channel: '我的油管',
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return widget.context
                    .part('/site/insite/request', context);
              });
        },
        content:
            '【#把做菜拍出恐怖大片效果#】镜头的快速切换、食材的超近距离特写、阴暗的光线、急促的喘息声，都营造出一种令人窒息的感觉...最后那一刻真的被吓到！（cr：Insolence Productions）',
      ),
      Activity(
        who: '通信老柳',
        money: '50.32',
        picCount: 1,
        time: '15分钟前',
        channel: '中国联通',
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return widget.context
                    .part('/site/insite/request', context);
              });
        },
        content:
            '【业绩暴增374%不算啥，联通后面还有大招】​​​2018年可谓是中国联通混改见效年，从公布的一季度业绩来看，整体主营业务收入为人民币666.09亿元，比去年同期上升8.4%。移动主营业务收入达到人民币415.11亿元，比去年同期上升11.6%。利润总额为人民币39.78亿元，归属于母公司净利润为人民币13.02亿元，比去年同期明显上升374.8%',
      ),
      Activity(
        who: '乐播足球',
        money: '50.32',
        picCount: 8,
        time: '15分钟前',
        channel: '精彩集锦',
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return widget.context
                    .part('/site/insite/request', context);
              });
        },
        content:
            '#广域星空杯# 决赛—中国足球小将红队4：0浙江绿城[星星]吕孟洋爆射首开记录，高中锋赵松源展现灵活的脚下技巧用脚后跟穿裆过人贡献助攻，邝兆镭梅开二度当选本届赛事MVP和最佳射手！',
      ),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _NetflowAppBar(
          pageContext: widget.context,
          isBackgroundColorTransparent:
              use_wallpapper && _backgroud_transparent,
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              activities.length > 0
                  ? _ActivitiesRegion(
                      context: widget.context, activities: activities)
                  : Container(
                      width: 0,
                      height: 0,
                    ),
              Expanded(
                child: _MyChannelRegion(
                  scrollController: _controller,
                  context: widget.context,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Activity {
  String who;
  String content;
  String money;
  int picCount;
  String time;
  String channel;
  Function() onTap;
  Activity({
    this.who,
    this.content,
    this.money,
    this.picCount,
    this.time,
    this.channel,
    this.onTap,
  });
}

class _ActivitiesRegion extends StatefulWidget {
  List<Activity> activities = [];
  PageContext context;

  _ActivitiesRegion({this.activities, this.context});

  @override
  __ActivitiesRegionState createState() => __ActivitiesRegionState();
}

class __ActivitiesRegionState extends State<_ActivitiesRegion> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 10,
            bottom: 5,
          ),
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              widget.context.forward('/netflow/manager/publics',
                  arguments: {'title': '公众活动'});
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
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
                Text(
                  '公众活动',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          margin: EdgeInsets.only(
            bottom: 15,
            left: 10,
            right: 10,
          ),
          child: ListView(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            shrinkWrap: true,
            children: widget.activities.map((v) {
              index++;
              if (index >= widget.activities.length) {
                index = 0;
              }
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: v.onTap,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${v.who}:  ',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              text: '${v.content}',
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                        right: 10,
                        left: 10,
                      ),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            !StringUtil.isEmpty(v.time)
                                ? TextSpan(text: '${v.time}')
                                : TextSpan(text: ''),
                            !StringUtil.isEmpty(v.channel)
                                ? TextSpan(
                                    text: '',
                                    children: [
                                      TextSpan(text: '  来自管道:'),
                                      TextSpan(
                                        text: '${v.channel}',
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                : TextSpan(text: ''),
                            v.picCount > 0
                                ? TextSpan(text: '  图片${v.picCount}个')
                                : TextSpan(text: ''),
                            !StringUtil.isEmpty(v.money)
                                ? TextSpan(
                                    text: '  洇金:¥',
                                    children: [
                                      TextSpan(
                                        text: '${v.money}',
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                : TextSpan(text: ''),
                          ],
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    index < widget.activities.length
                        ? Container(
                            child: Divider(
                              height: 1,
                            ),
                            padding: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                          )
                        : Container(
                            width: 0,
                            height: 0,
                          ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _NetflowAppBar extends StatelessWidget {
  PageContext pageContext;
  bool isBackgroundColorTransparent;

  _NetflowAppBar({this.pageContext, this.isBackgroundColorTransparent});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          onSelected: (value) async {
            if (value == null) return;
            var arguments = <String, Object>{};
            switch (value) {
              case '/netflow/manager/create_channel':
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text('选择管道类型'),
                        children: <Widget>[
                          DialogItem(
                            text: '开放管道',
                            icon: Icons.invert_colors,
                            color: Colors.grey[500],
                            subtext: '管道动态及管道出入站联系人对他人可见',
                            onPressed: () {
                              pageContext.backward(result: <String,Object>{'type':'开放'});

                            },
                          ),
                          DialogItem(
                            text: '私有管道',
                            icon: Icons.invert_colors_off,
                            color: Colors.grey[500],
                            subtext: '管道动态及管道出入站联系人对他人不可见',
                            onPressed: () {
                              pageContext.backward(result: <String,Object>{'type':'私有'});
                            },
                          ),
                        ],
                      );
                    }).then((v){
                      print('xxxx-$v');
                      if(v==null)return;
                      pageContext.forward(value, arguments: v);
                });
                break;
              case '/netflow/manager/scan_channel':
                String cameraScanResult = await scanner.scan();
                if (cameraScanResult == null) break;
                arguments['qrcode'] = cameraScanResult;
                pageContext.forward(value, arguments: arguments);
                break;
              case '/netflow/manager/search_channel':
                pageContext.forward(value, arguments: arguments);
                break;
            }
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
                      pageContext
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
                      pageContext
                          .findPage('/netflow/manager/scan_channel')
                          ?.icon,
                      color: Colors.grey[500],
                      size: 15,
                    ),
                  ),
                  Text(
                    '扫码以连接',
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
                      pageContext
                          .findPage('/netflow/manager/search_channel')
                          ?.icon,
                      color: Colors.grey[500],
                      size: 15,
                    ),
                  ),
                  Text(
                    '搜索以连接',
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
      backgroundColor:
          this.isBackgroundColorTransparent ? Colors.transparent : null,
    );
  }
}

class _MyChannelRegion extends StatefulWidget {
  ScrollController scrollController;
  PageContext context;

  _MyChannelRegion({this.scrollController, this.context});

  @override
  __MyChannelRegionState createState() => __MyChannelRegionState();
}

class __MyChannelRegionState extends State<_MyChannelRegion> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: widget.scrollController,
      slivers: [
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
                  '我的管道',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
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
      ],
    );
  }
}

List<Widget> _pipelineContentItemBuilder(widget) {
  return [
    _ChannelItem(
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
    _ChannelItem(
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
    _ChannelItem(
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
