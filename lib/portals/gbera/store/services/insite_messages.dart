import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/dao/daos.dart';
import 'package:gbera/portals/gbera/store/dao/database.dart';

import '../entities.dart';
import '../services.dart';

class InsiteMessageService implements IInsiteMessageService {
  IInsiteMessageDAO insiteMessageDAO;
  Environment env;
  InsiteMessageService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      insiteMessageDAO = db.insiteMessageDAO;
      env=site.getService('@.environment');
    });
  }

  @override
  Future<Function> empty() async {
    await insiteMessageDAO.empty(env?.userPrincipal?.person);
  }

  @override
  Future<List<InsiteMessage>> getAllMessage() async {
    return await insiteMessageDAO.getAllMessage(env?.userPrincipal?.person);
  }

  @override
  Future<List<InsiteMessage>> pageMessageByChannelVisualable(
      int limit, int offset, String loopType) async {
    return await insiteMessageDAO.pageMessageByChannelLoopType(loopType,env?.userPrincipal?.person,
        limit, offset);
  }

  @override
  Future<List<InsiteMessage>> pageMessage(int pageSize, int currPage) async {
    return await insiteMessageDAO.pageMessage(env?.userPrincipal?.person,pageSize, currPage);
  }

  @override
  Future<Function> addMessage(InsiteMessage message) async {
    await insiteMessageDAO.addMessage(message);
  }

  @override
  Future<bool> existsMessage(id) async {
    var msg = await insiteMessageDAO.getMessage(id,env?.userPrincipal?.person);
    return msg == null ? false : true;
  }
}
