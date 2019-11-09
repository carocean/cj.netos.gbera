import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class CardItem extends StatefulWidget {
  String title;
  Widget subtitle;
  Color titleColor;
  IconData tipsIconData;
  String tipsText;
  Widget tail;
  Widget leading;
  double paddingTop;
  double paddingBottom;
  Function() onItemTap;

  CardItem({
    this.title,
    this.subtitle,
    this.titleColor,
    this.tipsText = '',
    this.tipsIconData,
    this.tail,
    this.leading,
    this.paddingBottom,
    this.paddingTop,
    this.onItemTap,
  }) {
    if (tail == null) {
      this.tail = Icon(
        Icons.arrow_forward_ios,
        size: 18,
        color: Colors.grey[400],
      );
    }
  }

  @override
  State createState() => CardItemState();
}

class CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onItemTap,
      child: Container(
        padding: EdgeInsets.only(
          top: widget.paddingTop == null ? 15 : widget.paddingTop,
          bottom: widget.paddingBottom == null ? 15 : widget.paddingBottom,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            widget.leading == null
                ? Container(
                    height: 0,
                    width: 0,
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                    child: widget.leading,
                  ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: widget.subtitle == null
                    ? Text(
                        widget.title,
                        style: TextStyle(
                          color: widget.titleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 3,
                            ),
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                color: widget.titleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: widget.subtitle,
                          ),
                        ],
                      ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: StringUtil.isEmpty(widget.tipsText)
                        ? Container(
                            width: 0,
                            height: 0,
                          )
                        : Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              widget.tipsText,
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                  ),
                  widget.tipsIconData == null
                      ? Container(
                          width: 0,
                          height: 0,
                        )
                      : Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(
                            widget.tipsIconData,
                            size: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: widget.tail,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
