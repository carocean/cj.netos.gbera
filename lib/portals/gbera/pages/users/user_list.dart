import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class UserAndAccountList extends StatelessWidget {
  PageContext context;

  UserAndAccountList({this.context});

  @override
  Widget build(BuildContext context) {
    var card_1 = Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 15,
              bottom: 15,
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                this.context.forward('/users/viewer');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                    child: Image.network(
                      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1571635906558&di=6caea35e3b313143fb2879288dbc6084&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201803%2F15%2F20180315202601_wnwme.jpg',
                      width: 35,
                      height: 35,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 5,
                              ),
                              child: Text(
                                '用户号:0029938383838383',
                                style: this
                                    .context
                                    .style('/profile/list/item-title.text'),
                              ),
                            ),
                            Text(
                              '登录账号:cj',
                            ),
                          ],
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        Icon(
                          Icons.check,
                          size: 20,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    var card_add = Container(
      padding: EdgeInsets.only(left: 10,right: 10,top: 10,),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.add,
                size: 25,
                color: Colors.grey[500],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  '添加您的其它用户号',
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
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.context.page?.title,
        ),
        titleSpacing: 0,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                bottom: 10,
              ),
              child: card_1,
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 10,
              ),
              child: card_add,
            ),
          ],
        ),
      ),
    );
  }
}
