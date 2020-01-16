import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbera/portals/gbera/pages/viewers/video_view.dart';
import 'package:gbera/portals/gbera/store/entities.dart';

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
  List<Media> medias;
  Function(Media media) onMediaTap;
  BoxFit boxFit;
  double height;

  PageSelector({this.medias, this.onMediaTap, this.boxFit, this.height}) {
    if (medias == null) {
      this.medias = [];
    }
    if (boxFit == null) {
      this.boxFit = BoxFit.fitHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    var _controller = DefaultTabController.of(context);

    return Stack(
      children: <Widget>[
        SizedBox(
          height: height ?? 150,
          child: TabBarView(
            controller: _controller,
            children: this.medias.map((media) {
              var mediaRender;
              var src = media?.src;
              switch (media.type) {
                case 'image':
                  mediaRender = src.startsWith('/')
                      ? Image.file(
                    File(src),
                    fit: this.boxFit ?? BoxFit.fitHeight,
                  )
                      : Image.network(
                    src,
                    fit: this.boxFit ?? BoxFit.fitHeight,
                  );
                  break;
                case 'video':
                  mediaRender = VideoView(
                    src: File(src),
                  );
                  break;
                case 'audio':
                  break;
                default:
                  print('unknown media type');
                  break;
              }
              if (mediaRender == null) {
                return Container(width: 0, height: 0,);
              }

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (onMediaTap != null) {
                    onMediaTap(media);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                    child: mediaRender,
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
