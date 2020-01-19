import 'dart:io';

import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/dao/daos.dart';
import 'package:gbera/portals/gbera/store/dao/database.dart';
import 'package:gbera/portals/gbera/store/services.dart';

import '../entities.dart';

class ChannelMediaService implements IChannelMediaService {
  IChannelMediaDAO channelMediaDAO;

  ChannelMediaService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      channelMediaDAO = db.channelMediaDAO;
    });
  }

  @override
  Future<void> remove(String id) async {
    var m = await channelMediaDAO.getMedia(id);
    if (m == null) {
      return;
    }
    _deleteFile(m);
    await channelMediaDAO.removeMedia(id);
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
    await channelMediaDAO.removeMedia(channelid);
  }

  @override
  Future<Function> addMedia(Media media) async {
    await channelMediaDAO.addMedia(media);
  }

  @override
  Future<List<Media>> getMedias(String messageid) async {
    return await channelMediaDAO.getMediaByMsgId(messageid);
  }
  @override
  Future<List<Media>> getMediasBy(String channelid)async {
    return await channelMediaDAO.getMediaByChannelId(channelid);
  }

}

class ChannelLikeService implements IChannelLikeService {
  IChannelLikePersonDAO channelLikeDAO;

  ChannelLikeService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      channelLikeDAO = db.channelLikeDAO;
    });
  }

  @override
  Future<Function> removeBy(String channelid) async{
   await channelLikeDAO.removeLikePersonByChannel(channelid);
  }

  @override
  Future<Function> remove(String id) async {
    await channelLikeDAO.removeLikePerson(id);
  }

  @override
  Future<List<LikePerson>> pageLikePersons(
      String msgid, int pageSize, int offset) async {
    return await channelLikeDAO.pageLikePersonBy(msgid, pageSize, offset);
  }

  @override
  Future<bool> isLiked(String msgid, String person) async {
    var likes = await channelLikeDAO.getLikePersonBy(msgid, person);
    return likes.isEmpty ? false : true;
  }

  @override
  Future<Function> unlike(String msgid, String person) async {
    await channelLikeDAO.removeLikePersonBy(msgid, person);
  }

  @override
  Future<Function> like(LikePerson like) async {
    await channelLikeDAO.addLikePerson(like);
  }
}

class ChannelCommentService implements IChannelCommentService {
  IChannelCommentDAO channelCommentDAO;

  ChannelCommentService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      channelCommentDAO = db.channelCommentDAO;
    });
  }

  @override
  Future<Function> removeBy(String channelid) async{
    await channelCommentDAO.removeCommentBy(channelid);

  }

  @override
  Future<Function> addComment(ChannelComment comment) async {
    await channelCommentDAO.addComment(comment);
  }

  @override
  Future<List<ChannelComment>> pageComments(
      String msgid, int pageSize, int offset) async {
    return await channelCommentDAO.pageLikeCommentBy(msgid, pageSize, offset);
  }

  @override
  Future<Function> removeComment(String id) async {
    await channelCommentDAO.removeComment(id);
  }
}
