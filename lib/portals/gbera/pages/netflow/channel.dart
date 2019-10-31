import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/common/util.dart';

class Channel extends StatefulWidget {
  PageContext context;

  Channel({this.context});

  @override
  _ChannelState createState() => _ChannelState();
}

class _ChannelState extends State<Channel> {
  @override
  Widget build(BuildContext context) {
    var panel = <Widget>[];
    _buildPlatTab(panel);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.context.parameters['channel-name'],
        ),
        titleSpacing: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onLongPress: () {
              print('onLongPress');
            },
            child: IconButton(
              icon: Icon(
                Icons.camera_enhance,
                size: 20,
              ),
              onPressed: () {
                print('onPressed');
              },
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            widget.context.backward();
          },
          icon: Icon(
            Icons.clear,
          ),
        ),
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: panel,
      ),
    );
  }
}

void _buildPlatTab(List<Widget> panel) {
  var header = SliverToBoxAdapter(
    child: Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(
        top: 20,
        left: 15,
        bottom: 10,
        right: 15,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(
                right: 5,
              ),
              child: Icon(
                Icons.settings_input_composite,
                size: 20,
                color: Colors.grey[600],
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Text(
              '动态',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ),
  );
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
                      Text(
                        '波涛旅行Hotel',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {},
                          icon: Icon(
                            Icons.art_track,
                            size: 20,
                            color: Colors.grey[700],
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
                            Text(
                              'cj',
                              style: TextStyle(
                                color: Colors.blueGrey,
                              ),
                            ),
                            Text(
                              'tom',
                              style: TextStyle(
                                color: Colors.blueGrey,
                              ),
                            ),
                            Text(
                              'nick',
                              style: TextStyle(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 5,
                            top: 5,
                          ),
                          child: Divider(
                            height: 1,
                          ),
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
                                  Text(
                                    'tom',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 2,
                                    ),
                                    child: Text(':'),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '为了平台稳定性，从2019.8.27开始，今后所有生产上的操作(前后台发包，重启应用等),无论多小的事情，请征得老大的同意方可操作，望各位理解。',
                                style: TextStyle(
                                  fontSize: 14,
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
                                  Text(
                                    'dem',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                    ),
                                  ),
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
                                  fontSize: 14,
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
  panel.add(header);
  panel.add(item);
  panel.add(item);
  panel.add(item);
  panel.add(item);
  panel.add(item);
}
