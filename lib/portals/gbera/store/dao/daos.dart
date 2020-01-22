import 'package:floor/floor.dart';

import '../entities.dart';

@dao
abstract class IPersonDAO {
  @insert
  Future<void> addPerson(Person person);

  @Query('delete FROM Person WHERE official = :official AND sandbox=:sandbox')
  Future<void> removePerson(String official,String sandbox);

  @Query('delete FROM Person where sandbox=:sandbox')
  Future<void> empty(String sandbox);

  @Query('SELECT *  FROM Person where sandbox=:sandbox LIMIT :pageSize OFFSET  :currPage')
  Future<List<Person>> pagePerson(String sandbox,int pageSize, int currPage);

  @Query('SELECT * FROM Person WHERE official = :official and sandbox=:sandbox')
  Future<Person> getPerson(String official,String sandbox);

  @Query('SELECT * FROM Person where sandbox=:sandbox')
  Future<List<Person>> getAllPerson(String sandbox);

  @Query("SELECT * FROM Person where sandbox=:sandbox")
  Future<List<Person>> countPersons(String sandbox);

  @Query(
      'SELECT *  FROM Person where sandbox=:sandbox and official NOT IN (:officials) LIMIT :persons_limit OFFSET  :persons_offset')
  Future<List<Person>> pagePersonWithout(String sandbox,
      List<String> officials, int persons_limit, int persons_offset);

  @Query("SELECT *  FROM Person where sandbox=:sandbox and official IN (:officials)")
  Future<List<Person>> listPersonWith(String sandbox,List<String> officials);

  @Query(
      'SELECT * FROM Person WHERE sandbox=:sandbox and accountName = :accountName and appid=:appid and tenantid=:tenantid LIMIT 1 OFFSET 0')
  Future<Person> findPerson(String sandbox,String accountName, String appid, String tenantid);

  @Query('SELECT * FROM Person WHERE sandbox =:sandbox and uid = :uid LIMIT 1 OFFSET 0')
  Future<Person> getPersonByUID(String sandbox,String uid) {}
}

@dao
abstract class IChannelDAO {
  @insert
  Future<void> addChannel(Channel channel);

  @Query('delete FROM Channel WHERE sandbox=:sandbox and code = :code')
  Future<void> removeChannel(String sandbox,String code);

  @Query('SELECT *  FROM Channel where sandbox=:sandbox LIMIT :pageSize OFFSET  :currPage')
  Future<List<Channel>> pageChannel(String sandbox ,int pageSize, int currPage);

  @Query('SELECT * FROM Channel WHERE sandbox=:sandbox and code = :code')
  Future<Channel> getChannel(String sandbox,String code);

  @Query('SELECT * FROM Channel where sandbox=:sandbox ORDER BY utime DESC,ctime DESC')
  Future<List<Channel>> getAllChannel(String sandbox);

  @Query('delete FROM Channel where sandbox=:sandbox')
  Future<void> empty(String sandbox);

  @Query('delete FROM Channel WHERE sandbox=:sandbox and owner = :person')
  Future<void> emptyOfPerson(String sandbox,String person);

  @Query('SELECT * FROM Channel WHERE sandbox=:sandbox owner = :person')
  Future<List<Channel>> getChannelsOfPerson(String sandbox,String person);

  @Query('SELECT * FROM Channel WHERE sandbox=:sandbox and name = :channelName AND owner = :owner')
  Future<Channel> getChannelByName(String sandbox,String channelName, String owner);

  @Query('UPDATE Channel SET leading = :path WHERE sandbox=:sandbox and code = :code')
  Future<void> updateLeading(String path,String sandbox, String code);

  @Query('UPDATE Channel SET name = :name WHERE code = :code and sandbox=:sandbox')
  Future<void> updateName(String name, String code,String sandbox);
}

@dao
abstract class IInsiteMessageDAO {
  @insert
  Future<void> addMessage(InsiteMessage message);

  @Query('delete FROM InsiteMessage WHERE id = :id and sandbox=:sandbox')
  Future<void> removeMessage(String id,String sandbox);

