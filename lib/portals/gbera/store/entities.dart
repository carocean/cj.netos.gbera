import 'package:floor/floor.dart';

@entity
class Person{
  @primaryKey
  final String uid;
  final String accountid;
  final String accountName;
  final String appid;
  final String tenantid;
  final  String avatar;

  Person(this.uid, this.accountid, this.accountName, this.appid, this.tenantid,this.avatar);
}