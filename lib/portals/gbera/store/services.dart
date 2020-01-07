import 'package:gbera/portals/gbera/store/entities.dart';

mixin IUpstreamPersonService {
  Future<void> empty();

  Future<bool> existsPerson(id);

  Future<UpstreamPerson> getPerson(id);

  Future<void> addPerson(UpstreamPerson person);

  Future<List<UpstreamPerson>> getAllPerson();

  Future<List<UpstreamPerson>> pagePerson(int limit, int offset);

  Future<int> count();
}
mixin IExternalChannelService {
  Future<void> empty();

  Future<void> emptyOfPerson(String personid);

  Future<bool> existsChannel(channelid);

  Future<void> addChannel(ExternalChannel channel);

  Future<List<ExternalChannel>> getChannelsOfPerson(String personid);

  Future<ExternalChannel> getChannel(String channelid);
}
mixin IInsiteMessageService {
  Future<void> empty();

  Future<bool> existsMessage(id);

  Future<void> addMessage(InsiteMessage message);

  Future<List<InsiteMessage>> pageMessage(int pageSize, int currPage);

  Future<List<InsiteMessage>> getAllMessage();

  Future<List<InsiteMessage>> pageMessageByChannelVisualable(
      int limit, int offset, String isPublic);
}
