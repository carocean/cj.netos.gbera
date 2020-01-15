import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/entities.dart';
import 'package:gbera/portals/gbera/store/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class PublishArticle extends StatefulWidget {
  PageContext context;

  PublishArticle({this.context});

  @override
  _PublishArticleState createState() => _PublishArticleState();
}

class _PublishArticleState extends State<PublishArticle> {
  GlobalKey<__ImageShowerState> shower_key;

  TextEditingController _contentController;

  @override
  void initState() {
    shower_key = GlobalKey<__ImageShowerState>();
    _contentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Channel _channel = widget.context.parameters['channel'];
    var type = widget.context.parameters['type'];
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
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              UserPrincipal user = widget.context.userPrincipal;
              var content = _contentController.text;

              ///纹银价格从app的更新管理中心或消息中心获取
              double wy = 38388.38827772;
              var images = shower_key.currentState.images;
              var location = null;
              IChannelMessageService channelMessageService =
                  widget.context.site.getService('/channel/messages');
              IChannelMediaService channelMediaService =
                  widget.context.site.getService('/channel/messages/medias');
              var msgid = '${Uuid().v1()}';
              await channelMessageService.addMessage(
                ChannelMessage(
                  msgid,
                  null,
                  null,
                  null,
                  null,
                  _channel.id,
                  user.person,
                  DateTime.now().millisecondsSinceEpoch,
                  content,
                  wy,
                  location,
                  _channel.id,
                ),
              );
              for (File img in images) {
                await channelMediaService.addMedia(
                  Media(
                    '${Uuid().v1()}',
                    'image',
                    '${img.path}',
                    null,
                    msgid,
                    null,
                  ),
                );
              }
              var refreshMessages=widget.context.parameters['refreshMessages'];
              if(refreshMessages!=null) {
                await refreshMessages();
              }
              widget.context.backward();
            },
            child: Text(
              '发表',
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                  bottom: 10,
                ),
                child: TextField(
                  controller: _contentController,
                  maxLines: 10,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: '输入内容',
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _ImageShower(
                key: shower_key,
                initialImage: widget.context.parameters['image'],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 15,
                  bottom: 15,
                ),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: 15,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                right: 10,
                              ),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(
                                  Icons.add,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '购买该服务',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Flexible(
                                          fit: FlexFit.loose,
                                          child: Text(
                                            '需要至少现值¥1.00元的纹银',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        widget.context.forward('/channel/article/buywy');
                      },
                    ),
                    Divider(
                      height: 1,
                      indent: 30,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: 15,
                          top: 15,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                right: 10,
                              ),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(
                                  Icons.add,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '拍照',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Flexible(
                                          fit: FlexFit.loose,
                                          child: Text(
                                            '添加图片',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        String cnt = _contentController.text;
                        var image = await ImagePicker.pickImage(
                            source: ImageSource.camera);
                        if(image==null) {
                          return;
                        }
                        shower_key.currentState.addImage(image);
                        _contentController.text = cnt;
                        _contentController.selection =
                            TextSelection.fromPosition(
                          TextPosition(
                            affinity: TextAffinity.downstream,
                            offset: cnt?.length,
                          ),
                        );
                      },
                    ),
                    Divider(
                      height: 1,
                      indent: 30,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: 15,
                          top: 15,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                right: 10,
                              ),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(
                                  Icons.add,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '从相册添加',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Flexible(
                                          fit: FlexFit.loose,
                                          child: Text(
                                            '添加图片',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        String cnt = _contentController.text;
                        var image = await ImagePicker.pickImage(
                            source: ImageSource.gallery);
                        if(image==null) {
                          return;
                        }
                        shower_key.currentState.addImage(image);
                        _contentController.text = cnt;
                        _contentController.selection =
                            TextSelection.fromPosition(
                          TextPosition(
                            affinity: TextAffinity.downstream,
                            offset: cnt?.length,
                          ),
                        );
                      },
                    ),
                    Divider(
                      height: 1,
                      indent: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 15,
                        top: 15,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              right: 10,
                            ),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '所在位置',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Text(''),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}

class _ImageShower extends StatefulWidget {
  dynamic initialImage;

  @override
  __ImageShowerState createState() => __ImageShowerState(initialImage);

  _ImageShower({this.initialImage, Key key}) : super(key: key);
}

class __ImageShowerState extends State<_ImageShower> {
  var images = [];

  __ImageShowerState(initialImage) {
    if (initialImage != null) {
      images.add(initialImage);
    }
  }

  addImage(img) {
    setState(() {
      images.add(img);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: images.map((v) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onLongPress: () {
              setState(() {
                showDialog(
                  context: context,
                  barrierDismissible: true, //点击dialog外部 是否可以销毁
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text('确认删除？'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            '确认',
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop({'action': 'ok'});
                          },
                        ),
                        FlatButton(
                          child: Text(
                            '取消',
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop({'action': 'cancel'});
                          },
                        ),
                      ],
                    );
                  },
                ).then((result) {
                  if (result == null || result['action'] != 'ok') return;
                  setState(() {
                    File f=v as File;
                    f.deleteSync();
                    images.remove(v);
                  });
                });
              });
            },
            child: Image.file(
              v,
              width: 150,
            ),
          );
        }).toList(),
      ),
    );
  }
}
