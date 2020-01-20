import 'package:floor/floor.dart';

@entity
class Person {
  @primaryKey
  final String id;
  final String uid;
  final String accountid;
  final String accountName;
  final String appid;
  final String tenantid;
  final String avatar;
  final String rights;
  final String nickName;
  final String signature;

  Person(this.id, this.uid, this.accountid, this.accountName, this.appid,
      this.tenantid, this.avatar, this.rights, this.nickName, this.signature);
}

@entity
class MicroSite {
  @primaryKey
  final String id;
  final String name;
  final String leading;
  final String desc;

  MicroSite(this.id, this.name, this.leading, this.desc);
}

@entity
class MicroApp {
  @primaryKey
  final String id;
  final String site;
  final String leading;

  MicroApp(this.id, this.site, this.leading);
}

@entity
class Channel {
  @primaryKey
  final String id;
  final String name;
  final String owner;
  final String loopType;
  final String leading;
  final String site;
  final String tips;
  int ctime = DateTime.now().millisecondsSinceEpoch;
  int utime = DateTime.now().millisecondsSinceEpoch;
  int unreadMsgCount = 0;

  Channel(this.id, this.name, this.owner, this.loopType, this.leading,
      this.site, this.tips, this.ctime, this.utime, this.unreadMsgCount);
}

@entity
class InsiteMessage {
  @primaryKey
  final String id;
  final String upstreamPerson;
  final String sourceSite;
  final String sourceApp;
  final String onChannel;
  final String creator;
  final int ctime;
  final String digests;
  final double wy;
  final String location;

  InsiteMessage(
    this.id,
    this.upstreamPerson,
    this.sourceSite,
    this.sourceApp,
    this.onChannel,
    this.creator,
    this.ctime,
    this.digests,
    this.wy,
    this.location,
  );
}

@entity
class ChannelMessage {
  @primaryKey
  final String id;
  final String upstreamPerson;
  final String sourceSite;
  final String sourceApp;
  final String onChannel;
  final String creator;
  final int ctime;
  final String text;
  final double wy;
  final String location;

  ChannelMessage(
    this.id,
    this.upstreamPerson,
    this.sourceSite,
    this.sourceApp,
    this.onChannel,
    this.creator,
    this.ctime,
    this.text,
    this.wy,
    this.location,
  );
}

@entity
class LikePerson {
  @primaryKey
  final String id;
  final String person;
  final String avatar;
  final String msgid;
  final int ctime;
  final String nickName;
  final String onChannel;

  LikePerson(this.id, this.person, this.avatar, this.msgid, this.ctime,
      this.nickName, this.onChannel);
}

@entity
class ChannelComment {
  @primaryKey
  final String id;
  final String person;
  final String avatar;
  final String msgid;
  final String text;
  final int ctime;
  final String nickName;
  final String onChannel;

  ChannelComment(this.id, this.person, this.avatar, this.msgid, this.text,
      this.ctime, this.nickName, this.onChannel);
}

@entity
class Media {
  @primaryKey
  final String id;
  final String type;
  final String src;
  final String leading;
  final String msgid;
  final String text;
  final String onChannel;

  Media(this.id, this.type, this.src, this.leading, this.msgid, this.text,
      this.onChannel);
}

@entity
class ChannelPin {
  @primaryKey
  final String id;
  final String channel;
  final String inPersonSelector;
  final String outPersonSelector;
  final String outGeoSelector;
  final String outWechatPenYouSelector;
  final String outWechatHaoYouSelector;
  final String outContractSelector;
  final String inRights;
  final String outRights;

  ChannelPin(
      this.id,
      this.channel,
      this.inPersonSelector,
      this.outPersonSelector,
      this.outGeoSelector,
      this.outWechatPenYouSelector,
      this.outWechatHaoYouSelector,
      this.outContractSelector,
      this.inRights,
      this.outRights);
}

@entity
class ChannelInputPerson {
  @primaryKey
  final String id;
  final String person;
  final String channel;

  ChannelInputPerson(
    this.id,
    this.person,
    this.channel,
  );
}

@entity
class ChannelOutputPerson {
  @primaryKey
  final String id;
  final String channel;
  final String person;

  ChannelOutputPerson(this.id, this.channel, this.person);
}

enum OutsitePersonsSettingStrategy {
  only_select,
  all_except,
}