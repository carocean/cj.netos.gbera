import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Qrcode extends StatelessWidget {
  PageContext context;

  Qrcode({this.context});

  @override
  Widget build(BuildContext context) {
    var qrcodeKey = GlobalKey();
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
        alignment: Alignment.center,
        child: RepaintBoundary(
          key: qrcodeKey,
          child: QrImage(
            ///二维码数据
            data: "1234567890",
            version: QrVersions.auto,
            size: 200.0,
            gapless: false,
            embeddedImage: NetworkImage(
                'http://pic-bucket.ws.126.net/photo/0001/2019-08-13/EMENLA1600AN0001NOS.jpg'),
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(40, 40),
            ),
          ),
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
