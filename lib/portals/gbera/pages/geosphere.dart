import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';

class Geosphere extends StatefulWidget {
  final PageContext context;

  Geosphere({this.context});

  @override
  _GeosphereState createState() => _GeosphereState();
}

class _GeosphereState extends State<Geosphere> {
  @override
  Widget build(BuildContext context) {
    var textStyle1_title = widget.context.style('/geosphere/title.text');
    var textStyle1_red = widget.context.style('/geosphere/title-red.text');
    var textStyle1_grey = widget.context.style('/geosphere/title-grey.text');

    //SliverPersistentHeaderDelegate 滑动可折叠头
    List<Widget> panel = [
      SliverAppBar(
        pinned: true,
        expandedHeight: 250,
        floating: false,
        titleSpacing: 10,
        title: Text(
          '广州市·天河区',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: <Widget>[],
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          title: Container(
            padding: EdgeInsets.only(
              bottom: 4,
              top: 4,
            ),
            constraints: BoxConstraints.tightForFinite(
              width: double.maxFinite,
            ),
            color: Theme.of(context).backgroundColor,
            child: Text(
              '我的地圈',
              style: widget.context.style('/geosphere/mydq.text'),
            ),
          ),
          titlePadding: EdgeInsets.only(
            left: 10,
          ),
          background: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ///金证喷泉展示区
              Container(
                padding: EdgeInsets.only(
                  top: 70,
                  left: 20,
                  right: 20,
                  bottom: 5,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
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
                                    style: textStyle1_title,
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
                                '50个',
                                style: textStyle1_red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          child: Image.asset(
                            'lib/portals/gbera/images/yuanbao.png',
                            width: 20,
                            height: 20,
                            color: Colors.grey[600],
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
                                    style: textStyle1_title,
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
                                '23个',
                                style: textStyle1_red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              ///市场
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          child: Icon(
                            FontAwesomeIcons.btc,
                            size: 16,
                            color: Colors.grey[400],
                          ),
                          padding: EdgeInsets.only(
                            right: 5,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  child: Text(
                                    '帑指:',
                                    style: widget.context.style('/geosphere/sec-title.text'),

                                  ),
                                  padding: EdgeInsets.only(
                                    right: 5,
                                  ),
                                ),
                                Text(
                                  '0.13283892091',
                                  style: textStyle1_red,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Text(
                                '广东省·帑银交易市场',
                                style: textStyle1_grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          child: Icon(
                            FontAwesomeIcons.wonSign,
                            size: 16,
                            color: Colors.grey[400],
                          ),
                          padding: EdgeInsets.only(
                            right: 5,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  child: Text(
                                    '纹指:',
                                    style: widget.context.style('/geosphere/sec-title.text'),
                                  ),
                                  padding: EdgeInsets.only(
                                    right: 5,
                                  ),
                                ),
                                Text(
                                  '0.002399281122',
                                  style: textStyle1_red,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Text(
                                '天河区·金证银行',
                                style: textStyle1_grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(
            right: 10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 1,
                ),
                child: Icon(
                  Icons.edit_location,
                  size: 12,
                  color: Colors.grey[500],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 4,
                ),
                child: Text(
                  '半径:',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: Text(
                  '5公里',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                '天豪大酒店附近',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(
            left: 0,
            top: 20,
            right: 0,
            bottom: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          child: Icon(
                            Icons.threesixty,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          padding: EdgeInsets.only(
                            right: 5,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 2,
                              ),
                              child: Text(
                                '实时',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 2,
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.levelDownAlt,
                                    color: Colors.grey[400],
                                    size: 12,
                                  ),
                                ),
                                Text(
                                  '624',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 2,
                              ),
                              child: Text(
                                '',
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 2,
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.share,
                                    size: 10,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Text(''),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          child: Icon(
                            FontAwesomeIcons.streetView,
                            size: 14,
                            color: Colors.grey[500],
                          ),
                          padding: EdgeInsets.only(
                            left: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            '发现',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          padding: EdgeInsets.only(
                            right: 10,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 10,
                            ),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              alignment: WrapAlignment.start,
                              direction: Axis.horizontal,
                              runSpacing: 10,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      child: Text(
                                        '行人',
                                        style: this.widget.context.style('/geosphere/discovery/title.text'),

                                      ),
                                      padding: EdgeInsets.only(
                                        right: 2,
                                      ),
                                    ),
                                    Padding(
                                      child: Text(
                                        '1.43万',
                                        style: this.widget.context.style('/geosphere/discovery/count.text'),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 5,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 16,
                                  padding: EdgeInsets.only(
                                    top: 2,
                                    bottom: 2,
                                  ),
                                  child: VerticalDivider(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      child: Text(
                                        '楼盘',
                                        style: this.widget.context.style('/geosphere/discovery/title.text'),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 2,
                                      ),
                                    ),
                                    Padding(
                                      child: Text(
                                        '100',
                                        style: this.widget.context.style('/geosphere/discovery/count.text'),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 5,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 16,
                                  padding: EdgeInsets.only(
                                    top: 2,
                                    bottom: 2,
                                  ),
                                  child: VerticalDivider(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      child: Text(
                                        '出租车',
                                        style: this.widget.context.style('/geosphere/discovery/title.text'),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 2,
                                      ),
                                    ),
                                    Padding(
                                      child: Text(
                                        '21',
                                        style: this.widget.context.style('/geosphere/discovery/count.text'),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 5,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 16,
                                  padding: EdgeInsets.only(
                                    top: 2,
                                    bottom: 2,
                                  ),
                                  child: VerticalDivider(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      child: Text(
                                        '餐馆',
                                        style: this.widget.context.style('/geosphere/discovery/title.text'),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 2,
                                      ),
                                    ),
                                    Padding(
                                      child: Text(
                                        '246',
                                        style: this.widget.context.style('/geosphere/discovery/count.text'),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 5,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 16,
                                  padding: EdgeInsets.only(
                                    top: 2,
                                    bottom: 2,
                                  ),
                                  child: VerticalDivider(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      child: Text(
                                        '酒店',
                                        style: this.widget.context.style('/geosphere/discovery/title.text'),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 2,
                                      ),
                                    ),
                                    Padding(
                                      child: Text(
                                        '246',
                                        style: this.widget.context.style('/geosphere/discovery/count.text'),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 5,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 16,
                                  padding: EdgeInsets.only(
                                    top: 2,
                                    bottom: 2,
                                  ),
                                  child: VerticalDivider(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      child: Text(
                                        '汽车4S店',
                                        style: this.widget.context.style('/geosphere/discovery/title.text'),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 2,
                                      ),
                                    ),
                                    Padding(
                                      child: Text(
                                        '246',
                                        style: this.widget.context.style('/geosphere/discovery/count.text'),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 5,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 16,
                                  padding: EdgeInsets.only(
                                    top: 2,
                                    bottom: 2,
                                  ),
                                  child: VerticalDivider(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      child: Text(
                                        '超市',
                                        style: this.widget.context.style('/geosphere/discovery/title.text'),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 2,
                                      ),
                                    ),
                                    Padding(
                                      child: Text(
                                        '83家',
                                        style: this.widget.context.style('/geosphere/discovery/count.text'),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 5,
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
                    Divider(
                      color: Colors.grey[300],
                      indent: 40,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                          ),
                          child: Icon(
                            Icons.message,
                            color: Colors.grey[500],
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            constraints: BoxConstraints.tightForFinite(
                              width: double.maxFinite,
                              height: double.infinity,
                            ),
                            child: ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int i) {
                                return Wrap(
                                  direction: Axis.horizontal,
                                  crossAxisAlignment: WrapCrossAlignment.end,
                                  runSpacing: 2,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 2,
                                      ),
                                      child: Text(
                                        '出租车王师傅[¥0.21]:',
                                        style: widget.context.style(
                                            '/geosphere/listItemMsgTitle.text'),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 2,
                                      ),
                                      child: Text(
                                        '驾龄21年，服务七星。空车服务七星。驾龄21年，服务七星。空车服务七星。',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(),
                                      child: Text(
                                        '23:26',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (BuildContext context, int i) {
                                return Divider(
                                  color: Colors.grey[300],
                                );
                              },
                              itemCount: 4,
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
      ),
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(
            left: 0,
            top: 20,
            right: 0,
            bottom: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          child: Icon(
                            FontAwesomeIcons.addressBook,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          padding: EdgeInsets.only(
                            right: 5,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 2,
                              ),
                              child: Text(
                                '地推',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 2,
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.levelDownAlt,
                                    size: 12,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Text(
                                  '624',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          right: 10,
                        ),
                        child: Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 2,
                                  ),
                                  child: Text(
                                    '',
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 2,
                                      ),
                                      child: Icon(
                                        FontAwesomeIcons.share,
                                        size: 10,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Text(''),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              child: Icon(
                                FontAwesomeIcons.addressBook,
                                size: 14,
                                color: Colors.grey[500],
                              ),
                              padding: EdgeInsets.only(
                                left: 5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          right: 10,
                        ),
                        child: Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 2,
                                  ),
                                  child: Text(
                                    '',
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 2,
                                      ),
                                      child: Icon(
                                        FontAwesomeIcons.share,
                                        size: 10,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Text(''),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              child: Icon(
                                FontAwesomeIcons.streetView,
                                size: 14,
                                color: Colors.grey[500],
                              ),
                              padding: EdgeInsets.only(
                                left: 5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        right: 10,
                      ),
                      child: Icon(
                        Icons.message,
                        color: Colors.grey[500],
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints.tightForFinite(
                          width: double.maxFinite,
                          height: double.infinity,
                        ),
                        child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int i) {
                            return Wrap(
                              direction: Axis.horizontal,
                              crossAxisAlignment: WrapCrossAlignment.end,
                              runSpacing: 2,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 2,
                                  ),
                                  child: Text(
                                    '出租车王师傅[¥0.21]:',
                                    style: widget.context.style(
                                        '/geosphere/listItemMsgTitle.text'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 2,
                                  ),
                                  child: Text(
                                    '驾龄21年，服务七星。空车服务七星。驾龄21年，服务七星。空车服务七星。',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(),
                                  child: Text(
                                    '23:26',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int i) {
                            return Divider(
                              color: Colors.grey[300],
                            );
                          },
                          itemCount: 4,
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
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(
            left: 0,
            top: 20,
            right: 0,
            bottom: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          child: Icon(
                            FontAwesomeIcons.blind,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          padding: EdgeInsets.only(
                            right: 5,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 2,
                              ),
                              child: Text(
                                '访客',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 2,
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.reply,
                                    color: Colors.grey[400],
                                    size: 12,
                                  ),
                                ),
                                Text(
                                  '624',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          right: 10,
                        ),
                        child: Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 2,
                                  ),
                                  child: Text(
                                    '',
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 2,
                                      ),
                                      child: Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.identity()
                                          ..rotateZ(80.1),
                                        child: Icon(
                                          FontAwesomeIcons.reply,
                                          size: 10,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                    Text(''),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              child: Icon(
                                FontAwesomeIcons.commentAlt,
                                size: 14,
                                color: Colors.grey[500],
                              ),
                              padding: EdgeInsets.only(
                                left: 5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          right: 10,
                        ),
                        child: Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 2,
                                  ),
                                  child: Text(
                                    '',
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 2,
                                      ),
                                      child: Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.identity()
                                          ..rotateZ(80.1),
                                        child: Icon(
                                          FontAwesomeIcons.reply,
                                          size: 10,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                    Text(''),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              child: Icon(
                                FontAwesomeIcons.streetView,
                                size: 14,
                                color: Colors.grey[500],
                              ),
                              padding: EdgeInsets.only(
                                left: 5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        right: 10,
                      ),
                      child: Icon(
                        Icons.message,
                        color: Colors.grey[500],
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints.tightForFinite(
                          width: double.maxFinite,
                          height: double.infinity,
                        ),
                        child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int i) {
                            return Wrap(
                              direction: Axis.horizontal,
                              crossAxisAlignment: WrapCrossAlignment.end,
                              runSpacing: 2,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 2,
                                  ),
                                  child: Text(
                                    '出租车王师傅[¥0.21]:',
                                    style: widget.context.style(
                                        '/geosphere/listItemMsgTitle.text'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 2,
                                  ),
                                  child: Text(
                                    '驾龄21年，服务七星。空车服务七星。驾龄21年，服务七星。空车服务七星。',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(),
                                  child: Text(
                                    '23:26',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int i) {
                            return Divider(
                              color: Colors.grey[300],
                            );
                          },
                          itemCount: 4,
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
    ];
    return SafeArea(
      child: CustomScrollView(
        slivers: panel,
      ),
    );
  }
}
