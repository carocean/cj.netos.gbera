import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/dao/database.dart';

import '../dao/daos.dart';

class UpstreamPersonService{
  IUpstreamPersonDAO upstreamPersonDAO;
  UpstreamPersonService({ServiceSite site}){
    site.onready=(){
      AppDatabase db=site.database;
      upstreamPersonDAO=db.upstreamPersonDAO;
    };
  }
}