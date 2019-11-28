import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';

class AddAccount extends StatelessWidget {
  PageContext context;

  AddAccount({this.context});

  @override
  Widget build(BuildContext context) {
    var card_face = Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
            child: Image.network(
              'http://www.xcg.roboo.com/upload/2013-07-10/1373446849106-21510.jpg',
              fit: BoxFit.cover,
              width: 70,
              height: 70,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text('大时代'),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: Text('gbera'),
          ),
        ],
      ),
    );
    var item_account_name = Container(
      constraints: BoxConstraints.tightForFinite(
        width: double.maxFinite,
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 10,
      ),
      color: Colors.white,
      child: Container(
        constraints: BoxConstraints.tightForFinite(
          width: double.maxFinite,
        ),
        child: TextField(
          keyboardType: TextInputType.text,
          autofocus: true,
          decoration: InputDecoration(
            icon: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Icon(
                Icons.phone,
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 40,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              bottom: 15,
                            ),
                            child: Text(
                              '选择账号类型',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          ListView.separated(
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 20,
                                  bottom: 20,
                                ),
                                color: Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 10,
                                      ),
                                      child: Icon(
                                        FontAwesomeIcons.font,
                                        size: 18,
                                      ),
                                    ),
                                    Text('文本账号'),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                height: 1,
                              );
                            },
                            shrinkWrap: true,
                            itemCount: 3,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            hintText: '当前是手机账号，左边按钮选择账号类型',
          ),
        ),
      ),
    );

    var item_new_pwd = Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 10,
      ),
      color: Colors.white,
      child: Container(
        constraints: BoxConstraints.tightForFinite(
          width: double.maxFinite,
        ),
        child: TextField(
          keyboardType: TextInputType.text,
          autofocus: true,
          obscureText: true,
          decoration: InputDecoration(
            labelText: '密码',
            hintText: '输入密码',
          ),
        ),
      ),
    );
    var item_ok = Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 10,
      ),
      child: Text(
        '确定',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.blueGrey,
        ),
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
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            card_face,
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    this.context.forward('/users/accounts/editPassword');
                  },
                  child: item_account_name,
                ),
                Divider(
                  height: 1,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    this.context.forward('/users/accounts/login');
                  },
                  child: item_new_pwd,
                ),
              ],
            ),
            item_ok,
          ],
        ),
      ),
    );
  }

  getLeading(bb) {
    if (bb == null) return null;
    return IconButton(
      onPressed: () {
        this.context.backward();
      },
      icon: Icon(
        Icons.clear,
        size: 18,
      ),
    );
  }
}
