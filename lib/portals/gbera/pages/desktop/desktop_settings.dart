import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class DesktopSettings extends StatelessWidget {
  PageContext context;

  DesktopSettings({this.context});

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
          //钱包
          Container(
            padding: EdgeInsets.only(
              top: 15,
              bottom: 15,
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                this.context.forward('/desktop/lets/settings');
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
                    child: Icon(
                      this.context.findPage('/desktop/lets/settings')?.icon,
                      size: 30,
                      color:
                      this.context.style('/profile/list/item-icon.color'),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '桌面栏目',
                          style: this
                              .context
                              .style('/profile/list/item-title.text'),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
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
          ]
          ,
        )
        ,
      )
      ,
    );
  }
}
