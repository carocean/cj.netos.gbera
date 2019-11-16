import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

import '../netflow.dart';

class PublicActivies extends StatefulWidget {
  PageContext pageContext;

  PublicActivies({this.pageContext});

  @override
  _PublicActiviesState createState() => _PublicActiviesState();
}

class _PublicActiviesState extends State<PublicActivies>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _allAct = <Activity>[];
    for (int i = 0; i < 100; i++) {
      _allAct.add(
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
                  return widget.pageContext.part('/site/insite/request', context);
                });
          },
          content:
          '【业绩暴增374%不算啥，联通后面还有大招】​​​2018年可谓是中国联通混改见效年，从公布的一季度业绩来看，整体主营业务收入为人民币666.09亿元，比去年同期上升8.4%。移动主营业务收入达到人民币415.11亿元，比去年同期上升11.6%。利润总额为人民币39.78亿元，归属于母公司净利润为人民币13.02亿元，比去年同期明显上升374.8%',
        ),
      );
    }
    var _privAct = <Activity>[];
    for (int i = 0; i < 100; i++) {
      _privAct.add(
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
                  return widget.pageContext
                      .part('/site/insite/request', context);
                });
          },
          content:
              '【#把做菜拍出恐怖大片效果#】镜头的快速切换、食材的超近距离特写、阴暗的光线、急促的喘息声，都营造出一种令人窒息的感觉...最后那一刻真的被吓到！（cr：Insolence Productions）',
        ),
      );
    }
    var _commAct = <Activity>[];
    for (int i = 0; i < 100; i++) {
      _commAct.add(
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
                  return widget.pageContext.part('/site/insite/request', context);
                });
          },
          content:
          '#广域星空杯# 决赛—中国足球小将红队4：0浙江绿城[星星]吕孟洋爆射首开记录，高中锋赵松源展现灵活的脚下技巧用脚后跟穿裆过人贡献助攻，邝兆镭梅开二度当选本届赛事MVP和最佳射手！',
        ),
      );
    }
    List<_Page> _allPages() => <_Page>[
          _Page(
            text: '全部',
            activities: _allAct,
          ),
          _Page(
            text: '私信',
            activities: _privAct,
          ),
          _Page(
            text: '其它',
            activities: _commAct,
          ),
        ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageContext.page.title),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              widget.pageContext.backward();
            },
          ),
        ],
        elevation: 0.0,
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          labelColor: Colors.black,
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          tabs: _allPages().map<Tab>((_Page page) {
            return Tab(
              text: page.text,
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: _allPages().map<Widget>((_Page page) {
          return SafeArea(
            top: false,
            bottom: false,
            child: Container(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: _ActivitiesRegion(
                context: widget.pageContext,
                activities: page.activities ?? [],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _Page {
  const _Page({this.text, this.activities});

  final String text;
  final List<Activity> activities;
}

class _ActivitiesRegion extends StatefulWidget {
  List<Activity> activities = [];
  PageContext context;

  _ActivitiesRegion({this.activities, this.context});

  @override
  _ActivitiesRegionState createState() => _ActivitiesRegionState();
}

class _ActivitiesRegionState extends State<_ActivitiesRegion> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Column(
              children: widget.activities.map((v) {
                index++;
                bool notBottom = index < widget.activities.length;
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
                          maxLines: 4,
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
                      notBottom
                          ? Container(
                              child: Divider(
                                height: 1,
                              ),
                              padding: EdgeInsets.only(
                                top: 10,
                                bottom: 10,
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
        ),
      ],
    );
  }
}
