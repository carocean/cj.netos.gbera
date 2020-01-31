import 'package:flutter/cupertino.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/dao/database.dart';
import 'package:gbera/portals/gbera/store/entities.dart';

import '../dao/daos.dart';
import '../services.dart';

class PersonService implements IPersonService {
  IPersonDAO personDAO;
  Environment env;
  PersonService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      personDAO = db.upstreamPersonDAO;
      env=site.getService('@.environment');
    });
  }

  @override
  Future<int> count() async {
    var list = await this.personDAO.countPersons(env?.userPrincipal?.person);
    return list.length;
  }


  @override
  Future<Person> getPerson(official) async {
    return await this.personDAO.getPerson(official,env?.userPrincipal?.person);
  }

  @override
  Future<Person> getPersonByUID(String uid) async{
    return await this.personDAO.getPersonByUID(env?.userPrincipal?.person,uid);
  }

  @override
  Future<Person> getPersonFullName(String p) async{
    int pos=p.indexOf('@');
    String accountName=p.substring(0,pos);
    String remain=p.substring(pos+1,p.length);
    pos=remain.lastIndexOf('.');
    String appid=remain.substring(0,pos);
    String tenantid=remain.substring(pos+1,remain.length);
    return await personDAO.findPerson(env?.userPrincipal?.person,accountName,appid,tenantid);
  }

  @override
  Future<List<Person>> getAllPerson() async {
    return await this.personDAO.getAllPerson(env?.userPrincipal?.person);
  }

  @override
  Future<List<Person>> pagePersonLikeName(String name, int limit, int offset) async {
    return await this.personDAO.pagePersonLikeName(env?.userPrincipal?.person,name,name,name,limit,offset);
  }

  @override
  Future<List<Person>> pagePerson(int limit, int offset) async {
    return await this.personDAO.pagePerson(env?.userPrincipal?.person,limit, offset);
  }

  @override
  Future<List<Person>> listPersonWith(List<String> personList) async{
    List<String> officials=[];
    for(String p in personList) {
      int pos=p.indexOf('@');
      String accountName=p.substring(0,pos);
      String remain=p.substring(pos+1,p.length);
      pos=remain.lastIndexOf('.');
      String appid=remain.substring(0,pos);
      String tenantid=remain.substring(pos+1,remain.length);
      Person person=await personDAO.findPerson(env?.userPrincipal?.person,accountName,appid,tenantid);
      if(person==null) {
        continue;
      }
      officials.add(person.official);
    }
    return await this.personDAO.listPersonWith(env?.userPrincipal?.person,officials);
  }

  @override
  Future<List<Person>> pagePersonWithout(
      List<String> personList, int persons_limit, int persons_offset) async{
    List<String> officials=[];
    for(String p in personList) {
      int pos=p.indexOf('@');
      String accountName=p.substring(0,pos);
      String remain=p.substring(pos+1,p.length);
      pos=remain.lastIndexOf('.');
      String appid=remain.substring(0,pos);
      String tenantid=remain.substring(pos+1,remain.length);
      Person person=await personDAO.findPerson(env?.userPrincipal?.person,accountName,appid,tenantid);
      if(person==null) {
        continue;
      }
      officials.add(person.official);
    }
    return await this.personDAO.pagePersonWithout(env?.userPrincipal?.person,officials,persons_limit,persons_offset);
  }

  @override
  Future<void> addPerson(Person person) async {
    await personDAO.addPerson(person);
  }

  @override
  Future<void> empty() async {
    await this.personDAO.empty(env?.userPrincipal?.person);
  }

  @override
  Future<bool> existsPerson(official) async {
    var person = await personDAO.getPerson(official,env?.userPrincipal?.person);
    return person == null ? false : true;
  }
}
