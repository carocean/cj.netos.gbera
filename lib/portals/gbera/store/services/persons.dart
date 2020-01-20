import 'package:flutter/cupertino.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/dao/database.dart';
import 'package:gbera/portals/gbera/store/entities.dart';

import '../dao/daos.dart';
import '../services.dart';

class PersonService implements IPersonService {
  IPersonDAO personDAO;

  PersonService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      personDAO = db.upstreamPersonDAO;
    });
  }

  @override
  Future<int> count() async {
    var list = await this.personDAO.countPersons();
    return list.length;
  }


  @override
  Future<Person> getPerson(id) async {
    return await this.personDAO.getPerson(id);
  }

  @override
  Future<Person> getPersonByUID(String uid) async{
    return await this.personDAO.getPersonByUID(uid);
  }

  @override
  Future<Person> getPersonFullName(String p) async{
    int pos=p.indexOf('@');
    String accountName=p.substring(0,pos);
    String remain=p.substring(pos+1,p.length);
    pos=remain.lastIndexOf('.');
    String appid=remain.substring(0,pos);
    String tenantid=remain.substring(pos+1,remain.length);
    return await personDAO.findPerson(accountName,appid,tenantid);
  }

  @override
  Future<List<Person>> getAllPerson() async {
    return await this.personDAO.getAllPerson();
  }

  @override
  Future<List<Person>> pagePerson(int limit, int offset) async {
    return await this.personDAO.pagePerson(limit, offset);
  }

  @override
  Future<List<Person>> listPersonWith(List<String> personList) async{
    List<String> ids=[];
    for(String p in personList) {
      int pos=p.indexOf('@');
      String accountName=p.substring(0,pos);
      String remain=p.substring(pos+1,p.length);
      pos=remain.lastIndexOf('.');
      String appid=remain.substring(0,pos);
      String tenantid=remain.substring(pos+1,remain.length);
      Person person=await personDAO.findPerson(accountName,appid,tenantid);
      if(person==null) {
        continue;
      }
      ids.add(person.id);
    }
    return await this.personDAO.listPersonWith(ids);
  }

  @override
  Future<List<Person>> pagePersonWithout(
      List<String> personList, int persons_limit, int persons_offset) async{
    List<String> ids=[];
    for(String p in personList) {
      int pos=p.indexOf('@');
      String accountName=p.substring(0,pos);
      String remain=p.substring(pos+1,p.length);
      pos=remain.lastIndexOf('.');
      String appid=remain.substring(0,pos);
      String tenantid=remain.substring(pos+1,remain.length);
      Person person=await personDAO.findPerson(accountName,appid,tenantid);
      if(person==null) {
        continue;
      }
      ids.add(person.id);
    }
    return await this.personDAO.pagePersonWithout(ids,persons_limit,persons_offset);
  }

  @override
  Future<void> addPerson(Person person) async {
    await personDAO.addPerson(person);
  }

  @override
  Future<void> empty() async {
    await this.personDAO.empty();
  }

  @override
  Future<bool> existsPerson(id) async {
    var person = await personDAO.getPerson(id);
    return person == null ? false : true;
  }
}
