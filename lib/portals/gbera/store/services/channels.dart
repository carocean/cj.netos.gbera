import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/dao/daos.dart';
import 'package:gbera/portals/gbera/store/dao/database.dart';
import 'package:gbera/portals/gbera/store/services.dart';
import 'package:uuid/uuid.dart';

import '../entities.dart';

class ChannelService implements IChannelService {
  ///固定地推id，全平台一致
  static String _GEO_CHANNEL_ID = '4203EC25-1FC8-479D-A78F-74338FC7E769';
  IChannelDAO channelDAO;

  ChannelService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      channelDAO = db.channelDAO;
    });
  }
  @override
  Future<void> init(UserPrincipal user) async {
    if (await channelDAO.getChannel(_GEO_CHANNEL_ID) == null) {
      await channelDAO.addChannel(
        Channel(
            _GEO_CHANNEL_ID,
            '地推',
            user.person,
            'openLoop',
            null,
            null,
            null,
            DateTime.now().millisecondsSinceEpoch,
            DateTime.now().millisecondsSinceEpoch,
            0),
      );
    }
  }

  @override
  Future<void> empty() async {
    await this.channelDAO.empty();
  }

  @override
  Future<List<Channel>> getChannelsOfPerson(String personid) async {
    return await this.channelDAO.getChannelsOfPerson(personid);
  }

  @override
  Future<List<Channel>> getAllChannel() async {
    return await this.channelDAO.getAllChannel();
  }

  @override
  Future<void> addChannel(Channel channel) async {
    await this.channelDAO.addChannel(channel);
  }

  @override
  Future<Channel> getChannel(String channelid) async {
    return await this.channelDAO.getChannel(channelid);
  }

  @override
  Future<bool> existsName(String channelName, String owner) async {
    var ch = await this.channelDAO.getChannelByName(channelName, owner);
    return ch == null ? false : true;
  }

  @override
  Future<bool> existsChannel(channelid) async {
    var ch = await this.channelDAO.getChannel(channelid);
    return ch == null ? false : true;
  }

  @override
  Future<void> emptyOfPerson(String personid) async {
    await this.channelDAO.emptyOfPerson(personid);
  }
}
