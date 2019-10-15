import 'package:flutter/widgets.dart';
import 'package:gbera/portals/gbera/desktop.dart';
import 'package:gbera/portals/gbera/errors/errors.dart';
import 'package:gbera/portals/gbera/netflow.dart';

import '../gbera/common.dart';
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
              buildRoute:
                  (BuildContext buildContext, PageContext pageContext) =>
                      GberaError(
                context: pageContext,
              ),
            ),
            Page(
              title: '登录',
              subtitle: '',
              icon: GalleryIcons.shrine,
              url: '/login',
              buildRoute:
                  (BuildContext buildContext, PageContext pageContext) =>
                      LoginPage(
                context: pageContext,
              ),
            ),
            Page(
              title: '桌面',
              subtitle: '',
              icon: GalleryIcons.shrine,
              url: '/desktop',
              buildRoute:
                  (BuildContext buildContext, PageContext pageContext) =>
                      Desktop(
                context: pageContext,
              ),
            ),
            Page(
              title: '网流',
              subtitle: '',
              icon: GalleryIcons.shrine,
              url: '/netflow',
              buildRoute:
                  (BuildContext buildContext, PageContext pageContext) =>
                  Netflow(
                    context: pageContext,
                  ),
            ),
          ],
        ),
  ];
}
