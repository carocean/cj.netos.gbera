import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';

class Accounts extends StatelessWidget {
  PageContext context;

  Accounts({this.context});

  @override
  Widget build(BuildContext context) {
    var card_current = Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: 5,
              left: 10,
              right: 10,
            ),
            child: Text.rich(
              TextSpan(
                text: '当前应用:',
                children: [
                  TextSpan(
                    text: 'gbera',
                    style: TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                  TextSpan(text: '下的账号'),
                ],
              ),
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              bottom: 15,
              top: 15,
              left: 10,
              right: 10,
            ),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    this.context.forward('/users/accounts/viewer');
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 15,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                right: 5,
                              ),
                              child: Icon(
                                FontAwesomeIcons.font,
                                size: 30,
                                color: Colors.grey[600],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    'cj',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 5,
                                      ),
                                      child: Text(
                                        '租户: netos',
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.red[400],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  indent: 35,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    this.context.forward('/users/accounts/viewer');
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                right: 5,
                              ),
                              child: Icon(
                                Icons.phone_android,
                                size: 30,
                                color: Colors.grey[600],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    '18023457655',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 5,
                                      ),
                                      child: Text(
                                        '租户: netos',
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  indent: 35,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              right: 5,
                            ),
                            child: Icon(
                              Icons.mail,
                              size: 30,
                              color: Colors.grey[600],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 5,
                                ),
                                child: Text(
                                  'carocean.jofers@outlook.com',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: Text(
                                      '租户: netos',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    this.context.forward('/users/accounts/addAccount');
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                right: 5,
                              ),
                              child: Icon(
                                Icons.add,
                                size: 30,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              '添加新账号',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    var card_others = Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: 5,
              left: 10,
              right: 10,
            ),
            child: Text(
              '其它应用账号',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              bottom: 15,
              top: 15,
              left: 10,
              right: 10,
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 15,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              right: 5,
                            ),
                            child: Icon(
                              FontAwesomeIcons.font,
                              size: 30,
                              color: Colors.grey[600],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 5,
                                ),
                                child: Text(
                                  'tom',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: Text(
                                      '应用: 古树轩湘菜馆',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: Text(
                                      '租户: netos',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  indent: 35,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              right: 5,
                            ),
                            child: Icon(
                              Icons.phone_android,
                              size: 30,
                              color: Colors.grey[600],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 5,
                                ),
                                child: Text(
                                  '13902024838',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: Text(
                                      '应用: news',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: Text(
                                      '租户: cctv',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    var bb = this.context.parameters['back_button'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.context.page?.title,
        ),
        titleSpacing: 0,
        elevation: 0,
        automaticallyImplyLeading: bb == null ? true : false,
        leading: getLeading(bb),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          card_current,
          card_others,
        ],
      ),
    );
  }

  getLeading(bb) {
    if (bb == null) return null;
    return IconButton(
      onPressed: () {
        this.context.goBack();
      },
      icon: Icon(
        Icons.clear,
        size: 18,
      ),
    );
  }
}
