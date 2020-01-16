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
  Future<List<Person>> getAllPerson() async {
    return await this.personDAO.getAllPerson();
  }

  @override
  Future<List<Person>> pagePerson(int limit, int offset) async {
    return await this.personDAO.pagePerson(limit, offset);
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
