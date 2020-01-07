import 'package:floor/floor.dart';

@entity
class UpstreamPerson{
  @primaryKey
  final String id;
  final String uid;
  final String accountid;
  final String accountName;
  final String appid;
  final String tenantid;
  final  String avatar;

  UpstreamPerson(this.id,this.uid, this.accountid, this.accountName, this.appid, this.tenantid,this.avatar);
}
@entity
class DownstreamPerson{
  @primaryKey
  final String id;
  final String uid;
  final String accountid;
  final String accountName;
  final String appid;
  final String tenantid;
  final  String avatar;

  DownstreamPerson(this.id,this.uid, this.accountid, this.accountName, this.appid, this.tenantid,this.avatar);
}
@entity
class MicroSite{
  @primaryKey
  final String id;
  final String name;
  final String leading;
  final String desc;

  MicroSite(this.id, this.name, this.leading, this.desc);
}
@entity
class MicroApp{
  @primaryKey
  final String id;
  final String site;
  final String leading;

  MicroApp(this.id, this.site, this.leading);
}
@entity
class ExternalChannel{
  @primaryKey
  final String id;
  final String name;
  final String owner;
  final String isPublic;
  final String leading;
  final String site;

  ExternalChannel(
      this.id, this.name, this.owner, this.isPublic, this.leading, this.site);
}
@entity
class InsiteMessage{
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
      this.wy);
}
@entity
class ChannelMessage{
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
      this.wy);
}
@entity
class likePerson {
  @primaryKey
  final String id;
  final String person;
  final String uid;
  final String avatar;
  final String msgid;

  likePerson(this.id, this.person, this.uid, this.avatar, this.msgid);
}
@entity
class Comment {
  @primaryKey
  final String id;
  final String person;
  final String uid;
  final String avatar;
  final String msgid;
  final String text;
  final int ctime;

  Comment(this.id, this.person, this.uid, this.avatar, this.msgid, this.text,
      this.ctime);
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
class MyChannel{
  @primaryKey
  final String id;
  final String name;
  final String owner;
  final bool isPublic;
  final String leading;
  final String site;

  MyChannel(
      this.id, this.name, this.owner, this.isPublic, this.leading, this.site);
}
@entity
class ChannelInput{
  @primaryKey
  final String id;
  final String fromChannel;
  final String fromPerson;
  final String toChannel;

  ChannelInput(this.id, this.fromChannel, this.fromPerson, this.toChannel);
}
@entity
class ChannelOutput{
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
class ChannelOutputPerson{
  @primaryKey
  final String id;
  final String fromChannel;
  final String toPerson;

  ChannelOutputPerson(this.id, this.fromChannel, this.toPerson);
}