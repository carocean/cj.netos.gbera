import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';

class ChannelViewer extends StatefulWidget {
  PageContext context;

  ChannelViewer({this.context});

  @override
  _ChannelViewerState createState() => _ChannelViewerState();
}

class _ChannelViewerState extends State<ChannelViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          _MyAppBar(
            context: widget.context,
            title: '云台花园',
            imgSrc:
                'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=4020444105,2348392909&fm=26&gp=0.jpg',
            myChannelName: '公共',
            money: '¥8.29',
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
                  title: '管道号',
                  tipsText: '00383882827222',
                  operator: Icon(
                    Icons.content_copy,
                    color: Colors.grey[400],
                    size: 18,
                  ),
                ),
                _CardItem(
                  title: '拥有者',
                  tipsText: '大飞果果',
                ),
                _CardItem(
                  title: '动态',
                  tipsText: '983条',
                ),
                _CardItem(
                  title: '微站',
                  tipsText: '百味果园;万达集团',
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
              title: '入站',
              items: [
                _CardItem(
                  title: '管道',
                  tipsText: '1200个',
                ),
                _CardItem(
                  title: '申请',
                  tipsText: '申请入站连结',
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
              title: '出站',
              items: [
                _CardItem(
                  title: '管道',
                  tipsText: '246.32万个',
                ),
                _CardItem(
                  title: '申请',
                  tipsText: '已通过',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardItem extends StatefulWidget {
  String title;
  IconData tipsIconData;
  String tipsText;
  Widget operator;

  _CardItem({
    this.title,
    this.tipsText = '',
    this.tipsIconData,
    this.operator,
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
    return Container(
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
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                          ),
                          child: item,
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    );
                  }
                  index = 0;
                  return Padding(
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                    child: item,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyAppBar extends StatefulWidget {
  PageContext context;
  String title;
  String imgSrc;
  String myChannelName;
  String money;

  _MyAppBar(
      {this.context, this.title, this.imgSrc, this.myChannelName, this.money});

  @override
  __MyAppBarState createState() => __MyAppBarState();
}

class __MyAppBarState extends State<_MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      floating: true,
      title: Text(
        widget.title,
      ),
      expandedHeight: 100,
      pinned: false,
      snap: true,
      leading: Image.network(
        widget.imgSrc,
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Container(
          padding: EdgeInsets.only(
            right: 10,
            left: 10,
          ),
          constraints: BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: 10,
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: '访问自',
                            children: [
                              TextSpan(
                                text: '我的管道',
                                style: TextStyle(),
                              ),
                              TextSpan(
                                text: widget.myChannelName,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              left: 5,
                            ),
                            child: Text.rich(
                              TextSpan(
                                text: '帮他推有钱:',
                                children: [
                                  TextSpan(text: widget.money),
                                ],
                              ),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 5,
                            ),
                            child: Icon(
                              FontAwesomeIcons.qrcode,
                              size: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 5,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey,
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
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            widget.context.backward();
          },
          icon: Icon(
            Icons.close,
          ),
        ),
      ],
    );
  }
}
