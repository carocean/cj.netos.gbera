import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/dao/daos.dart';
import 'package:gbera/portals/gbera/store/dao/database.dart';
import 'package:gbera/portals/gbera/store/services.dart';
import 'package:uuid/uuid.dart';

import '../entities.dart';

class ChannelService implements IChannelService {
  ///固定管道
  static const Map<String, String> _SYSTEM_CHANNELS = {
    ///地推id
    'geo_channel': '4203EC25-1FC8-479D-A78F-74338FC7E769'
  };
  IChannelDAO channelDAO;
  IChannelMessageService messageService;
  IChannelPinService pinService;
  ChannelService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      channelDAO = db.channelDAO;
      messageService = site.getService('/channel/messages');
      pinService=site.getService('/channel/pin');
    });
  }
  @override
   bool isSystemChannel(channelid) {
    return _SYSTEM_CHANNELS.containsValue(channelid);
  }
  @override
   String getSystemChannel(String channelid) {
    return _SYSTEM_CHANNELS[channelid];
  }
  @override
   Iterable<String> listSystemChannel() {
    return _SYSTEM_CHANNELS.values;
  }

  @override
  Future<void> init(UserPrincipal user) async {
    var _GEO_CHANNEL_ID=_SYSTEM_CHANNELS['geo_channel'];
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
      await pinService.init(_GEO_CHANNEL_ID);
      await pinService.setOutputGeoSelector(_GEO_CHANNEL_ID, true);
    }
  }

  @override
  Future<Function> updateName(String channelid, String text) async{
    await this.channelDAO.updateName(text,channelid);
  }

  @override
  Future<void> updateLeading(String path, String channelid) async {
    await this.channelDAO.updateLeading(path, channelid);
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
    await pinService.init(channel.id);
  }

  @override
  Future<Function> remove(String channelid) async {
    await messageService.emptyBy(channelid);
    await this.pinService.removePin(channelid);
    await channelDAO.removeChannel(channelid);
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
