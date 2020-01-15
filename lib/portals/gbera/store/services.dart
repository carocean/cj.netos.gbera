import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/entities.dart';

mixin IPersonService {
  Future<void> empty();

  Future<bool> existsPerson(id);

  Future<Person> getPerson(id);

  Future<void> addPerson(Person person);

  Future<List<Person>> getAllPerson();

  Future<List<Person>> pagePerson(int limit, int offset);

  Future<int> count();
}
mixin IChannelService {
  Future<void> init(UserPrincipal user);
  Future<void> empty();

  Future<void> emptyOfPerson(String personid);

  Future<bool> existsChannel(channelid);

  Future<void> addChannel(Channel channel);

  Future<List<Channel>> getChannelsOfPerson(String personid);

  Future<Channel> getChannel(String channelid);

  Future<bool> existsName(String channelName,String owner) ;

  Future<List<Channel>>  getAllChannel() ;

  Future<void> updateLeading(String path,String channelid) ;


}
mixin IInsiteMessageService {
  Future<void> empty();

  Future<bool> existsMessage(id);

  Future<void> addMessage(InsiteMessage message);

  Future<List<InsiteMessage>> pageMessage(int pageSize, int currPage);

  Future<List<InsiteMessage>> getAllMessage();

  Future<List<InsiteMessage>> pageMessageByChannelVisualable(
      int limit, int offset, String loopType);
}

mixin IChannelMessageService {
  Future<void> empty();

  Future<bool> existsMessage(id);

  Future<void> addMessage(ChannelMessage message);

  Future<List<ChannelMessage>> pageMessage(int pageSize, int currPage,String onChannel);

  Future<List<ChannelMessage>> getAllMessage();

}
mixin IChannelMediaService {
  Future<void> addMedia(Media media);
}

mixin IChannelLikeService {}

mixin IChannelCommentService {}