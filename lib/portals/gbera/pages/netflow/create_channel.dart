import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/entities.dart';
import 'package:gbera/portals/gbera/store/services.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class CreateChannel extends StatefulWidget {
  PageContext context;

  CreateChannel({this.context});

  @override
  _CreateChannelState createState() => _CreateChannelState();
}

class _CreateChannelState extends State<CreateChannel> {
  TextEditingController _channel_name_value;

  @override
  void initState() {
    _channel_name_value = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _channel_name_value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _globalKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _globalKey,
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
          IconButton(
            icon: Icon(
              Icons.check,
            ),
            onPressed: () async {
              IChannelService channelService =
                  widget.context.site.getService('/netflow/channels');
              UserPrincipal user = widget.context.principal;
              var channelName = _channel_name_value.text;
              if (await channelService.existsName(channelName, user.person)) {
                _globalKey.currentState.showSnackBar(SnackBar(
                  content: Container(
                    height: 40,
                    child: Text(
                      '已存在管道：$channelName',
                    ),
                  ),
                ));
                return;
              }
              Channel channel = Channel(
                '${Uuid().v1()}',
                '${Uuid().v1()}',
                channelName,
                user.person,
                widget.context.parameters['type'],
                null,
                null,
                DateTime.now().millisecondsSinceEpoch,
                widget.context.principal.person,
              );
              await channelService.addChannel(channel);
              widget.context.backward();
            },
          ),
        ],
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 60,
          ),
          margin: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text.rich(
                  TextSpan(
                    text: '类型: ',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    children: [
                      TextSpan(
                        text:
                            '${widget.context.parameters['type'] == 'closeLoop' ? '闭环管道' : '开环管道'}',
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextField(
                autofocus: true,
                controller: _channel_name_value,
                decoration: InputDecoration(
                  labelText: '管道名',
                  hintText: '输入名称',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