  @Query('SELECT *  FROM InsiteMessage where sandbox=:sandbox LIMIT :pageSize OFFSET :currPage')
  Future<List<InsiteMessage>> pageMessage(String sandbox,int pageSize, int currPage);

  @Query(
      'SELECT msg.*  FROM InsiteMessage msg,Channel ch  WHERE msg.onChannel=ch.code AND ch.loopType=:loopType and msg.sandbox=:sandbox LIMIT :pageSize OFFSET :currPage')
  Future<List<InsiteMessage>> pageMessageByChannelLoopType(
      String loopType,String sandbox, int limit, int offset);

  @Query('SELECT * FROM InsiteMessage WHERE id = :id and sandbox=:sandbox')
  Future<InsiteMessage> getMessage(String id,String sandbox);

  @Query('SELECT * FROM InsiteMessage where sandbox=:sandbox')
  Future<List<InsiteMessage>> getAllMessage(String sandbox);

  @Query('delete FROM InsiteMessage where sandbox=:sandbox')
  Future<void> empty(String sandbox);
}

@dao
abstract class IMicroSiteDAO {
  @insert
  Future<void> addSite(MicroSite site);

  @Query('delete FROM MicroSite WHERE id = :id and sandbox=:sandbox')
  Future<void> removeSite(String id,String sandbox);

  @Query('SELECT *  FROM MicroSite where sandbox=:sandbox LIMIT :pageSize OFFSET  :currPage')
  Future<List<MicroSite>> pageSite(String sandbox,int pageSize, int currPage);

  @Query('SELECT * FROM MicroSite WHERE sandbox=:sandbox and id = :id')
  Future<MicroSite> getSite(String sandbox,String id);

  @Query('SELECT * FROM MicroSite where sandbox=:sandbox')
  Future<List<MicroSite>> getAllSite(String sandbox);
}

@dao
abstract class IMicroAppDAO {
  @insert
  Future<void> addApp(MicroApp site);

  @Query('delete FROM MicroApp WHERE sandbox=:sandbox and id = :id')
  Future<void> removeApp(String sandbox,String id);

  @Query('SELECT *  FROM MicroApp where sandbox=:sandbox LIMIT :pageSize OFFSET  :currPage')
  Future<List<MicroApp>> pageApp(String sandbox,int pageSize, int currPage);

  @Query('SELECT * FROM MicroApp WHERE sandbox=:sandbox and id = :id')
  Future<MicroApp> getApp(String sandbox,String id);

  @Query('SELECT * FROM MicroApp where sandbox=:sandbox')
  Future<List<MicroApp>> getAllApp(String sandbox);
}

@dao
abstract class IChannelMessageDAO {
  @insert
  Future<void> addMessage(ChannelMessage message);

  @Query('delete FROM ChannelMessage WHERE id = :id and sandbox=:sandbox')
  Future<void> removeMessage(String id,String sandbox);

  @Query(
      'SELECT *  FROM ChannelMessage WHERE onChannel = :onChannel and sandbox=:sandbox ORDER BY ctime DESC  LIMIT :pageSize OFFSET :currPage')
  Future<List<ChannelMessage>> pageMessage(
      String onChannel,String sandbox, int pageSize, int currPage);

  @Query(
      'SELECT msg.*  FROM ChannelMessage msg,Channel ch  WHERE msg.onChannel=ch.code AND ch.loopType=:loopType and msg.sandbox=:sandbox LIMIT :pageSize OFFSET :currPage')
  Future<List<ChannelMessage>> pageMessageByChannelLoopType(
      String loopType, String sandbox,int limit, int offset);

  @Query(
      'SELECT msg.*  FROM ChannelMessage msg  WHERE msg.onChannel=:onChannel  AND msg.creator=:person  and msg.sandbox=:sandbox ORDER BY ctime DESC LIMIT :limit OFFSET :offset')
  Future<List<ChannelMessage>> pageMessageBy(
    String onchannel,
    String person,
    String sandbox,
    int limit,
    int offset,
  );

