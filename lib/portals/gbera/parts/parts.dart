import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///简单的卡片头：图 标题              折叠按钮
class _CardHeaderBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: 30),
      child: Stack(
        alignment: Alignment.centerLeft,
        overflow: Overflow.visible,
        fit: StackFit.loose,
        children: <Widget>[
          Positioned(
            top: 1,
            left: 0,
            child: Icon(
              Icons.business_center,
              size: 25,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text('卖场'),
          ),
          Positioned(
            top: 2,
            right: 0,
            child: SizedBox(
              width: 25,
              height: 25,
              child: IconButton(
                padding: EdgeInsets.all(0),
                iconSize: 15,
                onPressed: () {
                  print('pressed');
                },
                icon: Icon(
                  Icons.keyboard_arrow_down,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///卖场卡片
class CardStore extends StatefulWidget {
  Widget _content;

  CardStore({Widget content}) {
    _content = content;
  }

  @override
  State createState() {
    return _CardStoreState();
  }
}

class _CardStoreState extends State<CardStore> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Column(
          children: <Widget>[
            _CardHeaderBase(),
            Container(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 10,
                right: 10,
              ),
              child: widget._content,
            ),
          ],
        ),
      ),
    );
  }
}
