import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/pages/netflow/channel.dart';
import 'package:gbera/portals/gbera/parts/CardItem.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class InsitePersons extends StatefulWidget {
  PageContext context;

  InsitePersons({this.context});

  @override
  _InsitePersonsState createState() => _InsitePersonsState();
}

class _InsitePersonsState extends State<InsitePersons> {
  @override
  Widget build(BuildContext context) {
    var items = <CardItem>[];
    for (int i = 0; i < 1; i++) {
      items.add(
        CardItem(
          title: '精灵仔',
          leading: Image.network(
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573879749787&di=bf912f586fd957b9dd33ba88910a3aae&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201803%2F24%2F20180324081023_8FVre.jpeg',
            width: 40,
            height: 40,
          ),
          onItemTap: () {
            widget.context.forward('/site/personal');
          },
        ),
      );
    }
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
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
                  Text.rich(
                    TextSpan(
                      text: '1200人',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                      children: [
                        TextSpan(text: '  '),
                        TextSpan(
                          text: '连结我',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()..onTap=(){
                            print('----关注');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Column(
                children: items.map((v) {
                  return Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        color: Colors.white,
                        child: Dismissible(
                          key: ObjectKey(v),
                          child: v,
                          confirmDismiss: (DismissDirection direction) async {
                            if (direction == DismissDirection.endToStart) {
                              return await _showConfirmationDialog(context) ==
                                  'yes';
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
            ),
          ),
        ],
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
          value: '/netflow/channel/insite/persons_settings',
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: Icon(
                  widget.context
                      .findPage('/netflow/channel/insite/persons_settings')
                      ?.icon,
                  color: Colors.grey[500],
                  size: 15,
                ),
              ),
              Text(
                '进口权限',
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
