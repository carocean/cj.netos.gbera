import 'dart:io';

import 'package:floor/floor.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/dao/daos.dart';
import 'package:gbera/portals/gbera/store/dao/database.dart';

import '../entities.dart';
import '../services.dart';

class ChannelMessageService implements IChannelMessageService {
  IChannelMessageDAO channelMessageDAO;
  IChannelMediaService mediaService;
  IChannelCommentService commentService;
  IChannelLikeService likeService;

  ChannelMessageService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      channelMessageDAO = db.channelMessageDAO;
      mediaService = site.getService('/channel/messages/medias');
      commentService = site.getService('/channel/messages/comments');
      likeService = site.getService('/channel/messages/likes');
    });
  }

  @override
  Future<List<ChannelMessage>> pageMessageBy(
      int limit, int offset, String onchannel, String person) async{
    return await channelMessageDAO.pageMessageBy(onchannel,person,limit,offset,);
  }

  @transaction
  @override
  Future<Function> removeMessage(String id) async {
    await channelMessageDAO.removeMessage(id);
    List<Media> medias = await mediaService.getMedias(id);
    for (var m in medias) {
      mediaService.remove(m.id);
    }
    List<ChannelComment> comments =
        await commentService.pageComments(id, 100000000, 0);
    for (var m in comments) {
      await commentService.removeComment(m.id);
    }
    List<LikePerson> likes =
        await likeService.pageLikePersons(id, 100000000, 0);
    for (var m in likes) {
      await likeService.remove(m.id);
    }
  }

  @override
  Future<Function> emptyBy(String channelid) async{
    //还要清除掉媒体文件
    await mediaService.removeBy(channelid);
    await likeService.removeBy(channelid);
    await commentService.removeBy(channelid);
    await channelMessageDAO.removeMessagesBy(channelid);

  }

  @override
  Future<List<ChannelMessage>> getAllMessage() async {}

  @override
  Future<List<ChannelMessage>> pageMessage(
      int pageSize, int currPage, String onChannel) async {
    return await channelMessageDAO.pageMessage(onChannel, pageSize, currPage);
  }

  @override
  Future<Function> addMessage(ChannelMessage message) {
    channelMessageDAO.addMessage(message);
  }

  @override
  Future<bool> existsMessage(id) {}

  @override
  Future<Function> empty() {}
}
