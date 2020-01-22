import 'dart:io';

import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/dao/daos.dart';
import 'package:gbera/portals/gbera/store/dao/database.dart';
import 'package:gbera/portals/gbera/store/services.dart';

import '../entities.dart';

class ChannelMediaService implements IChannelMediaService {
  IChannelMediaDAO channelMediaDAO;
  Environment env;
  ChannelMediaService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      channelMediaDAO = db.channelMediaDAO;
      env=site.getService('@.environment');
    });
  }

  @override
  Future<void> remove(String id) async {
    var m = await channelMediaDAO.getMedia(id,env?.userPrincipal?.person);
    if (m == null) {
      return;
    }
    _deleteFile(m);
    await channelMediaDAO.removeMedia(id,env?.userPrincipal?.person);
  }

  _deleteFile(media) {
    if (StringUtil.isEmpty(media.src)) {
      return;
    }
    var f = File(media.src);
    if (f.existsSync()) {
      try {
        f.deleteSync();
      } catch (e) {
        print('$e');
      }
    }
  }

  @override
  Future<Function> removeBy(String channelid) async {
    var list =await getMediasBy(channelid);
    for (var m in list) {
      _deleteFile(m);
    }
    await channelMediaDAO.removeMedia(channelid,env?.userPrincipal?.person);
  }

  @override
  Future<Function> addMedia(Media media) async {
    await channelMediaDAO.addMedia(media);
  }

  @override
  Future<List<Media>> getMedias(String messageid) async {
    return await channelMediaDAO.getMediaByMsgId(messageid,env?.userPrincipal?.person);
  }
  @override
  Future<List<Media>> getMediasBy(String channelcode)async {
    return await channelMediaDAO.getMediaBychannelcode(channelcode,env?.userPrincipal?.person);
  }

}

class ChannelLikeService implements IChannelLikeService {
  IChannelLikePersonDAO channelLikeDAO;
  Environment env;
  ChannelLikeService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      channelLikeDAO = db.channelLikeDAO;
      env=site.getService('@.environment');
    });
  }

  @override
  Future<Function> removeBy(String channelcode) async{
   await channelLikeDAO.removeLikePersonByChannel(channelcode,env?.userPrincipal?.person);
  }

  @override
  Future<Function> remove(String id) async {
    await channelLikeDAO.removeLikePerson(id,env?.userPrincipal?.person);
  }

  @override
  Future<List<LikePerson>> pageLikePersons(
      String msgid, int pageSize, int offset) async {
    return await channelLikeDAO.pageLikePersonBy(msgid,env?.userPrincipal?.person, pageSize, offset);
  }

  @override
  Future<bool> isLiked(String msgid, String person) async {
    var likes = await channelLikeDAO.getLikePersonBy(msgid, person,env?.userPrincipal?.person);
    return likes.isEmpty ? false : true;
  }

  @override
  Future<Function> unlike(String msgid, String person) async {
    await channelLikeDAO.removeLikePersonBy(msgid, person,env?.userPrincipal?.person);
  }

  @override
  Future<Function> like(LikePerson like) async {
    await channelLikeDAO.addLikePerson(like);
  }
}

class ChannelCommentService implements IChannelCommentService {
  IChannelCommentDAO channelCommentDAO;
Environment env;
  ChannelCommentService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      channelCommentDAO = db.channelCommentDAO;
      env=site.getService('@.environment');
    });
  }

  @override
  Future<Function> removeBy(String channelcode) async{
    await channelCommentDAO.removeCommentBy(channelcode,env?.userPrincipal?.person);

  }

  @override
  Future<Function> addComment(ChannelComment comment) async {
    await channelCommentDAO.addComment(comment);
  }

  @override
  Future<List<ChannelComment>> pageComments(
      String msgid, int pageSize, int offset) async {
    return await channelCommentDAO.pageLikeCommentBy(msgid,env?.userPrincipal?.person, pageSize, offset);
  }

  @override
  Future<Function> removeComment(String id) async {
    await channelCommentDAO.removeComment(id,env?.userPrincipal?.person);
  }
}
