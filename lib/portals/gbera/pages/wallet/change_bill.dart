import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class ChangeBill extends StatelessWidget {
  PageContext context;

  ChangeBill({this.context});

  @override
  Widget build(BuildContext context) {
    Widget _itemBuilder(BuildContext context, int index) {
      return Container(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
          top: 10,
          bottom: 10,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (){
            this.context.forward('/wallet/change/bill/details');
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: Text(
                      '充值',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    '10月19日 02:57',
                    style: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              Text('+29.50'),
            ],
          ),
        ),
      );
    }

    Widget _separatorBuilder(BuildContext context, int index) {
      return Divider(
        height: 1,
        indent: 10,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.context.page?.title,
        ),
        titleSpacing: 0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            this.context.backward();
          },
          icon: Icon(
            Icons.clear,
            size: 18,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.separated(
          itemBuilder: _itemBuilder,
          itemCount: 50,
          separatorBuilder: _separatorBuilder,
        ),
      ),
    );
  }
}
