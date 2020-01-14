import 'package:floor/floor.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/dao/daos.dart';
import 'package:gbera/portals/gbera/store/dao/database.dart';

import '../entities.dart';
import '../services.dart';

class ChannelMessageService implements IChannelMessageService {
  IChannelMessageDAO channelMessageDAO;

  ChannelMessageService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      channelMessageDAO = db.channelMessageDAO;
    });
  }

  @override
  Future<List<ChannelMessage>> getAllMessage() async{

  }

  @override
  Future<List<ChannelMessage>> pageMessage(int pageSize, int currPage) {

  }

  @override
  Future<Function> addMessage(ChannelMessage message) {

  }

  @override
  Future<bool> existsMessage(id) {

  }

  @override
  Future<Function> empty() {

  }
}
