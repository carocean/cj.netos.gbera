import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbera/generated/i18n.dart';
import 'package:gbera/netos/common.dart';

List<Style> buildGreyStyles(BuildContext context) {
  return <Style>[
    Style(
      url: '/geosphere/mydq.text',
      desc: '我的地圈中间的主标题',
      get: () {
        return TextStyle(
          fontSize: 14,
        );
      },),
    Style(
        url: '/geosphere/title.text',
        desc: '金证喷泉等标题',
        get: () {
          return TextStyle(
            fontSize: 12,
          );
        },),
    Style(
      url: '/geosphere/title-red.text',
      desc: '',
      get: () {
        return TextStyle(
          fontSize: 12,
          color: Colors.red,
        );
      },
    ),
    Style(
      url: '/geosphere/title-grey.text',
      desc: '',
      get: () {
        return TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        );
      },
    ),
    Style(
      url: '/geosphere/listItemMsgTitle.text',
      desc: '',
      get: () {
        return TextStyle(
          color: Colors.grey[700],
          fontWeight: FontWeight.w500,
          fontSize: 15,
        );
      },
    ),
    Style(
      url: '/login2/appTitle.text',
      desc: '',
      get: () {
        return TextStyle(
          fontSize: 16,
          color: Colors.grey[700],
        );
      },
    ),
  ];
}
