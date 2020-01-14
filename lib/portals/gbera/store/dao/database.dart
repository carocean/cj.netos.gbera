import 'dart:async';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../entities.dart';
import 'daos.dart';

part 'database.g.dart';

@Database(version: 1, entities: [
  Person,
  MicroSite,
  MicroApp,
  Channel,
  InsiteMessage,
  ChannelMessage,
  ChannelComment,
  LikePerson,
  Media,
  ChannelInput,
  ChannelOutput,
  ChannelOutputPerson,
])
abstract class AppDatabase extends FloorDatabase {
  IPersonDAO get upstreamPersonDAO;

  IMicroSiteDAO get microSiteDAO;

  IMicroAppDAO get microAppDAO;

  IChannelDAO get channelDAO;

  IInsiteMessageDAO get insiteMessageDAO;
  IChannelMessageDAO get channelMessageDAO;
  IChannelMediaDAO get channelMediaDAO;
  IChannelLikePersonDAO get channelLikeDAO;
  IChannelCommentDAO get channelCommentDAO;
}
