import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';

class ChannelGateway extends StatefulWidget {
  PageContext context;
  String title;

  ChannelGateway({this.context, this.title}) {
    this.title = context.parameters['title'];
    assert(this.title != null);
  }

  @override
  _ChannelGatewayState createState() => _ChannelGatewayState();
}

class _ChannelGatewayState extends State<ChannelGateway> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '管道设置',
        ),
        titleSpacing: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              widget.context.backward();
            },
            icon: Icon(
              Icons.clear,
            ),
          ),
        ],
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _Card(
                title: '',
                items: [
                  _CardItem(
                    title: '管道号',
                    tipsText: '003838838727272',
                    onItemTap: () {
                      widget.context.forward('/netflow/channel/rename');
                    },
                    operator: Icon(
                      Icons.content_copy,
                      color: Colors.grey[400],
                      size: 18,
                    ),
                  ),
                  _CardItem(
                    title: '名称',
                    tipsText: '${widget.title}',
                    onItemTap: () {
                      widget.context.forward('/netflow/channel/rename');
                    },
                  ),
                  _CardItem(
                    title: '二维码',
                    tipsIconData: FontAwesomeIcons.qrcode,
                    onItemTap: () {
                      widget.context.forward('/netflow/channel/qrcode');
                    },
                  ),
                  _CardItem(
                    title: '微站',
                    tipsText: '百味湘菜馆',
                    onItemTap: () {
                      widget.context.forward('/site/marchant');
                    },
                  ),
                  _CardItem(
                    title: '动态',
                    tipsText: '245篇',
                    onItemTap: () {

                    },
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: _Card(
                title: '',
                items: [
                  _CardItem(
                    title: '推广',
                    tipsText: '让别人帮您推广本管道，请充钱',
                    onItemTap: () {
                      widget.context.forward('/netflow/channel/popularize');
                    },
                  ),
                  _CardItem(
                    title: '转让',
                    tipsText: '受让方除得到本管道且连同所属微站',
                    onItemTap: () {
                      widget.context.forward('/netflow/channel/popularize');
                    },
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: _Card(
                title: '管道进口',
                items: [
                  _CardItem(
                    title: '公众',
                    tipsText: '如果不愿接收某人的信息可将他移除',
                    onItemTap: () {
                      widget.context.forward('/netflow/channel/insite');
                    },
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: _Card(
                title: '管道出口',
                items: [
                  _CardItem(
                    title: '公众',
                    tipsText: '如果不愿让某人接收信息可将他移除',
                    onItemTap: () {
                      widget.context.forward('/netflow/channel/insite');
                    },
                  ),
                  _CardItem(
                    title: '地圈',
                    tipsText: '是否充许本管道的信息推送到我的地圈',
                    operator: _MySwitch(),
                    onItemTap: () {},
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

class _MySwitch extends StatefulWidget {
  bool value;

  _MySwitch({this.value = false});

  @override
  __MySwitchState createState() => __MySwitchState();
}

class __MySwitchState extends State<_MySwitch> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Switch.adaptive(
        value: widget.value,
        onChanged: (value) {
          setState(() {
            widget.value = value;
          });
        },
      ),
    );
  }
}

class _CardItem extends StatefulWidget {
  String title;
  IconData tipsIconData;
  String tipsText;
  Widget operator;
  Function() onItemTap;

  _CardItem({
    this.title,
    this.tipsText = '',
    this.tipsIconData,
    this.operator,
    this.onItemTap,
  }) {
    if (operator == null) {
      this.operator = Icon(
        Icons.arrow_forward_ios,
        size: 18,
        color: Colors.grey[500],
      );
    }
  }

  @override
  State createState() => _CardItemState();
}

class _CardItemState extends State<_CardItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: this.widget.onItemTap,
      child: Container(
        padding: EdgeInsets.only(
          top: 15,
          bottom: 15,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                right: 10,
              ),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: StringUtil.isEmpty(widget.tipsText)
                        ? Container(
                            width: 0,
                            height: 0,
                          )
                        : Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              widget.tipsText,
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                  ),
                  widget.tipsIconData == null
                      ? Container(
                          width: 0,
                          height: 0,
                        )
                      : Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(
                            widget.tipsIconData,
                            size: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: widget.operator,
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

class _Card extends StatefulWidget {
  String title;
  List<_CardItem> items;

  _Card({this.title, this.items});

  @override
  __CardState createState() => __CardState();
}

class __CardState extends State<_Card> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      constraints: BoxConstraints.tightForFinite(
        width: double.maxFinite,
      ),
      child: Row(
        children: <Widget>[
          StringUtil.isEmpty(widget.title)
              ? Container(
                  width: 0,
                  height: 0,
                )
              : Container(
                  width: 70,
                  child: Text(
                    widget.title,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
          Expanded(
            child: Container(
              child: Column(
                children: widget.items.map((item) {
                  if (index < widget.items.length - 1) {
                    index++;
                    return Column(
                      children: <Widget>[
                        item,
                        Divider(
                          height: 1,
                        ),
                      ],
                    );
                  }
                  index = 0;
                  return item;
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
