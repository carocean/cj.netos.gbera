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
              color: Colors.grey[600],
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
                  color: Colors.grey[600],
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

//微博等内容区的多图展示区
class PageSelector extends StatelessWidget {
  List<String> images;
  Function(String image) onImageTap;
  BoxFit boxFit;
  double height;
  PageSelector({this.images,this.onImageTap,this.boxFit,this.height}) {
    if (images == null) {
      this.images = [];
    }
    if(boxFit==null) {
      this.boxFit=BoxFit.fitHeight;
    }
  }

  @override
  Widget build(BuildContext context) {

    var _controller = DefaultTabController.of(context);

    return Stack(
      children: <Widget>[
        SizedBox(
          height: height??150,
          child: TabBarView(
            controller: _controller,
            children: this.images.map((img) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (onImageTap != null) {
                    onImageTap(img);
                  }
                },
                child: Container(
                  child: Image.network(
                    img,
                    fit: this.boxFit??BoxFit.fitHeight,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: TabPageSelector(
            controller: _controller,
            color: Colors.white,
            selectedColor: Colors.green,
            indicatorSize: 5,
          ),
        ),
      ],
    );
  }
}
