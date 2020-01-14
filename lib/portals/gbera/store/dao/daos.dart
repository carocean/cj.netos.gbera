import 'dart:html';

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
      'SELECT msg.*  FROM InsiteMessage msg,Channel ch  WHERE msg.upstreamChannel=ch.id AND ch.loopType=:loopType LIMIT :pageSize OFFSET :currPage')
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

  @Query('SELECT *  FROM ChannelMessage LIMIT :pageSize OFFSET :currPage')
  Future<List<ChannelMessage>> pageMessage(int pageSize, int currPage);

  @Query(
      'SELECT msg.*  FROM ChannelMessage msg,Channel ch  WHERE msg.upstreamChannel=ch.id AND ch.loopType=:loopType LIMIT :pageSize OFFSET :currPage')
  Future<List<ChannelMessage>> pageMessageByChannelLoopType(
      String loopType, int limit, int offset);

  @Query('SELECT * FROM ChannelMessage WHERE id = :id')
  Future<ChannelMessage> getMessage(String id);

  @Query('SELECT * FROM ChannelMessage')
  Future<List<ChannelMessage>> getAllMessage();

  @Query('delete FROM ChannelMessage')
  Future<void> empty();
}

@dao
abstract class IChannelMediaDAO {
  @insert
  Future<void> addMedia(Media media);

  @Query('delete FROM Media WHERE id = :id')
  Future<void> removeMedia(String id);

  @Query('SELECT *  FROM Media LIMIT :pageSize OFFSET  :currPage')
  Future<List<MicroApp>> pageMedia(int pageSize, int currPage);

  @Query('SELECT * FROM Media WHERE id = :id')
  Future<MicroApp> getMedia(String id);

  @Query('SELECT * FROM Media')
  Future<List<MicroApp>> getAllMedia();
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

}
