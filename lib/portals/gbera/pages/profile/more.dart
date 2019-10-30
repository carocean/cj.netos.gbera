import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class ProfileMore extends StatefulWidget {
  PageContext context;

  ProfileMore({this.context});

  @override
  _ProfileMoreState createState() => _ProfileMoreState();
}

class _ProfileMoreState extends State<ProfileMore> {
  var _segment_phone_attrs = 'work';
  var _segment_addr_attrs = 'work';

  @override
  Widget build(BuildContext context) {
    var bb = widget.context.page.parameters['back_button'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.context.page?.title,
        ),
        titleSpacing: 0,
        elevation: 0,
        automaticallyImplyLeading: bb == null ? true : false,
        leading: getLeading(bb),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        right: 2,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          DropdownButton<String>(
                            underline: Container(),
                            value: _segment_phone_attrs == ''
                                ? null
                                : _segment_phone_attrs,
                            onChanged: (value) {
                              setState(() {
                                _segment_phone_attrs = value;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                child: Text('私人手机'),
                                value: 'private',
                              ),
                              DropdownMenuItem(
                                child: Text('工作手机'),
                                value: 'work',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '请输入',
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[300],
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        right: 2,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          DropdownButton<String>(
                            underline: Container(),
                            value: _segment_phone_attrs == ''
                                ? null
                                : _segment_phone_attrs,
                            onChanged: (value) {
                              setState(() {
                                _segment_phone_attrs = value;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                child: Text('私人手机'),
                                value: 'private',
                              ),
                              DropdownMenuItem(
                                child: Text('工作手机'),
                                value: 'work',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '请输入',
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[300],
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          right: 2,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '添加',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.add,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey[600],
            thickness: 1.1,
          ),
          Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        right: 2,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          DropdownButton<String>(
                            underline: Container(),
                            value: _segment_phone_attrs == ''
                                ? null
                                : _segment_phone_attrs,
                            onChanged: (value) {
                              setState(() {
                                _segment_phone_attrs = value;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                child: Text('办公地址'),
                                value: 'private',
                              ),
                              DropdownMenuItem(
                                child: Text('家庭住址'),
                                value: 'work',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '请输入',
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[300],
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        right: 2,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          DropdownButton<String>(
                            underline: Container(),
                            value: _segment_phone_attrs == ''
                                ? null
                                : _segment_phone_attrs,
                            onChanged: (value) {
                              setState(() {
                                _segment_phone_attrs = value;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                child: Text('办公地址'),
                                value: 'private',
                              ),
                              DropdownMenuItem(
                                child: Text('家庭住址'),
                                value: 'work',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '请输入',
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[300],
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          right: 2,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '添加',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.add,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey[600],
            thickness: 1.1,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              bottom: 10,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    right: 2,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '添加更多',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
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
