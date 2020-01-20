import 'package:floor/floor.dart';

import '../entities.dart';

@dao
abstract class IPersonDAO {
  @insert
  Future<void> addPerson(Person person);

  @Query('delete FROM Person WHERE id = :id')
  Future<void> removePerson(String id);

  @Query('delete FROM Person')
  Future<void> empty();

  @Query('SELECT *  FROM Person LIMIT :pageSize OFFSET  :currPage')
  Future<List<Person>> pagePerson(int pageSize, int currPage);

  @Query('SELECT * FROM Person WHERE id = :id')
  Future<Person> getPerson(String id);

  @Query('SELECT * FROM Person')
  Future<List<Person>> getAllPerson();

  @Query("SELECT * FROM Person")
  Future<List<Person>> countPersons();

  @Query(
      'SELECT *  FROM Person where id NOT IN (:ids) LIMIT :persons_limit OFFSET  :persons_offset')
  Future<List<Person>> pagePersonWithout(
      List<String> ids, int persons_limit, int persons_offset);

  @Query(
      "SELECT *  FROM Person where id IN (:ids)")
  Future<List<Person>> listPersonWith(List<String> ids);

  @Query(
      'SELECT * FROM Person WHERE accountName = :accountName and appid=:appid and tenantid=:tenantid LIMIT 1 OFFSET 0')
  Future<Person> findPerson(String accountName, String appid, String tenantid);
}

@dao
abstract class IChannelDAO {
  @insert
  Future<void> addChannel(Channel channel);

  @Query('delete FROM Channel WHERE id = :channelid')
  Future<void> removeChannel(String channelid);

  @Query('SELECT *  FROM Channel LIMIT :pageSize OFFSET  :currPage')
  Future<List<Channel>> pageChannel(int pageSize, int currPage);

  @Query('SELECT * FROM Channel WHERE id = :channelid')
  Future<Channel> getChannel(String channelid);

  @Query('SELECT * FROM Channel ORDER BY utime DESC,ctime DESC')
  Future<List<Channel>> getAllChannel();

  @Query('delete FROM Channel')
  Future<void> empty();

  @Query('delete FROM Channel WHERE owner = :personid')
  Future<void> emptyOfPerson(String personid);

  @Query('SELECT * FROM Channel WHERE owner = :personid')
  Future<List<Channel>> getChannelsOfPerson(String personid);

  @Query('SELECT * FROM Channel WHERE name = :channelName AND owner = :owner')
  Future<Channel> getChannelByName(String channelName, String owner);

  @Query('UPDATE Channel SET leading = :path WHERE id = :channelid')
  Future<void> updateLeading(String path, String channelid);
}

@dao
abstract class IInsiteMessageDAO {
  @insert
  Future<void> addMessage(InsiteMessage message);

  @Query('delete FROM InsiteMessage WHERE id = :id')
  Future<void> removeMessage(String id);

  @Query('SELECT *  FROM InsiteMessage LIMIT :pageSize OFFSET :currPage')
  Future<List<InsiteMessage>> pageMessage(int pageSize, int currPage);

  @Query(
      'SELECT msg.*  FROM InsiteMessage msg,Channel ch  WHERE msg.onChannel=ch.id AND ch.loopType=:loopType LIMIT :pageSize OFFSET :currPage')
  Future<List<InsiteMessage>> pageMessageByChannelLoopType(
      String loopType, int limit, int offset);

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

@dao
abstract class IChannelMessageDAO {
  @insert
  Future<void> addMessage(ChannelMessage message);

  @Query('delete FROM ChannelMessage WHERE id = :id')
  Future<void> removeMessage(String id);

  @Query(
      'SELECT *  FROM ChannelMessage WHERE onChannel = :onChannel ORDER BY ctime DESC  LIMIT :pageSize OFFSET :currPage')
  Future<List<ChannelMessage>> pageMessage(
      String onChannel, int pageSize, int currPage);

  @Query(
      'SELECT msg.*  FROM ChannelMessage msg,Channel ch  WHERE msg.onChannel=ch.id AND ch.loopType=:loopType LIMIT :pageSize OFFSET :currPage')
  Future<List<ChannelMessage>> pageMessageByChannelLoopType(
      String loopType, int limit, int offset);

  @Query('SELECT * FROM ChannelMessage WHERE id = :id')
  Future<ChannelMessage> getMessage(String id);

  @Query('SELECT * FROM ChannelMessage')
  Future<List<ChannelMessage>> getAllMessage();

  @Query('delete FROM ChannelMessage')
  Future<void> empty();

  @Query('delete FROM ChannelMessage where onChannel=:channelid')
  Future<void> removeMessagesBy(String channelid) {}
}

@dao
abstract class IChannelMediaDAO {
  @insert
  Future<void> addMedia(Media media);

  @Query('delete FROM Media WHERE id = :id')
  Future<void> removeMedia(String id);

  @Query('SELECT *  FROM Media LIMIT :pageSize OFFSET  :currPage')
  Future<List<Media>> pageMedia(int pageSize, int currPage);

  @Query('SELECT * FROM Media WHERE id = :id')
  Future<Media> getMedia(String id);

  @Query('SELECT * FROM Media')
  Future<List<Media>> getAllMedia();

