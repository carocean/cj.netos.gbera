import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    var _uid = '00020383838838338';
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
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                widget.context.forward('/profile/editor/face');
              },
              child: Container(
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
            ),
            Divider(
              height: 1,
            ),
            Builder(
              builder: (context) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    var data = ClipboardData(text: _uid);
                    Clipboard.setData(data);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('复制成功'),
                    ));
                  },
                  child: Container(
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
                                _uid,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                            Icon(
                              Icons.content_copy,
                              size: 16,
                              color: Colors.grey[500],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Divider(
              height: 1,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: false,
                    useRootNavigator: false,
                    builder: (context) {
                      return widget.context.part(
                          '/profile/editor/username?back_button=true', context);
                    });
              },
              child: Container(
                padding: EdgeInsets.only(
                  bottom: 15,
                  top: 15,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '姓名',
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
                            '赵向彬',
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
                    '实名认证',
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
                        Icons.check,
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
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: false,
                    useRootNavigator: false,
                    builder: (context) {
                      return widget.context.part(
                          '/profile/editor/sex?back_button=true', context);
                    });
              },
              child: Container(
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
            ),
            Divider(
              height: 1,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                widget.context.forward(
                    '/profile/editor/more');
//                showModalBottomSheet(
//                    context: context,
//                    isScrollControlled: true,
//                    builder: (context) {
//                      return widget.context.part(
//                          '/profile/editor/more?back_button=true', context);
//                    });
              },
              child: Container(
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
        widget.context.backward();
      },
      icon: Icon(
        Icons.clear,
        size: 18,
      ),
    );
  }
}
