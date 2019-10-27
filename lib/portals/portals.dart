import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/gbera_portal.dart' as gberaPortal;
import 'package:gbera/portals/mybusiness/mybusiness_portal.dart' as mybusiness;

List<BuildPortal> buildPortals(IServiceProvider site) {
  return <BuildPortal>[
    gberaPortal.buildPortal,
    mybusiness.buildPortal,
  ];
}
