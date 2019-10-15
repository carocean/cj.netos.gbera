import 'dart:io';

import 'package:flutter/material.dart';

getNetflowHeader({int selectTabIndex, void Function(int tabindex) onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      GestureDetector(
        onTap: () {
          onTap(0);
        },
        child: Container(
          padding: EdgeInsets.only(
            left: 25,
            right: 25,
            top: 3,
            bottom: Platform.isAndroid ? 5 : 3,
          ),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(width: 0, color: Colors.blue),
              left: BorderSide(width: 1, color: Colors.blue),
              top: BorderSide(width: 1, color: Colors.blue),
              bottom: BorderSide(width: 1, color: Colors.blue),
            ),
            color: selectTabIndex == 0 ? Colors.blue : Colors.white,
          ),
//        color: selectTabIndex == 0 ? Colors.blue : Colors.white,
          child: Text(
            '送达',
            style: TextStyle(
              fontSize: 12,
              color: selectTabIndex == 0 ? Colors.white : Colors.blue,
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          onTap(1);
        },
        child: Container(
          padding: EdgeInsets.only(
            left: 25,
            right: 25,
            top: 3,
            bottom: Platform.isAndroid ? 5 : 3,
          ),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(width: 1, color: Colors.blue),
              left: BorderSide(width: 0, color: Colors.blue),
              top: BorderSide(width: 1, color: Colors.blue),
              bottom: BorderSide(width: 1, color: Colors.blue),
            ),
            color: selectTabIndex == 1 ? Colors.blue : Colors.white,
          ),
//        color: selectTabIndex == 1 ? Colors.blue : Colors.white,
          child: Text(
            '追链',
            style: TextStyle(
              fontSize: 12,
              color: selectTabIndex == 1 ? Colors.white : Colors.blue,
            ),
          ),
        ),
      ),
    ],
  );
}
