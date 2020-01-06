import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/dao/daos.dart';
import 'package:gbera/portals/gbera/store/dao/database.dart';
import 'package:gbera/portals/gbera/store/services.dart';

import '../entities.dart';

class ExternalChannelService implements IExternalChannelService {
  IExternalChannelDAO externalChannelDAO;

  ExternalChannelService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      externalChannelDAO = db.externalChannelDAO;
    });
  }

  @override
  Future<void> empty() async {
    await this.externalChannelDAO.empty();
  }

  @override
  Future<List<ExternalChannel>> getChannelsOfPerson(String personid) async {
    return await this.externalChannelDAO.getChannelsOfPerson(personid);
  }

  @override
  Future<void> addChannel(ExternalChannel channel) async {
    await this.externalChannelDAO.addChannel(channel);
  }

  @override
  Future<ExternalChannel> getChannel(String channelid) async {
    return await this.externalChannelDAO.getChannel(channelid);
  }

  @override
  Future<bool> existsChannel(channelid) async {
    var ch = await this.externalChannelDAO.getChannel(channelid);
    return ch == null ? false : true;
  }

  @override
  Future<void> emptyOfPerson(String personid) async {
    await this.externalChannelDAO.emptyOfPerson(personid);
  }
}
