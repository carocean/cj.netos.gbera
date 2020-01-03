import 'package:floor/floor.dart';

import '../entities.dart';

@dao
abstract class IUpstreamPersonDAO{
  @insert
  Future<void> addPerson(Person person);
  @Query('delete FROM Person WHERE uid = :uid')
  Future<void> removePerson(String uid);
  @Query('SELECT *  FROM Person LIMIT :currPage, :pageSize')
  Future<List<Person>> pagePerson(int currPage,int pageSize);
  @Query('SELECT * FROM Person WHERE uid = :uid')
  Future<Person> getPerson(String uid);
  @Query('SELECT * FROM Person')
  Future<List<Person>> getAllPerson();

}