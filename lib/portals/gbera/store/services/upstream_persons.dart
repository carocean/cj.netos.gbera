import 'package:flutter/cupertino.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/dao/database.dart';
import 'package:gbera/portals/gbera/store/entities.dart';

import '../dao/daos.dart';
import '../services.dart';

class UpstreamPersonService implements IUpstreamPersonService {
  IUpstreamPersonDAO upstreamPersonDAO;

  UpstreamPersonService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      upstreamPersonDAO = db.upstreamPersonDAO;
    });
  }

  @override
  Future<UpstreamPerson> getPerson(id) async{
    return await this.upstreamPersonDAO.getPerson(id);
  }

  @override
  Future<List<UpstreamPerson>> getAllPerson() async{
    return await this.upstreamPersonDAO.getAllPerson();
  }

  @override
  Future<void> addPerson(UpstreamPerson person) async {
    await upstreamPersonDAO.addPerson(person);
  }

  @override
  Future<void> empty() async {
    await this.upstreamPersonDAO.empty();
  }

  @override
  Future<bool> existsPerson(id) async {
    var person = await upstreamPersonDAO.getPerson(id);
    return person == null ? false : true;
  }
}
