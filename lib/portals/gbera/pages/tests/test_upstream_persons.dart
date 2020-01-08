import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/entities.dart';
import 'package:gbera/portals/gbera/store/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class TestUpstreamPersonService extends StatefulWidget {
  PageContext context;

  TestUpstreamPersonService({this.context});

  @override
  _TestUpstreamPersonServiceState createState() =>
      _TestUpstreamPersonServiceState();
}

class _TestUpstreamPersonServiceState extends State<TestUpstreamPersonService> {
  TextEditingController _jsonText;

  @override
  void initState() {
    super.initState();
    _jsonText = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('上游公众'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              child: FlatButton(
                child: Text('更新'),
                onPressed: () async {
                  List<dynamic> persons = json.decode(_jsonText.text);
                  IUpstreamPersonService personService =
                      widget.context.site.getService('/upstream/persons');
                  IExternalChannelService channelService =
                      widget.context.site.getService('/external/channels');
                  Dio dio = widget.context.site.getService('@.http');
                  await personService.empty();
                  for (var obj in persons) {
                    if (await personService.existsPerson(obj['id'])) {
                      continue;
                    }
                    var home = await getApplicationDocumentsDirectory();
                    var dir = Directory('${home.path}/pictures/share');
                    if (!dir.existsSync()) {
                      dir.createSync(recursive: true);
                    }
                    var avatar = '${dir.path}/${Uuid().v1()}';
                    await dio.download(obj['avatar'], avatar);
                    UpstreamPerson person = UpstreamPerson(
                      obj['id'],
                      obj['uid'],
                      obj['accountid'],
                      obj['accountName'],
                      obj['appid'],
                      obj['tenantid'],
                      avatar,
                    );
                    await personService.addPerson(person);
                    var objchs = obj['channels'];
                    if (objchs == null) {
                      continue;
                    }

                    await channelService.emptyOfPerson(person.id);
                    for (var och in objchs) {
                      if (await channelService.existsChannel(och['id'])) {
                        continue;
                      }
                      ExternalChannel ch = ExternalChannel(
                        och['id'],
                        och['name'],
                        och['owner'],
                        och['isPublic'],
                        och['leading'],
                        och['site'],
                      );
                      channelService.addChannel(ch);
                    }
                  }
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: FutureBuilder(
                future: _loadUpstreamPersonJson(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  _jsonText.text = snapshot.data ?? '';
                  return TextField(
                    controller: _jsonText,
                    minLines: 10,
                    maxLines: 1000,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _loadUpstreamPersonJson(context) async {
    var json = DefaultAssetBundle.of(context)
        .loadString('model/upstream_persons.json');
    return json;
  }
}