  @Query('SELECT * FROM ChannelMessage WHERE id = :id and sandbox=:sandbox')
  Future<ChannelMessage> getMessage(String id,String sandbox);

  @Query('SELECT * FROM ChannelMessage where sandbox=:sandbox')
  Future<List<ChannelMessage>> getAllMessage(String sandbox);

  @Query('delete FROM ChannelMessage where sandbox=:sandbox')
  Future<void> empty(String sandbox);

  @Query('delete FROM ChannelMessage where onChannel=:channelcode and sandbox=:sandbox')
  Future<void> removeMessagesBy(String channelcode,String sandbox) {}
}

@dao
abstract class IChannelMediaDAO {
  @insert
  Future<void> addMedia(Media media);

  @Query('delete FROM Media WHERE id = :id and sandbox=:sandbox')
  Future<void> removeMedia(String id,String sandbox);

  @Query('SELECT *  FROM Media where sandbox=:sandbox LIMIT :pageSize OFFSET  :currPage')
  Future<List<Media>> pageMedia(String sandbox,int pageSize, int currPage);

  @Query('SELECT * FROM Media WHERE id = :id and sandbox=:sandbox')
  Future<Media> getMedia(String id,String sandbox);

  @Query('SELECT * FROM Media where sandbox=:sandbox')
  Future<List<Media>> getAllMedia(String sandbox);

  @Query('SELECT * FROM Media WHERE msgid = :msgid and sandbox=:sandbox')
  Future<List<Media>> getMediaByMsgId(String msgid,String sandbox);

  @Query('SELECT * FROM Media WHERE onChannel = :channelcode and sandbox=:sandbox')
  Future<List<Media>> getMediaBychannelcode(String channelcode,String sandbox);
}

@dao
abstract class IChannelLikePersonDAO {
  @insert
  Future<void> addLikePerson(LikePerson likePerson);

  @Query('delete FROM LikePerson WHERE id = :id and sandbox=:sandbox')
  Future<void> removeLikePerson(String id,String sandbox);

  @Query('SELECT *  FROM LikePerson where sandbox=:sandbox LIMIT :pageSize OFFSET  :currPage')
  Future<List<LikePerson>> pageLikePerson(String sandbox,int pageSize, int currPage);

  @Query('SELECT * FROM LikePerson WHERE id = :id and sandbox=:sandbox')
  Future<LikePerson> getLikePerson(String id,String sandbox);

  @Query('SELECT * FROM LikePerson where sandbox=:sandbox')
  Future<List<LikePerson>> getAllLikePerson(String sandbox);

  @Query('SELECT * FROM LikePerson WHERE msgid = :msgid AND person=:person and sandbox=:sandbox')
  Future<List<LikePerson>> getLikePersonBy(String msgid, String person,String sandbox);

  @Query('delete FROM LikePerson WHERE msgid = :msgid AND person=:person and sandbox=:sandbox')
  Future<void> removeLikePersonBy(String msgid, String person,String sandbox);

  @Query(
      'SELECT *  FROM LikePerson WHERE msgid=:msgid and sandbox=:sandbox  LIMIT :pageSize OFFSET  :offset')
  Future<List<LikePerson>> pageLikePersonBy(
      String msgid,String sandbox, int pageSize, int offset);

  @Query('delete FROM LikePerson WHERE onChannel = :channelcode and sandbox=:sandbox')
  Future<void> removeLikePersonByChannel(String channelcode,String sandbox);
}

@dao
abstract class IChannelCommentDAO {
  @insert
  Future<void> addComment(ChannelComment comment);

  @Query('delete FROM ChannelComment WHERE id = :id and sandbox=:sandbox')
  Future<void> removeComment(String id,String sandbox);

  @Query('SELECT *  FROM ChannelComment where sandbox=:sandbox LIMIT :pageSize OFFSET  :currPage')
  Future<List<ChannelComment>> pageComment(String sandbox,int pageSize, int currPage);

  @Query('SELECT * FROM ChannelComment WHERE id = :id and sandbox=:sandbox')
  Future<ChannelComment> getComment(String id,String sandbox);

