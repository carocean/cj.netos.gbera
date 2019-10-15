///系统出错页
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorPage404 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '404啦!',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                ModalRoute.of(context).settings.name,
                style: TextStyle(
                  color: Colors.red,
                ),
                maxLines: 4,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
