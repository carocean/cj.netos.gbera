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

  Future<List<Person>> pagePersonWithout(
      List<String> personList, int persons_limit, int persons_offset);

  Future<List<Person>> listPersonWith(List<String> personList);

  Future<Person> getPersonByUID(String uid) ;

  Future<Person> getPersonFullName(String person);


}
mixin IChannelService {
  Future<void> init(UserPrincipal user);

  bool isSystemChannel(channelid);

  String getSystemChannel(String channelid);

  Iterable<String> listSystemChannel();

  Future<void> empty();

  Future<void> emptyOfPerson(String personid);

  Future<bool> existsChannel(channelid);

  Future<void> addChannel(Channel channel);

  Future<List<Channel>> getChannelsOfPerson(String personid);

  Future<Channel> getChannel(String channelid);

  Future<bool> existsName(String channelName, String owner);

  Future<List<Channel>> getAllChannel();

  Future<void> updateLeading(String path, String channelid);

  Future<void> remove(String channelid);

  Future<void> updateName(String channelid,String name) ;

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

  Future<List<ChannelMessage>> pageMessage(
      int pageSize, int currPage, String onChannel);

  Future<List<ChannelMessage>> getAllMessage();

  Future<void> removeMessage(String id);

  Future<void> emptyBy(String channelid);
}
mixin IChannelMediaService {
  Future<void> addMedia(Media media);

  Future<List<Media>> getMedias(String msgid);

  Future<void> remove(String id);

  Future<void> removeBy(String channelid);
}

mixin IChannelLikeService {
  Future<bool> isLiked(String msgid, String person);

  Future<void> like(LikePerson likePerson);

  Future<void> unlike(String msgid, String person);

  Future<List<LikePerson>> pageLikePersons(
      String msgid, int pageSize, int offset);

  Future<void> remove(String id);

  Future<void> removeBy(String channelid) {}
}

mixin IChannelCommentService {
  Future<List<ChannelComment>> pageComments(
      String msgid, int pageSize, int offset);

  Future<void> addComment(ChannelComment channelComment);

  Future<void> removeComment(String id);

  Future<void> removeBy(String channelid) {}
}
mixin IChannelPinService {
  Future<void> init(String channelid);

  Future<PinPersonsSettingsStrategy> getInputPersonSelector(String channelid);

  Future<PinPersonsSettingsStrategy> getOutputPersonSelector(String channelid);

  Future<void> setOutputPersonSelector(String channelid,
      PinPersonsSettingsStrategy outsitePersonsSettingStrategy);

  Future<bool> getOutputGeoSelector(String channelid);

  Future<void> setOutputGeoSelector(String channelid, bool isSet);

  Future<void> setOutputWechatCircleSelector(String channelid, bool isSet);

  Future<void> setOutputWechatHaoYouSelector(String channelid, bool isSet);

  Future<void> addInputPerson(ChannelInputPerson person);

  Future<void> removeInputPerson(String person, String channelid);

  Future<List<ChannelInputPerson>> pageInputPerson(
      String channelid, int limit, int offset);

  Future<void> addOutputPerson(ChannelOutputPerson person);

  Future<void> removeOutputPerson(String person, String channelid);

  Future<List<ChannelOutputPerson>> pageOutputPerson(
      String channelid, int limit, int offset);

  Future<void> removePin(String channelid);

  Future<List<ChannelOutputPerson>> listOutputPerson(String channelid);

  Future<List<ChannelInputPerson>> listInputPerson(String channelid);

  Future<void> emptyOutputPersons(String channelid);
}
