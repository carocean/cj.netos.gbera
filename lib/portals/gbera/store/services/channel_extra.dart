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
  Future<Function> remove(String id) async {
    await channelMediaDAO.removeMedia(id);
  }

  @override
  Future<Function> addMedia(Media media) async {
    await channelMediaDAO.addMedia(media);
  }

  @override
  Future<List<Media>> getMedias(String messageid) async {
    return await channelMediaDAO.getMediaByMsgId(messageid);
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
