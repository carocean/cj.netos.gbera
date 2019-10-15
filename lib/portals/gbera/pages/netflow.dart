import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gbera/netos/common.dart';

import '../parts/headers.dart';

class Netflow extends StatefulWidget {
  PageContext context;

  Netflow({this.context});

  @override
  _NetflowState createState() => _NetflowState();
}

class _NetflowState extends State<Netflow> {
  int selectTabIndex;

  _NetflowState() {
    selectTabIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> panel = [
      SliverAppBar(
        pinned: true,
        expandedHeight: 60,
        floating: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: getNetflowHeader(
            selectTabIndex: selectTabIndex,
            onTap: (index) {
              setState(() {
                selectTabIndex = index;
              });
            }),
      ),
    ];
    if (selectTabIndex == 0) {
      _buildPipelineTab(panel);
    } else if (selectTabIndex == 1) {
      _buildPlatTab(panel);
    }
    return SafeArea(
      child: CustomScrollView(
        slivers: panel,
      ),
    );
  }
}

void _buildPipelineTab(List<Widget> panel) {
  panel.add(SliverToBoxAdapter(
    child: Container(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        '管道',
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
        ),
      ),
    ),
  ));
  panel.add(SliverToBoxAdapter(
    child: Card(
      shape: Border(),
      elevation: 0.0,
      margin: EdgeInsets.only(
        bottom: 10,
      ),
      child: ListTile(
        leading: IconButton(
          icon: Image(
            image: NetworkImage(
                'http://pic-bucket.ws.126.net/photo/0001/2019-08-24/ENBGPJEM00AO0001NOS.jpg'),
          ),
        ),
        trailing: Padding(
          padding: EdgeInsets.only(
            top: 0,
            bottom: 20,
          ),
          child: Text('10:40'),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '[29/243]',
              style: TextStyle(fontSize: 12),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 1),
              child: Text(
                '旺京酒店',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 1, right: 5),
              child: Text(
                '说:',
                style: TextStyle(fontSize: 12),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                '招服务员2名',
                style: TextStyle(
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        title: Text('公共'),
      ),
    ),
  ));
  panel.add(SliverToBoxAdapter(
    child: Card(
      shape: Border(),
      elevation: 0.0,
      margin: EdgeInsets.only(
        bottom: 10,
      ),
      child: ListTile(
        leading: IconButton(
          icon: Image(
            image: NetworkImage(
                'http://pic-bucket.ws.126.net/photo/0003/2019-08-24/ENB1RG1000AJ0003NOS.jpg'),
          ),
        ),
        trailing: Padding(
          padding: EdgeInsets.only(
            top: 0,
            bottom: 20,
          ),
          child: Text('23:22'),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '[93/43]',
              style: TextStyle(fontSize: 12),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 1),
              child: Text(
                '新华小学',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 1, right: 5),
              child: Text(
                '说:',
                style: TextStyle(fontSize: 12),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                '国庆放假10天',
                style: TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        title: Text('地圈动态'),
      ),
    ),
  ));
  panel.add(SliverFixedExtentList(
    itemExtent: 80, // I'm forcing item heights
    delegate: SliverChildBuilderDelegate(
      _pipelineContentItemBuilder,
      childCount: 50,
    ),
  ));
}

void _buildPlatTab(List<Widget> panel) {
//  panel.add(
//    SliverToBoxAdapter(
//      child: Center(
//        child: Padding(
//          padding: EdgeInsets.only(bottom: 10),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            mainAxisSize: MainAxisSize.max,
//            children: <Widget>[
//              Padding(
//                padding: EdgeInsets.only(left: 10, right: 10),
//                child: GestureDetector(
//                  onTap: () {},
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Text('12'),
//                      Text('所有'),
//                    ],
//                  ),
//                ),
//              ),
//              VerticalDivider(
//                width: 1,
//                color: Colors.red,
//              ),
//              Padding(
//                padding: EdgeInsets.only(left: 10, right: 10),
//                child: GestureDetector(
//                  onTap: () {},
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Text('382'),
//                      Text('公共'),
//                    ],
//                  ),
//                ),
//              ),
//              VerticalDivider(
//                color: Colors.red,
//              ),
//              Padding(
//                padding: EdgeInsets.only(left: 10, right: 10),
//                child: GestureDetector(
//                  onTap: () {},
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Text('210'),
//                      Text('地圈'),
//                    ],
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//    ),
//  );

  panel.add(SliverToBoxAdapter(
    child: Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '动态',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 20,
            height: 20,
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.edit,
                size: 20,
              ),
              onPressed: () {
                print('object');
              },
            ),
          ),
        ],
      ),
    ),
  ));
  var item = SliverToBoxAdapter(
    child: Card(
      shape: Border(),
      elevation: 0,
      margin: EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.only(
          top: 5,
          left: 10,
          right: 10,
          bottom: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5, right: 5),
              child: ClipOval(
                child: Image(
                  image: NetworkImage(
                      'https://sjbz-fd.zol-img.com.cn/t_s208x312c5/g5/M00/01/06/ChMkJ1w3FnmIE9dUAADdYQl3C5IAAuTxAKv7x8AAN15869.jpg'),
                  height: 35,
                  width: 35,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('波涛旅行Hotel'),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {},
                          icon: Icon(
                            Icons.art_track,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    //内容区
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '不走形式，研发中心月度实现目标，由上级主管给出几个目标维度，被考核人自已填本月实际目标，并由主管审核下级目标，最终呈给人事部。工作态度：考核项固定',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        return Row(
                          //多媒体区
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Image(
                                image: NetworkImage(
                                    'http://www.zdyrs.com/uploadfile/2015/1205/20151205012936705.jpg'),
                                width: (constraint.biggest.width / 2) - 2,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Image(
                                image: NetworkImage(
                                    'http://img1.huaihai.tv/material/news/img/2016/10/621c4edb69dcbdf755b0c46e1b09fa45.jpg'),
                                width: (constraint.biggest.width / 2) - 2,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Row(
                    //内容坠
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '1小时前 ¥0.24元',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      IconButton(
                        icon: Icon(Icons.linear_scale),
                        iconSize: 14,
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: Color(0xFFF5F5F5),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //相关操作区
                      children: <Widget>[
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          alignment: WrapAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.child_care,
                              size: 16,
                            ),
                            Text('cj'),
                            Text('tom'),
                            Text('nick'),
                          ],
                        ),
                        Divider(
                          height: 1,
                        ),
                        Row(
                          //评论区
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 5),
                              child: Row(
                                children: <Widget>[
                                  Text('tom'),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 2,
                                    ),
                                    child: Text(':'),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '为了平台稳定性，从2019.8.27开始，今后所有生产上的操作(前后台发包，重启应用等),无论多小的事情，请征得老大的同意方可操作，望各位理解。',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          //评论区
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 5),
                              child: Row(
                                children: <Widget>[
                                  Text('dem'),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 2,
                                    ),
                                    child: Text(':'),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '香港线路有问题，正在处理，暂时不能使用，要用网可以切换到10.20.X.0开头的本地网',
                                style: TextStyle(
                                  fontSize: 12,
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
    ),
  );
  panel.add(item);
  panel.add(item);
  panel.add(item);
}

Widget _pipelineContentItemBuilder(BuildContext context, int index) {
  return Container(
    decoration: new BoxDecoration(
      color: Colors.white,
    ),
    child: Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print('xxxxxx');
          },
          child: ListTile(
            leading: IconButton(
              icon: Image(
                image: NetworkImage(
                    'http://pic-bucket.ws.126.net/photo/0003/2019-08-24/ENB27CUI00AJ0003NOS.jpg'),
              ),
            ),
            trailing: Padding(
              padding: EdgeInsets.only(
                top: 0,
                bottom: 20,
              ),
              child: Text('23:55'),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '[39/120]',
                  style: TextStyle(fontSize: 12),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 1),
                  child: Text(
                    '天空的鸟',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 1, right: 5),
                  child: Text(
                    '说:',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    '什么时候回来',
                    style: TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            title: Text('bill li $index'),
          ),
        ),
        Divider(
          height: 1,
          indent: 80,
        ),
      ],
    ),
  );
}
