import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/dao/daos.dart';
import 'package:gbera/portals/gbera/store/dao/database.dart';
import 'package:gbera/portals/gbera/store/services.dart';

import '../entities.dart';

class ChannelMediaService implements IChannelMediaService {
  IChannelMediaDAO channelMediaDAO;
  ChannelMediaService({ServiceSite site}){
    site.onready.add(() {
      AppDatabase db = site.database;
      channelMediaDAO = db.channelMediaDAO;
    });
  }

  @override
  Future<Function> addMedia(Media media) async{
   await channelMediaDAO.addMedia(media);
  }
}

class ChannelLikeService implements IChannelLikeService {
  IChannelLikePersonDAO channelLikeDAO;
  ChannelLikeService({ServiceSite site}){
    site.onready.add(() {
      AppDatabase db = site.database;
      channelLikeDAO = db.channelLikeDAO;
    });
  }
}

class ChannelCommentService implements IChannelCommentService {
  IChannelCommentDAO channelCommentDAO;
  ChannelCommentService({ServiceSite site}){
    site.onready.add(() {
      AppDatabase db = site.database;
      channelCommentDAO = db.channelCommentDAO;
    });
  }
}
