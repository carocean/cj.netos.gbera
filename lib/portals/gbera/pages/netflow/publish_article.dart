import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class PublishArticle extends StatefulWidget {
  PageContext context;

  PublishArticle({this.context});

  @override
  _PublishArticleState createState() => _PublishArticleState();
}

class _PublishArticleState extends State<PublishArticle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.context.page?.title,
        ),
        titleSpacing: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            widget.context.backward();
          },
          icon: Icon(
            Icons.clear,
          ),
        ),
      ),
      body: Container(),
    );
  }
}
