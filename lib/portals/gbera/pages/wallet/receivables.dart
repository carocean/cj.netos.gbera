import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gbera/netos/common.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Receivables extends StatelessWidget {
  PageContext context;

  Receivables({this.context});

  @override
  Widget build(BuildContext context) {
    var qrcodeKey = GlobalKey();
    var card_head = Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20,
      ),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: Icon(
                  Icons.monetization_on,
                  size: 14,
                  color: Colors.grey[500],
                ),
              ),
              Text('二维码收款'),
            ],
          ),
        ],
      ),
    );
    var card_body = Container(
      constraints: BoxConstraints.expand(),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 20,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                bottom: 10,
                top: 20,
              ),
              child: Text(
                'gbera扫一扫，向我付钱',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 10,
              ),
              child: RepaintBoundary(
                key: qrcodeKey,
                child: QrImage(
                  ///二维码数据
                  data: "1234567890",
                  version: QrVersions.auto,
                  size: 200.0,
                  gapless: false,
                  embeddedImage:
                      AssetImage('lib/portals/gbera/images/yuanbao.png'),
                  embeddedImageStyle: QrEmbeddedImageStyle(
                    size: Size(40, 40),
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 20,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      '设置金额',
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Container(
                    height: 16,
                    padding: EdgeInsets.only(
                      top: 2,
                      bottom: 2,
                    ),
                    child: VerticalDivider(
                      color: Colors.grey[400],
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      RenderRepaintBoundary boundary =
                          qrcodeKey.currentContext.findRenderObject();
                      var image = await boundary.toImage();
                      var byteData =
                          await image.toByteData(format: ImageByteFormat.png);
                      var pngBytes = byteData.buffer.asUint8List();
                      ///本来应该保存到相册，但相册是手机的共享目录，得找第三方插件才能实现,下面先保存到应用目录，用户是看不到的。
                      Directory dir = await getApplicationDocumentsDirectory();
                      File('${dir.path}/qr_code.png').writeAsBytes(pngBytes);
                    },
                    child: Text(
                      '保存收款码',
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 15,
                bottom: 10,
                left: 20,
                right: 20,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          right: 10,
                        ),
                        child: Icon(
                          Icons.assignment,
                          size: 14,
                          color: Colors.grey[400],
                        ),
                      ),
                      Text('收款记录'),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ],
        ),
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
        child: Column(
          children: <Widget>[
            card_head,
            Expanded(
              child: card_body,
            ),
          ],
        ),
      ),
    );
  }
}
