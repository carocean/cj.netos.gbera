import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/errors/errors.dart';
import 'package:gbera/portals/gbera/pages/desktop.dart';
import 'package:gbera/portals/gbera/pages/geosphere.dart';
import 'package:gbera/portals/gbera/pages/market.dart';
import 'package:gbera/portals/gbera/pages/netflow.dart';
import 'package:gbera/portals/gbera/scaffolds.dart';

import 'common/icons.dart';
import 'gbera/login.dart';
import 'gbera/login2.dart';

List<BuildPortal> buildPortals(IServiceProvider site) {
  return <BuildPortal>[
    (IServiceProvider site) => Portal(
          id: 'gbera',
          icon: GalleryIcons.shrine,
          name: '金证时代官方框架',
          buildThemes: (Portal portal, IServiceProvider site) => [
            ThemeStyle(
              title: '灰色',
              desc: '呈现淡灰色，接近白',
              url: '/gray',
              buildTheme: (BuildContext context) {
                return ThemeData(
                  backgroundColor: Color(0xFFF5F5f5),
                  scaffoldBackgroundColor: Color(0xFFF5F5f5),
                  primarySwatch: MaterialColor(
                    0xFFF5F5f5,
                    {
                      50: Color(0xFFE8F5E9),
                      100: Color(0xFFC8E6C9),
                      200: Color(0xFFA5D6A7),
                      300: Color(0xFF81C784),
                      400: Color(0xFF66BB6A),
                      500: Color(0xFF4CAF50),
                      600: Color(0xFF43A047),
                      700: Color(0xFF388E3C),
                      800: Color(0xFF2E7D32),
                      900: Color(0xFF1B5E20),
                    },
                  ),
                );
              },
            ),
          ],
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
              title: '登录',
              subtitle: '',
              icon: GalleryIcons.shrine,
              url: '/login2',
              buildRoute: (PageContext pageContext) => LoginPage2(
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
