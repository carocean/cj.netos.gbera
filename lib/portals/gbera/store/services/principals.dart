import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/dao/daos.dart';
import 'package:gbera/portals/gbera/store/dao/database.dart';

import '../entities.dart';
import '../services.dart';

class PrincipalService implements IPrincipalService {
  IPrincipalDAO principalDAO;
  Environment env;

  PrincipalService({ServiceSite site}) {
    site.onready.add(() async{
      AppDatabase db = site.database;
      principalDAO = db.principalDAO;
      env = site.getService('@.environment');
    });
  }

  @override
  Future<List<Principal>> getAll() async {
    return await principalDAO.getAll();
  }

  @override
  Future<Principal> get(String person) async {
    return await principalDAO.get(person);
  }

  @override
  Future<Function> updateToken(String refreshToken, String accessToken, String person) async {
    await principalDAO.updateToken(refreshToken,accessToken, person);
  }

  @override
  Future<Function> remove(String person) async {
    await principalDAO.remove(person);
  }

  @override
  Future<Function> add(Principal principal) async {
    await principalDAO.add(principal);
  }
}
