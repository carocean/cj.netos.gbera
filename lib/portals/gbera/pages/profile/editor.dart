import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class ProfileEditor extends StatefulWidget {
  PageContext context;

  ProfileEditor({this.context});

  @override
  _ProfileEditorState createState() => _ProfileEditorState();
}

class _ProfileEditorState extends State<ProfileEditor> {
  @override
  Widget build(BuildContext context) {
    var bb = widget.context.parameters['back_button'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.context.page?.title,
        ),
        titleSpacing: 0,
        elevation: 0,
        automaticallyImplyLeading: bb == null ? true : false,
        leading: getLeading(bb),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          shrinkWrap: true,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                bottom: 15,
                top: 15,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '头像',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          right: 5,
                        ),
                        child: Image.network(
                          'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1197039898,3476709019&fm=179&app=42&f=JPEG?w=121&h=140',
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[500],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: 15,
                top: 15,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '昵称',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          right: 5,
                        ),
                        child: Text(
                          'carocean',
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[500],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: 15,
                top: 15,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '用户号',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          right: 5,
                        ),
                        child: Text(
                          '00020383838838338',
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[500],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: 15,
                top: 15,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '是否实名',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          right: 5,
                        ),
                        child: Text(
                          '已认证',
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[500],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: 15,
                top: 15,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '性别',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          right: 5,
                        ),
                        child: Text(
                          '男',
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[500],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: 15,
                top: 15,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '更多',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          right: 5,
                        ),
                        child: Text(
                          '电话/地址/等等',
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[500],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getLeading(bb) {
    if (bb == null) return null;
    return IconButton(
      onPressed: () {
        widget.context.goBack();
      },
      icon: Icon(
        Icons.clear,
        size: 18,
      ),
    );
  }
}
