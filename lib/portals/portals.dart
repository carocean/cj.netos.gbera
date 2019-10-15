import 'package:flutter/widgets.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/pages/desktop.dart';
import 'package:gbera/portals/gbera/errors/errors.dart';
import 'package:gbera/portals/gbera/pages/geosphere.dart';
import 'package:gbera/portals/gbera/pages/market.dart';
import 'package:gbera/portals/gbera/pages/netflow.dart';
import 'package:gbera/portals/gbera/scaffolds.dart';

import 'common/icons.dart';
import 'gbera/login.dart';

List<BuildPortal> buildPortals(IServiceProvider site) {
  return <BuildPortal>[
    (IServiceProvider site) => Portal(
          id: 'gbera',
          icon: GalleryIcons.shrine,
          name: '金证时代官方框架',
          buildPages: (Portal portal, IServiceProvider site) => [
            Page(
              title: '出错啦',
              subtitle: '',
              icon: GalleryIcons.shrine,
              url: '/error',
              buildRoute: (PageContext pageContext) => GberaError(
                context: pageContext,
              ),
            ),
            Page(
              title: '金证时代',
              subtitle: '',
              icon: GalleryIcons.shrine,
              url: '/scaffold/withbottombar',
              buildRoute: (PageContext pageContext) => WithBottomScaffold(
                context: pageContext,
              ),
            ),
            Page(
              title: '登录',
              subtitle: '',
              icon: GalleryIcons.shrine,
              url: '/login',
              buildRoute: (PageContext pageContext) => LoginPage(
                context: pageContext,
              ),
            ),
            Page(
              title: '桌面',
              subtitle: '',
              icon: GalleryIcons.shrine,
              url: '/desktop',
              buildRoute: (PageContext pageContext) => Desktop(
                context: pageContext,
              ),
            ),
            Page(
              title: '网流',
              subtitle: '',
              icon: GalleryIcons.shrine,
              url: '/netflow',
              buildRoute: (PageContext pageContext) => Netflow(
                context: pageContext,
              ),
            ),
            Page(
              title: '市场',
              subtitle: '',
              icon: GalleryIcons.shrine,
              url: '/market',
              buildRoute: (PageContext pageContext) => Market(
                context: pageContext,
              ),
            ),
            Page(
              title: '地微',
              subtitle: '',
              icon: GalleryIcons.shrine,
              url: '/geosphere',
              buildRoute: (PageContext pageContext) => Geosphere(
                context: pageContext,
              ),
            ),
          ],
        ),
  ];
}
