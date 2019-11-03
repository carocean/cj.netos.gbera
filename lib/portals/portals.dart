import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/gbera_portal.dart' as gberaPortal;
import 'package:gbera/portals/mybusiness/mybusiness_portal.dart' as mybusiness;
///引用函数形式无法使用hot reload即时生效，添加新页后需hot restart，因此改用使用类来定义portal
List<BuildPortal> buildPortals(IServiceProvider site) {
  return <BuildPortal>[
    gberaPortal.GberaPortal().buildPortal,
    mybusiness.buildPortal,
  ];
}
