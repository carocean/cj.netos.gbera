import 'dart:async';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../entities.dart';
import 'daos.dart';

part 'database.g.dart';

@Database(version: 1, entities: [
  UpstreamPerson,
  DownstreamPerson,
  MicroSite,
  MicroApp,
  ExternalChannel,
  InsiteMessage,
  ChannelMessage,
  Comment,
  Media,
  MyChannel,
  ChannelInput,
  ChannelOutput,
  ChannelOutputPerson,
])
abstract class AppDatabase extends FloorDatabase {
  IUpstreamPersonDAO get upstreamPersonDAO;

  IDownstreamPersonDAO get downstreamPersonDAO;

  IMicroSiteDAO get microSiteDAO;

  IMicroAppDAO get microAppDAO;

  IExternalChannelDAO get externalChannelDAO;

  IInsiteMessageDAO get insiteMessageDAO;
}
