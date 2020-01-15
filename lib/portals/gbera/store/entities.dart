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

  Person(this.id, this.uid, this.accountid, this.accountName, this.appid,
      this.tenantid, this.avatar, this.rights);
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
  final String upstreamChannel;
  final String sourceSite;
  final String sourceApp;
  final String sourceChannel;
  final String creator;
  final int ctime;
  final String digests;
  final double wy;
  final String location;

  InsiteMessage(
    this.id,
    this.upstreamPerson,
    this.upstreamChannel,
    this.sourceSite,
    this.sourceApp,
    this.sourceChannel,
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
  final String upstreamChannel;
  final String sourceSite;
  final String sourceApp;
  final String sourceChannel;
  final String creator;
  final int ctime;
  final String text;
  final double wy;
  final String location;
  final String onChannel;

  ChannelMessage(
    this.id,
    this.upstreamPerson,
    this.upstreamChannel,
    this.sourceSite,
    this.sourceApp,
    this.sourceChannel,
    this.creator,
    this.ctime,
    this.text,
    this.wy,
    this.location,
    this.onChannel,
  );
}

@entity
class LikePerson {
  @primaryKey
  final String id;
  final String person;
  final String uid;
  final String avatar;
  final String msgid;

  LikePerson(this.id, this.person, this.uid, this.avatar, this.msgid);
}

@entity
class ChannelComment {
  @primaryKey
  final String id;
  final String person;
  final String uid;
  final String avatar;
  final String msgid;
  final String text;
  final int ctime;

  ChannelComment(this.id, this.person, this.uid, this.avatar, this.msgid,
      this.text, this.ctime);
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

  Media(this.id, this.type, this.src, this.leading, this.msgid, this.text);
}

@entity
class ChannelInput {
  @primaryKey
  final String id;
  final String upstreamPerson;
  final String toChannel;
  final String rights;

  ChannelInput(this.id, this.upstreamPerson, this.toChannel, this.rights);
}

@entity
class ChannelOutput {
  @primaryKey
  final String id;
  final String geoSelector;
  final String wechatPenYouSelector;
  final String wechatHaoYouSelector;
  final String contractSelector;

  ChannelOutput(this.id, this.geoSelector, this.wechatPenYouSelector,
      this.wechatHaoYouSelector, this.contractSelector);
}

@entity
class ChannelOutputPerson {
  @primaryKey
  final String id;
  final String fromChannel;
  final String toPerson;
  final String rights;

  ChannelOutputPerson(this.id, this.fromChannel, this.toPerson, this.rights);
}
