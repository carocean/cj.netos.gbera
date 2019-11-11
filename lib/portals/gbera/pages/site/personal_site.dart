///个人站点
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';

class PersonalSite extends StatefulWidget {
  PageContext context;

  PersonalSite({this.context});

  @override
  _PersonalSiteState createState() => _PersonalSiteState();
}

class _PersonalSiteState extends State<PersonalSite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            widget.context.backward();
          },
          icon: Icon(
            Icons.clear,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              widget.context.forward('/site/personal/profile');
            },
            icon: Icon(
              FontAwesomeIcons.ellipsisH,
              size: 14,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: _Header(
              imgSrc:
                  'http://b-ssl.duitang.com/uploads/item/201708/24/20170824145045_ujMe5.jpeg',
              avatar: 'A-Winnie地空雷',
              uid: '008383827727366',
              address: '广东 广州',
              signText: '好的皮千遍一律，有趣的灵魂万里挑一',
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: _OperatorCard(
              operators: [
                _Operator(
                  text: '发私信',
                  iconData: Icons.chat,
                ),
                _Operator(
                  text: '拍照',
                  iconData: Icons.camera_enhance,
                ),
                _Operator(
                  text: '发图片',
                  iconData: Icons.picture_in_picture,
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
            child: _Body(
              channelItems: [
                _ChannelItemInfo(
                  title: '公共',
                  images: [
                    'http://b-ssl.duitang.com/uploads/item/201805/24/20180524220406_hllbq.jpg',
                    'http://b-ssl.duitang.com/uploads/item/201510/10/20151010054541_3YmaC.jpeg',
                    'http://b-ssl.duitang.com/uploads/item/201610/10/20161010221028_3Xzwi.jpeg',
                    'http://cdn.duitang.com/uploads/item/201606/14/20160614002619_WfLXj.jpeg',
                  ],
                ),
                _ChannelItemInfo(
                  title: '熟人圈',
                  images: [
                    'http://b-ssl.duitang.com/uploads/item/201805/24/20180524220406_hllbq.jpg',
                    'http://b-ssl.duitang.com/uploads/item/201510/10/20151010054541_3YmaC.jpeg',
                    'http://b-ssl.duitang.com/uploads/item/201610/10/20161010221028_3Xzwi.jpeg',
                    'http://cdn.duitang.com/uploads/item/201606/14/20160614002619_WfLXj.jpeg',
                  ],
                ),
                _ChannelItemInfo(
                  title: '地推',
                  images: [
                    'http://b-ssl.duitang.com/uploads/item/201805/24/20180524220406_hllbq.jpg',
                    'http://b-ssl.duitang.com/uploads/item/201510/10/20151010054541_3YmaC.jpeg',
                    'http://b-ssl.duitang.com/uploads/item/201610/10/20161010221028_3Xzwi.jpeg',
                    'http://cdn.duitang.com/uploads/item/201606/14/20160614002619_WfLXj.jpeg',
                  ],
                ),
                _ChannelItemInfo(
                  title: '中山大学社区',
                  images: [
                    'http://b-ssl.duitang.com/uploads/item/201805/24/20180524220406_hllbq.jpg',
                    'http://b-ssl.duitang.com/uploads/item/201510/10/20151010054541_3YmaC.jpeg',
                    'http://b-ssl.duitang.com/uploads/item/201610/10/20161010221028_3Xzwi.jpeg',
                    'http://cdn.duitang.com/uploads/item/201606/14/20160614002619_WfLXj.jpeg',
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Operator {
  IconData iconData;
  String text;

  _Operator({this.iconData, this.text});
}

class _OperatorCard extends StatefulWidget {
  List<_Operator> operators;

  _OperatorCard({this.operators});

  @override
  __OperatorCardState createState() => __OperatorCardState();
}

class __OperatorCardState extends State<_OperatorCard> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(),
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.operators.map((value) {
          var orignal = Container(
            padding: EdgeInsets.only(
              bottom: 15,
              top: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  child: Icon(
                    value.iconData,
                    size: 14,
                    color: Colors.blueGrey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  child: Text(
                    value.text,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
          if (index < widget.operators.length - 1) {
            index++;
            return Column(
              children: <Widget>[
                orignal,
                Divider(
                  height: 1,
                ),
              ],
            );
          }
          index = 0;
          return orignal;
        }).toList(),
      ),
    );
  }
}

class _Header extends StatefulWidget {
  String imgSrc;
  String avatar;
  String uid;
  String address;
  String signText;

  _Header({this.imgSrc, this.uid, this.address, this.signText, this.avatar});

  @override
  __HeaderState createState() => __HeaderState();
}

class __HeaderState extends State<_Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  right: 20,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                  child: Image.network(
                    widget.imgSrc,
                    width: 60,
                    height: 60,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Text(
                        widget.avatar,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Text.rich(
                        TextSpan(
                          text: '用户号: ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: widget.uid,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Text.rich(
                        TextSpan(
                          text: '地区: ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(text: widget.address),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              bottom: 12,
            ),
            child: Divider(
              height: 1,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: 5,
            ),
            child: Text.rich(
              TextSpan(
                text: '个性签名:  ',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                children: [
                  TextSpan(
                    text: widget.signText == null ? '' : "${widget.signText}",
                  ),
                ],
              ),
              maxLines: 2,
              textDirection: TextDirection.rtl,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChannelItemInfo {
  String title;
  List images;

  _ChannelItemInfo({this.title, this.images});
}

class _Body extends StatefulWidget {
  List<_ChannelItemInfo> channelItems;

  _Body({this.channelItems});

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: widget.channelItems.map((value) {
          return Column(
            children: <Widget>[
              _ChannelItem(
                title: value.title,
                images: value.images,
              ),
              Divider(
                height: 1,
                indent: 20,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _ChannelItem extends StatefulWidget {
  List images = [];
  String title;

  _ChannelItem({this.title = '', this.images});

  @override
  __ChannelItemState createState() => __ChannelItemState();
}

class __ChannelItemState extends State<_ChannelItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 20,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: 10,
            ),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Wrap(
                    textDirection: TextDirection.rtl,
                    children: widget.images.map((value) {
                      return Padding(
                        padding: EdgeInsets.all(4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
                          child: Image.network(
                            value,
                            width: 40,
                            height: 40,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
