
class MessageView {
  final String who;
  final String content;
  final String money;
  final int picCount;
  final String isPublic;
  final String time;
  final String channel;
  final Function() onTap;

  const MessageView({
    this.who,
    this.content,
    this.money,
    this.picCount,
    this.isPublic,
    this.time,
    this.channel,
    this.onTap,
  });
}
class MessageTabView {
  const MessageTabView({this.text, this.isPublic});

  final String text;
  final String isPublic;
}