  @Query('SELECT * FROM Media WHERE msgid = :msgid')
  Future<List<Media>> getMediaByMsgId(String msgid);

  @Query('SELECT * FROM Media WHERE onChannel = :channelid')
  Future<List<Media>> getMediaByChannelId(String channelid);
}

@dao
abstract class IChannelLikePersonDAO {
  @insert
  Future<void> addLikePerson(LikePerson likePerson);

  @Query('delete FROM LikePerson WHERE id = :id')
  Future<void> removeLikePerson(String id);

  @Query('SELECT *  FROM LikePerson LIMIT :pageSize OFFSET  :currPage')
  Future<List<LikePerson>> pageLikePerson(int pageSize, int currPage);

  @Query('SELECT * FROM LikePerson WHERE id = :id')
  Future<LikePerson> getLikePerson(String id);

  @Query('SELECT * FROM LikePerson')
  Future<List<LikePerson>> getAllLikePerson();

  @Query('SELECT * FROM LikePerson WHERE msgid = :msgid AND person=:person')
  Future<List<LikePerson>> getLikePersonBy(String msgid, String person);

  @Query('delete FROM LikePerson WHERE msgid = :msgid AND person=:person')
  Future<void> removeLikePersonBy(String msgid, String person);

  @Query(
      'SELECT *  FROM LikePerson WHERE msgid=:msgid  LIMIT :pageSize OFFSET  :offset')
  Future<List<LikePerson>> pageLikePersonBy(
      String msgid, int pageSize, int offset);

  @Query('delete FROM LikePerson WHERE onChannel = :channelid')
  Future<void> removeLikePersonByChannel(String channelid);
}

@dao
abstract class IChannelCommentDAO {
  @insert
  Future<void> addComment(ChannelComment comment);

  @Query('delete FROM ChannelComment WHERE id = :id')
  Future<void> removeComment(String id);

  @Query('SELECT *  FROM ChannelComment LIMIT :pageSize OFFSET  :currPage')
  Future<List<ChannelComment>> pageComment(int pageSize, int currPage);

  @Query('SELECT * FROM ChannelComment WHERE id = :id')
  Future<ChannelComment> getComment(String id);

  @Query('SELECT * FROM ChannelComment')
  Future<List<ChannelComment>> getAllComment();

  @Query(
      'SELECT *  FROM ChannelComment WHERE msgid=:msgid  LIMIT :pageSize OFFSET  :offset')
  Future<List<ChannelComment>> pageLikeCommentBy(
      String msgid, int pageSize, int offset) {}

  @Query('delete FROM ChannelComment WHERE onChannel = :channelid')
  Future<void> removeCommentBy(String channelid);
}

@dao
abstract class IChannelPinDAO {
  @Query(
      'UPDATE ChannelPin SET outPersonSelector = :selector WHERE channel = :channelid')
  Future<void> setOutputPersonSelector(selector, String channelid);

  @Query(
      'UPDATE ChannelPin SET outGeoSelector = :isset WHERE channel = :channelid')
  Future<void> setOutputGeoSelector(String isset, String channelid);

  @Query('SELECT *  FROM ChannelPin WHERE channel=:channelid')
  Future<ChannelPin> getChannelPin(String channelid);

  @insert
  Future<void> addChannelPin(ChannelPin channelPin);

  @Query('delete FROM ChannelPin WHERE channel=:channelid')
  Future<void> remove(String channelid);
}

@dao
abstract class IChannelOutputPersonDAO {
  @Query(
      'SELECT *  FROM ChannelOutputPerson WHERE channel=:channelid  LIMIT :limit OFFSET  :offset')
  Future<List<ChannelOutputPerson>> pageOutputPerson(
      String channelid, int limit, int offset);

  @Query('SELECT *  FROM ChannelOutputPerson WHERE channel=:channelid')
  Future<List<ChannelOutputPerson>> listOutputPerson(String channelid);

  @Query(
      'delete FROM ChannelOutputPerson WHERE person=:person AND channel = :channelid')
  Future<void> removeOutputPerson(String person, String channelid);

  @insert
  Future<void> addOutputPerson(ChannelOutputPerson person);

  @Query(
      'select * FROM ChannelOutputPerson WHERE person=:person AND channel = :channelid LIMIT 1 OFFSET 0')
  Future<ChannelOutputPerson> getOutputPerson(String person, String channelid);
  @Query(
      'delete FROM ChannelOutputPerson WHERE channel = :channelid')
  Future<void> emptyOutputPersons(String channelid) ;

}

@dao
abstract class IChannelInputPersonDAO {
  @Query(
      'SELECT *  FROM ChannelInputPerson WHERE channel=:channelid  LIMIT :limit OFFSET  :offset')
  Future<List<ChannelInputPerson>> pageInputPerson(
      String channelid, int limit, int offset);

  @Query(
      'delete FROM ChannelInputPerson WHERE person=:person AND channel = :channelid')
  Future<void> removeInputPerson(String person, String channelid);

  @insert
  Future<void> addInputPerson(ChannelInputPerson person);

  @Query(
      'select * FROM ChannelInputPerson WHERE person=:person AND channel = :channelid LIMIT 1 OFFSET 0')
  Future<ChannelInputPerson> getInputPerson(String person, String channelid);
}
