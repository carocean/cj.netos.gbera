import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/dao/daos.dart';
import 'package:gbera/portals/gbera/store/dao/database.dart';

import '../entities.dart';
import '../services.dart';

class InsiteMessageService implements IInsiteMessageService {
  IInsiteMessageDAO insiteMessageDAO;

  InsiteMessageService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      insiteMessageDAO = db.insiteMessageDAO;
    });
  }

  @override
  Future<Function> empty() async {
    await insiteMessageDAO.empty();
  }

  @override
  Future<List<InsiteMessage>> getAllMessage() async {
    return await insiteMessageDAO.getAllMessage();
  }

  @override
  Future<List<InsiteMessage>> pageMessageByChannelVisualable(
      int limit, int offset, String isPublic) async {
    return await insiteMessageDAO.pageMessageByChannelVisualable(isPublic,
        limit, offset);
  }

  @override
  Future<List<InsiteMessage>> pageMessage(int pageSize, int currPage) async {
    return await insiteMessageDAO.pageMessage(pageSize, currPage);
  }

  @override
  Future<Function> addMessage(InsiteMessage message) async {
    await insiteMessageDAO.addMessage(message);
  }

  @override
  Future<bool> existsMessage(id) async {
    var msg = await insiteMessageDAO.getMessage(id);
    return msg == null ? false : true;
  }
}
