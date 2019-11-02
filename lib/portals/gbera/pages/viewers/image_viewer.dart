import 'dart:math';

///商户站点
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class ImageViewer extends StatefulWidget {
  PageContext context;
  String imgSrc;
  String text;

  ImageViewer({this.context, this.text, this.imgSrc}) {
    this.imgSrc = context.parameters['imgSrc'];
    this.text = context.parameters['text'];
    if (text == null) {
      text = '';
    }
  }

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  var images = [
    'http://pic1.win4000.com/mobile/2018-01-17/5a5eea7923906.jpg',
    'http://pic1.win4000.com/mobile/e/53b6797378bb6.jpg',
    'http://pic1.win4000.com/mobile/3/547d8348c89bf.jpg',
    'http://pic1.win4000.com/mobile/b/557fce7f94b9d.jpg'
  ];
  static var select = 0;

  @override
  Widget build(BuildContext context) {
    changeImage(int isUp) {
      if (isUp > 0) {
        select += 1;
      } else {
        select -= 1;
      }
      if (select < 0) {
        select = images.length - 1;
      }
      if (select > images.length - 1) {
        select = 0;
      }
      widget.context.forward('/images/viewer', arguments: {
        'imgSrc': images[select],
        'text': '这是图-${select + 1}',
      });
    }

    int isDemandChangeImage = 0; //0是未改变图片，1是向上，-1是向下
    Offset start;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          constraints: BoxConstraints.expand(),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onVerticalDragUpdate: (DragUpdateDetails details) {
                        if (isDemandChangeImage != 0) {
                          return;
                        }
                        var distance = start.dy - details.localPosition.dy;
                        distance = distance.abs();
                        if (distance > 50) {
                          isDemandChangeImage =
                              details.localPosition.dy - start.dy < 0 ? 1 : -1;
                          changeImage(isDemandChangeImage);
                        }
                      },
                      onPanDown: (DragDownDetails details) {
                        start = details.localPosition;
                        isDemandChangeImage = 0;
                      },
                      child: Image.network(
                        widget.imgSrc,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  CustomScrollView(
                    shrinkWrap: true,
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: 10,
                          ),
                          child: Text.rich(
                            TextSpan(
                              text: widget.text,
                            ),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    widget.context.forward('/netflow/channel',
                        arguments: {'channel-name': '公共'});
                  },
                  color: Colors.red,
                  iconSize: 20,
                  icon: Icon(
                    Icons.clear,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
