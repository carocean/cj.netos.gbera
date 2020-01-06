import 'package:floor/floor.dart';

import '../entities.dart';

@dao
abstract class IUpstreamPersonDAO {
  @insert
  Future<void> addPerson(UpstreamPerson person);

  @Query('delete FROM UpstreamPerson WHERE id = :id')
  Future<void> removePerson(String id);

  @Query('delete FROM UpstreamPerson')
  Future<void> empty();

  @Query('SELECT *  FROM UpstreamPerson LIMIT :pageSize OFFSET  :currPage')
  Future<List<UpstreamPerson>> pagePerson(int pageSize, int currPage);

  @Query('SELECT * FROM UpstreamPerson WHERE id = :id')
  Future<UpstreamPerson> getPerson(String id);

  @Query('SELECT * FROM UpstreamPerson')
  Future<List<UpstreamPerson>> getAllPerson();
}

@dao
abstract class IDownstreamPersonDAO {
  @insert
  Future<void> addPerson(DownstreamPerson person);

  @Query('delete FROM DownstreamPerson WHERE id = :id')
  Future<void> removePerson(String id);

  @Query('delete FROM DownstreamPerson')
  Future<void> empty();

  @Query('SELECT *  FROM DownstreamPerson LIMIT :pageSize OFFSET  :currPage')
  Future<List<DownstreamPerson>> pagePerson(int pageSize, int currPage);

  @Query('SELECT * FROM DownstreamPerson WHERE id = :id')
  Future<DownstreamPerson> getPerson(String id);

  @Query('SELECT * FROM DownstreamPerson')
  Future<List<DownstreamPerson>> getAllPerson();
}

@dao
abstract class IExternalChannelDAO {
  @insert
  Future<void> addChannel(ExternalChannel channel);

  @Query('delete FROM ExternalChannel WHERE id = :channelid')
  Future<void> removeChannel(String channelid);

  @Query('SELECT *  FROM ExternalChannel LIMIT :pageSize OFFSET  :currPage')
  Future<List<ExternalChannel>> pageChannel(int pageSize, int currPage);

  @Query('SELECT * FROM ExternalChannel WHERE id = :channelid')
  Future<ExternalChannel> getChannel(String channelid);

  @Query('SELECT * FROM ExternalChannel')
  Future<List<ExternalChannel>> getAllChannel();

  @Query('delete FROM ExternalChannel')
  Future<void> empty();

  @Query('delete FROM ExternalChannel WHERE owner = :personid')
  Future<void> emptyOfPerson(String personid);

  @Query('SELECT * FROM ExternalChannel WHERE owner = :personid')
  Future<List<ExternalChannel>> getChannelsOfPerson(String personid);
}

@dao
abstract class IInsiteMessageDAO {
  @insert
  Future<void> addMessage(InsiteMessage message);

  @Query('delete FROM InsiteMessage WHERE id = :id')
  Future<void> removeMessage(String id);

  @Query('SELECT *  FROM InsiteMessage LIMIT :pageSize OFFSET :currPage')
  Future<List<InsiteMessage>> pageMessage(int pageSize, int currPage);

  @Query('SELECT * FROM InsiteMessage WHERE id = :id')
  Future<InsiteMessage> getMessage(String id);

  @Query('SELECT * FROM InsiteMessage')
  Future<List<InsiteMessage>> getAllMessage();

  @Query('delete FROM InsiteMessage')
  Future<void> empty();
}

@dao
abstract class IMicroSiteDAO {
  @insert
  Future<void> addSite(MicroSite site);

  @Query('delete FROM MicroSite WHERE id = :id')
  Future<void> removeSite(String id);

  @Query('SELECT *  FROM MicroSite LIMIT :pageSize OFFSET  :currPage')
  Future<List<MicroSite>> pageSite(int pageSize, int currPage);

  @Query('SELECT * FROM MicroSite WHERE id = :id')
  Future<MicroSite> getSite(String id);

  @Query('SELECT * FROM MicroSite')
  Future<List<MicroSite>> getAllSite();
}

@dao
abstract class IMicroAppDAO {
  @insert
  Future<void> addApp(MicroApp site);

  @Query('delete FROM MicroApp WHERE id = :id')
  Future<void> removeApp(String id);

  @Query('SELECT *  FROM MicroApp LIMIT :pageSize OFFSET  :currPage')
  Future<List<MicroApp>> pageApp(int pageSize, int currPage);

  @Query('SELECT * FROM MicroApp WHERE id = :id')
  Future<MicroApp> getApp(String id);

  @Query('SELECT * FROM MicroApp')
  Future<List<MicroApp>> getAllApp();
}
