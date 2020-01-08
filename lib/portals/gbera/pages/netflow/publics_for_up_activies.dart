import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/common/swipe_refresh.dart';
import 'package:gbera/portals/gbera/pages/netflow/channel.dart';
import 'package:gbera/portals/gbera/parts/CardItem.dart';
import 'package:gbera/portals/gbera/store/entities.dart';
import 'package:gbera/portals/gbera/store/services.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class UpPublicsForActivies extends StatefulWidget {
  PageContext context;

  UpPublicsForActivies({this.context});

  @override
  _UpPublicsForActiviesState createState() => _UpPublicsForActiviesState();
}

class _UpPublicsForActiviesState extends State<UpPublicsForActivies> {
  List<CardItem> personCardItems = [];
  int limit = 20;
  int offset = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    personCardItems.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.context.page.title),
        automaticallyImplyLeading: true,
        centerTitle: false,
        elevation: 0.0,
        titleSpacing: 0,
        actions: <Widget>[
          _getPopupMenu(),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 5,
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    right: 5,
                  ),
                  child: Icon(
                    Icons.people,
                    size: 16,
                    color: Colors.grey[500],
                  ),
                ),
                FutureBuilder(
                  future: _onLoadPersonCount(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Text('...');
                    }
                    return Text.rich(
                      TextSpan(
                        text: '${snapshot.data}人',
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                        children: [],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _onLoadPersons('up'),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey[300],
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.grey[600]),
                    ),
                  );
                }
                return PersonsView(
                  personCardItems: personCardItems,
                  onLoadPersons: _onLoadPersons,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<int> _onLoadPersonCount() async {
    IUpstreamPersonService personService =
        widget.context.site.getService('/upstream/persons');
    int count = await personService.count();
    return count;
  }

  Future<void> _onLoadPersons([String director = 'up']) async {
    if (director == 'down') {
      return;
    }
    IUpstreamPersonService personService =
        widget.context.site.getService('/upstream/persons');
    List<UpstreamPerson> persons =
        await personService.pagePerson(limit, offset);
    if (persons.length == 0) {
      return;
    }
    offset += persons.length;
    for (var person in persons) {
      var item = CardItem(
        title: person.accountName,
        leading: Image.file(
          File(person.avatar),
          width: 40,
          height: 40,
        ),
        onItemTap: () {
          widget.context
              .forward('/site/personal', arguments: {'person': person});
        },
      );
      this.personCardItems.add(item);
    }
  }

  _getPopupMenu() {
    return PopupMenuButton<String>(
      offset: Offset(
        0,
        50,
      ),
      onSelected: (value) async {
        if (value == null) return;
        var arguments = <String, Object>{};
        switch (value) {
          case '/netflow/manager/create_channel':
            showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: Text('选择管道类型'),
                    children: <Widget>[
                      DialogItem(
                        text: '开放管道',
                        icon: Icons.invert_colors,
                        color: Colors.grey[500],
                        subtext: '管道动态及管道出入站联系人对他人可见',
                        onPressed: () {
                          widget.context
                              .backward(result: <String, Object>{'type': '开放'});
                        },
                      ),
                      DialogItem(
                        text: '私有管道',
                        icon: Icons.invert_colors_off,
                        color: Colors.grey[500],
                        subtext: '管道动态及管道出入站联系人对他人不可见',
                        onPressed: () {
                          widget.context
                              .backward(result: <String, Object>{'type': '私有'});
                        },
                      ),
                    ],
                  );
                }).then((v) {
              print('xxxx-$v');
              if (v == null) return;
              widget.context.forward(value, arguments: v);
            });
            break;
          case '/netflow/manager/scan_channel':
            String cameraScanResult = await scanner.scan();
            if (cameraScanResult == null) break;
            arguments['qrcode'] = cameraScanResult;
            widget.context.forward(value, arguments: arguments);
            break;
        }
      },
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        PopupMenuItem(
          value: '/netflow/manager/create_channel',
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: Icon(
                  widget.context
                      .findPage('/netflow/manager/create_channel')
                      ?.icon,
                  color: Colors.grey[500],
                  size: 15,
                ),
              ),
              Text(
                '从我的公众添加',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: '/netflow/manager/scan_channel',
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: Icon(
                  widget.context
                      .findPage('/netflow/manager/scan_channel')
                      ?.icon,
                  color: Colors.grey[500],
                  size: 15,
                ),
              ),
              Text(
                '扫码以添加',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PersonsView extends StatefulWidget {
  List<CardItem> personCardItems;
  Future<void> Function(String director) onLoadPersons;

  PersonsView({this.personCardItems, this.onLoadPersons});

  @override
  _PersonsViewState createState() => _PersonsViewState();
}

class _PersonsViewState extends State<PersonsView> {
  @override
  Widget build(BuildContext context) {
    return SwipeRefreshLayout(
      onSwipeDown: () async {
        await widget.onLoadPersons('down');
      },
      onSwipeUp: () async {
        await widget.onLoadPersons('up');
        setState(() {});
      },
      child: ListView(
        children: widget.personCardItems.map((item) {
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                color: Colors.white,
                child: Dismissible(
                  key: ObjectKey(item),
                  child: item,
                  confirmDismiss: (DismissDirection direction) async {
                    if (direction == DismissDirection.endToStart) {
                      return await _showConfirmationDialog(context) == 'yes';
                    }
                    return false;
                  },
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.delete_sweep,
                      size: 16,
                    ),
                  ),
                  background: Container(),
                  onDismissed: (direction) {
                    switch (direction) {
                      case DismissDirection.endToStart:
                        print('---------do deleted');
                        break;
                      case DismissDirection.vertical:
                        // TODO: Handle this case.
                        break;
                      case DismissDirection.horizontal:
                        // TODO: Handle this case.
                        break;
                      case DismissDirection.startToEnd:
                        // TODO: Handle this case.
                        break;
                      case DismissDirection.up:
                        // TODO: Handle this case.
                        break;
                      case DismissDirection.down:
                        // TODO: Handle this case.
                        break;
                    }
                  },
                ),
              ),
              Container(
                height: 10,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Future<String> _showConfirmationDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text.rich(
          TextSpan(
            text: '是否移除？',
            children: [
              TextSpan(text: '\r\n'),
              TextSpan(
                text: '从管道移除后可在我的公众中找回',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('取消'),
            onPressed: () {
              Navigator.pop(context, 'no');
            },
          ),
          FlatButton(
            child: const Text('确定'),
            onPressed: () {
              Navigator.pop(context, 'yes');
            },
          ),
        ],
      ),
    );
  }
}
