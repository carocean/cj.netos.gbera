import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gbera/netos/common.dart';

class EditPassword extends StatelessWidget {
  PageContext context;

  EditPassword({this.context});

  @override
  Widget build(BuildContext context) {
    var card_face = Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Image.network(
              'http://www.xcg.roboo.com/upload/2013-07-10/1373446849106-21510.jpg',
              fit: BoxFit.contain,
              width: 70,
              height: 70,
            ),
          ),
          Text('cj'),
        ],
      ),
    );
    var item_old_pwd = Container(
      constraints: BoxConstraints.tightForFinite(
        width: double.maxFinite,
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20,
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
            labelText: '原密码',
            hintText: '输入原密码',
          ),
        ),
      ),
    );

    var item_new_pwd = Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20,
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
            labelText: '新密码',
            hintText: '输入新密码',

          ),
        ),
      ),
    );
    var item_ok = Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20,
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
                  child: item_old_pwd,
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