  @Query('SELECT * FROM ChannelComment where sandbox=:sandbox')
  Future<List<ChannelComment>> getAllComment(String sandbox);

  @Query(
      'SELECT *  FROM ChannelComment WHERE msgid=:msgid  and sandbox=:sandbox LIMIT :pageSize OFFSET  :offset')
  Future<List<ChannelComment>> pageLikeCommentBy(
      String msgid, String sandbox,int pageSize, int offset) {}

  @Query('delete FROM ChannelComment WHERE onChannel = :channelcode and sandbox=:sandbox')
  Future<void> removeCommentBy(String channelcode,String sandbox);
}

@dao
abstract class IChannelPinDAO {
  @Query(
      'UPDATE ChannelPin SET outPersonSelector = :selector WHERE channel = :channelcode and sandbox=:sandbox')
  Future<void> setOutputPersonSelector(selector, String channelcode,String sandbox);

  @Query(
      'UPDATE ChannelPin SET outGeoSelector = :isset WHERE channel = :channelcode and sandbox=:sandbox')
  Future<void> setOutputGeoSelector(String isset, String channelcode,String sandbox);

  @Query('SELECT *  FROM ChannelPin WHERE channel=:channelcode and sandbox=:sandbox')
  Future<ChannelPin> getChannelPin(String channelcode,String sandbox);

  @insert
  Future<void> addChannelPin(ChannelPin channelPin);

  @Query('delete FROM ChannelPin WHERE channel=:channelcode and sandbox=:sandbox')
  Future<void> remove(String channelcode,String sandbox);
}

@dao
abstract class IChannelOutputPersonDAO {
  @Query(
      'SELECT *  FROM ChannelOutputPerson WHERE channel=:channelcode and sandbox=:sandbox  LIMIT :limit OFFSET  :offset')
  Future<List<ChannelOutputPerson>> pageOutputPerson(
      String channelcode,String sandbox, int limit, int offset);

  @Query('SELECT *  FROM ChannelOutputPerson WHERE channel=:channelcode and sandbox=:sandbox')
  Future<List<ChannelOutputPerson>> listOutputPerson(String channelcode,String sandbox);

  @Query(
      'delete FROM ChannelOutputPerson WHERE person=:person AND channel = :channelcode and sandbox=:sandbox')
  Future<void> removeOutputPerson(String person, String channelcode,String sandbox);

  @insert
  Future<void> addOutputPerson(ChannelOutputPerson person);

  @Query(
      'select * FROM ChannelOutputPerson WHERE person=:person AND channel = :channelcode and sandbox=:sandbox LIMIT 1 OFFSET 0')
  Future<ChannelOutputPerson> getOutputPerson(String person, String channelcode,String sandbox);

  @Query('delete FROM ChannelOutputPerson WHERE channel = :channelcode and sandbox=:sandbox')
  Future<void> emptyOutputPersons(String channelcode,String sandbox);
}

@dao
abstract class IChannelInputPersonDAO {
  @Query(
      'SELECT *  FROM ChannelInputPerson WHERE channel=:channelcode and sandbox=:sandbox LIMIT :limit OFFSET  :offset')
  Future<List<ChannelInputPerson>> pageInputPerson(
      String channelcode, String sandbox,int limit, int offset);

  @Query(
      'delete FROM ChannelInputPerson WHERE person=:person AND channel = :channelcode and sandbox=:sandbox')
  Future<void> removeInputPerson(String person, String channelcode,String sandbox,);

  @insert
  Future<void> addInputPerson(ChannelInputPerson person);

  @Query(
      'select * FROM ChannelInputPerson WHERE person=:person AND channel = :channelcode and sandbox=:sandbox LIMIT 1 OFFSET 0')
  Future<ChannelInputPerson> getInputPerson(String person, String channelcode,String sandbox);

  @Query('SELECT *  FROM ChannelInputPerson WHERE channel=:channelcode and sandbox=:sandbox')
  Future<List<ChannelInputPerson>> listInputPerson(String channelcode,String sandbox) ;
}
