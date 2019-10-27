import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/common/icons.dart';
import 'package:gbera/portals/gbera/errors/errors.dart';
import 'package:gbera/portals/gbera/pages/contact/contact_list.dart';
import 'package:gbera/portals/gbera/pages/desktop.dart';
import 'package:gbera/portals/gbera/pages/desktop/desklets_settings.dart';
import 'package:gbera/portals/gbera/pages/desktop/desktop_settings.dart';
import 'package:gbera/portals/gbera/pages/desktop/portlet_list.dart';
import 'package:gbera/portals/gbera/pages/geosphere.dart';
import 'package:gbera/portals/gbera/pages/geosphere/geo_downstream.dart';
import 'package:gbera/portals/gbera/pages/geosphere/geo_fountain.dart';
import 'package:gbera/portals/gbera/pages/geosphere/geo_insite.dart';
import 'package:gbera/portals/gbera/pages/geosphere/geo_myspace.dart';
import 'package:gbera/portals/gbera/pages/geosphere/geo_outlook.dart';
import 'package:gbera/portals/gbera/pages/geosphere/geo_outsite.dart';
import 'package:gbera/portals/gbera/pages/geosphere/geo_settings.dart';
import 'package:gbera/portals/gbera/pages/geosphere/geo_upstream.dart';
import 'package:gbera/portals/gbera/pages/geosphere/geo_visitors_entry.dart';
import 'package:gbera/portals/gbera/pages/geosphere/geo_yuanbao.dart';
import 'package:gbera/portals/gbera/pages/market.dart';
import 'package:gbera/portals/gbera/pages/market/entities_plus.dart';
import 'package:gbera/portals/gbera/pages/market/jzbanks.dart';
import 'package:gbera/portals/gbera/pages/market/services_plus.dart';
import 'package:gbera/portals/gbera/pages/market/stores_plus.dart';
import 'package:gbera/portals/gbera/pages/market/tydeal_market.dart';
import 'package:gbera/portals/gbera/pages/netflow.dart';
import 'package:gbera/portals/gbera/pages/profile.dart';
import 'package:gbera/portals/gbera/pages/system/about.dart';
import 'package:gbera/portals/gbera/pages/system/contract.dart';
import 'package:gbera/portals/gbera/pages/system/themes.dart';
import 'package:gbera/portals/gbera/pages/users/account_login.dart';
import 'package:gbera/portals/gbera/pages/users/accounts.dart';
import 'package:gbera/portals/gbera/pages/users/add_account.dart';
import 'package:gbera/portals/gbera/pages/users/edit_password.dart';
import 'package:gbera/portals/gbera/pages/users/roles.dart';
import 'package:gbera/portals/gbera/pages/users/user_list.dart';
import 'package:gbera/portals/gbera/pages/wallet.dart';
import 'package:gbera/portals/gbera/pages/wallet/amount_settings.dart';
import 'package:gbera/portals/gbera/pages/wallet/card_details.dart';
import 'package:gbera/portals/gbera/pages/wallet/cards.dart';
import 'package:gbera/portals/gbera/pages/wallet/cashout.dart';
import 'package:gbera/portals/gbera/pages/wallet/change.dart';
import 'package:gbera/portals/gbera/pages/wallet/change_bill.dart';
import 'package:gbera/portals/gbera/pages/wallet/change_details.dart';
import 'package:gbera/portals/gbera/pages/wallet/deposit.dart';
import 'package:gbera/portals/gbera/pages/wallet/payables.dart';
import 'package:gbera/portals/gbera/pages/wallet/receivables.dart';
import 'package:gbera/portals/gbera/pages/wallet/ty.dart';
import 'package:gbera/portals/gbera/pages/wallet/wy.dart';
import 'package:gbera/portals/gbera/scaffolds.dart';

import 'desklets/desklets.dart';
import 'login.dart';
import 'login2.dart';
import 'pages/contact/contacts_viewer.dart';
import 'pages/desktop/wallpappers.dart';
import 'pages/system/gbera_settings.dart';
import 'pages/users/account_viewer.dart';
import 'pages/wallet/ReceivablesRecord.dart';
import 'pages/wallet/receivables_details.dart';
import 'styles/green-styles.dart';
import 'styles/grey-styles.dart';

var buildPortal = (IServiceProvider site) => Portal(
      id: 'gbera',
      icon: GalleryIcons.shrine,
      name: '金证时代官方框架',
      buildThemes: (Portal portal, IServiceProvider site) => [
        ThemeStyle(
          title: '灰色',
          desc: '呈现淡灰色，接近白',
          url: '/grey',
          iconColor: Colors.grey[500],
          buildStyle: buildGreyStyles,
          buildTheme: (BuildContext context) {
            return ThemeData(
              backgroundColor: Color(0xFFF5F5f5),
              scaffoldBackgroundColor: Color(0xFFF5F5f5),
              brightness: Brightness.light,
              appBarTheme: AppBarTheme.of(context).copyWith(
                color: Color(0xFFF5F5f5),
                textTheme: TextTheme(
                  title: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                actionsIconTheme: IconThemeData(
                  color: Colors.grey[700],
                  opacity: 1,
                  size: 20,
                ),
                brightness: Brightness.light,
                iconTheme: IconThemeData(
                  color: Colors.grey[700],
                  opacity: 1,
                  size: 20,
                ),
                elevation: 1.0,
              ),
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
        ThemeStyle(
          title: '绿色',
          desc: '呈现淡绿',
          url: '/green',
          iconColor: Colors.green[500],
          buildStyle: buildGreenStyles,
          buildTheme: (BuildContext context) {
            return ThemeData(
              backgroundColor: Color(0xFFE8F5E9),
              scaffoldBackgroundColor: Color(0xFFE8F5E9),
              appBarTheme: AppBarTheme.of(context).copyWith(
                color: Color(0xFFE8F5E9),
                textTheme: TextTheme(
                  title: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                actionsIconTheme: IconThemeData(
                  color: Colors.green,
                  opacity: 1,
                  size: 20,
                ),
                brightness: Brightness.light,
                iconTheme: IconThemeData(
                  color: Colors.green,
                  opacity: 1,
                  size: 20,
                ),
                elevation: 1.0,
              ),
              primarySwatch: MaterialColor(
                0xFF4CAF50,
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
      buildDesklets: buildDesklets,
      buildPages: (Portal portal, IServiceProvider site) => [
        Page(
          title: '出错啦',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/error',
          buildPage: (PageContext pageContext) => GberaError(
            context: pageContext,
          ),
        ),
        Page(
          title: '小信猪',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/scaffold/withbottombar',
          buildPage: (PageContext pageContext) => WithBottomScaffold(
            context: pageContext,
          ),
        ),
        Page(
          title: '登录',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/login',
          buildPage: (PageContext pageContext) => LoginPage(
            context: pageContext,
          ),
        ),
        Page(
          title: '登录2',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/login2',
          buildPage: (PageContext pageContext) => LoginPage2(
            context: pageContext,
          ),
        ),
        Page(
          title: '桌面',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/desktop',
          buildPage: (PageContext pageContext) => Desktop(
            context: pageContext,
          ),
        ),
        Page(
          title: '网流',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/netflow',
          buildPage: (PageContext pageContext) => Netflow(
            context: pageContext,
          ),
        ),
        Page(
          title: '市场',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/market',
          buildPage: (PageContext pageContext) => Market(
            context: pageContext,
          ),
        ),
        Page(
          title: '地微',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/geosphere',
          buildPage: (PageContext pageContext) => Geosphere(
            context: pageContext,
          ),
        ),
        Page(
          title: '偏好设置',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/profile',
          buildPage: (PageContext pageContext) => Profile(
            context: pageContext,
          ),
//              buildRoute:
//                  (RouteSettings settings, Page page, IServiceProvider site) {
//                SlideTransition createTransition(
//                    Animation<double> animation, Widget child) {
//                  return new SlideTransition(
//                    position: new Tween<Offset>(
//                      begin: const Offset(1.0, 0.0),
//                      end: const Offset(0.0, 0.0),
//                    ).animate(animation),
//                    child: child,
//                  );
//                }
//
//                return PageRouteBuilder(
//                  settings: settings,
//                  pageBuilder: (BuildContext context,
//                      Animation<double> animation,
//                      Animation<double> secondaryAnimation) {
//                    // 跳转的路由对象
//                    PageContext pageContext = PageContext(
//                      page: page,
//                      site: site,
//                      context: context,
//                    );
//                    return new Profile(
//                      context: pageContext,
//                    );
//                  },
//                  transitionsBuilder: (
//                    BuildContext context,
//                    Animation<double> animation,
//                    Animation<double> secondaryAnimation,
//                    Widget child,
//                  ) {
//                    return createTransition(animation, child);
//                  },
//                );
//              },
        ),
        Page(
          title: '钱包',
          subtitle: '',
          icon: Icons.account_balance_wallet,
          url: '/wallet',
          buildPage: (PageContext pageContext) => Wallet(
            context: pageContext,
          ),
        ),
        Page(
          title: '银行卡',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/wallet/card',
          buildPage: (PageContext pageContext) => BankCards(
            context: pageContext,
          ),
        ),
        Page(
          title: '零钱',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/wallet/change',
          buildPage: (PageContext pageContext) => Change(
            context: pageContext,
          ),
        ),
        Page(
          title: '收款',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/wallet/receivables',
          buildPage: (PageContext pageContext) => Receivables(
            context: pageContext,
          ),
        ),
        Page(
          title: '付款',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/wallet/payables',
          buildPage: (PageContext pageContext) => Payables(
            context: pageContext,
          ),
        ),
        Page(
          title: '设置金额',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/wallet/receivables/settings',
          buildPage: (PageContext pageContext) => AmountSettings(
            context: pageContext,
          ),
        ),
        Page(
          title: '收款记录',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/wallet/receivables/record',
          buildPage: (PageContext pageContext) => ReceivablesRecord(
            context: pageContext,
          ),
        ),
        Page(
          title: '收款单',
          subtitle: '',
          previousTitle: '收款记录',
          desc: '收款记录详情',
          icon: GalleryIcons.shrine,
          url: '/wallet/receivables/details',
          buildPage: (PageContext pageContext) => ReceivablesDetails(
            context: pageContext,
          ),
        ),
        Page(
          title: '帑银',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/wallet/ty',
          buildPage: (PageContext pageContext) => TY(
            context: pageContext,
          ),
        ),
        Page(
          title: '纹银',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/wallet/wy',
          buildPage: (PageContext pageContext) => WY(
            context: pageContext,
          ),
        ),
        Page(
          title: '充值',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/wallet/change/deposit',
          buildPage: (PageContext pageContext) => Deposit(
            context: pageContext,
          ),
        ),
        Page(
          title: '提现',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/wallet/change/cashout',
          buildPage: (PageContext pageContext) => Cashout(
            context: pageContext,
          ),
        ),
        Page(
          title: '零钱明细',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/wallet/change/bill',
          buildPage: (PageContext pageContext) => ChangeBill(
            context: pageContext,
          ),
        ),
        Page(
          title: '',
          subtitle: '',
          desc: '零钱明细项的详细页',
          icon: GalleryIcons.shrine,
          url: '/wallet/change/bill/details',
          buildPage: (PageContext pageContext) => ChangeDetails(
            context: pageContext,
          ),
        ),
        Page(
          title: '桌面设置',
          subtitle: '',
          icon: Icons.dashboard,
          url: '/desktop/settings',
          buildPage: (PageContext pageContext) => DesktopSettings(
            context: pageContext,
          ),
        ),
        Page(
          title: '栏目',
          subtitle: '',
          icon: Icons.apps,
          url: '/desktop/lets/settings',
          buildPage: (PageContext pageContext) => DeskletsSettings(
            context: pageContext,
          ),
        ),
        Page(
          title: '墙纸',
          subtitle: '',
          icon: Icons.wallpaper,
          url: '/desktop/wallpappers/settings',
          buildPage: (PageContext pageContext) => Wallpappers(
            context: pageContext,
          ),
        ),
        Page(
          title: '系统设置',
          subtitle: '',
          icon: Icons.settings,
          url: '/system/settings',
          buildPage: (PageContext pageContext) => GberaSettings(
            context: pageContext,
          ),
        ),
        Page(
          title: '主题',
          subtitle: '',
          icon: FontAwesomeIcons.themeisle,
          url: '/system/themes',
          buildPage: (PageContext pageContext) => Themes(
            context: pageContext,
          ),
        ),
        Page(
          title: '用户协议',
          subtitle: '',
          icon: FontAwesomeIcons.fileContract,
          url: '/system/user/contract',
          buildPage: (PageContext pageContext) => UserContract(
            context: pageContext,
          ),
        ),
        Page(
          title: '关于',
          subtitle: '',
          icon: Icons.info_outline,
          url: '/system/about',
          buildPage: (PageContext pageContext) => About(
            context: pageContext,
          ),
        ),
        Page(
          title: '用户与账号',
          subtitle: '',
          icon: Icons.person_outline,
          url: '/users/list',
          buildPage: (PageContext pageContext) => UserAndAccountList(
            context: pageContext,
          ),
        ),
        Page(
          title: '账号',
          subtitle: '',
          icon: Icons.person_outline,
          url: '/users/accounts/viewer',
          buildPage: (PageContext pageContext) => AccountViewer(
            context: pageContext,
          ),
        ),
        Page(
          title: '新建账号',
          subtitle: '',
          icon: Icons.person_outline,
          url: '/users/accounts/addAccount',
          buildPage: (PageContext pageContext) => AddAccount(
            context: pageContext,
          ),
        ),
        Page(
          title: '修改密码',
          subtitle: '',
          icon: Icons.person_outline,
          url: '/users/accounts/editPassword',
          buildPage: (PageContext pageContext) => EditPassword(
            context: pageContext,
          ),
        ),
        Page(
          title: '登录',
          subtitle: '',
          icon: Icons.person_outline,
          url: '/users/accounts/login',
          buildPage: (PageContext pageContext) => AccountLogin(
            context: pageContext,
          ),
        ),
        Page(
          title: '我的角色',
          subtitle: '',
          icon: Icons.recent_actors,
          url: '/users/roles',
          buildPage: (PageContext pageContext) => Roles(
            context: pageContext,
          ),
        ),
        Page(
          title: '登录账号',
          subtitle: '',
          icon: Icons.account_box,
          url: '/users/accounts',
          buildPage: (PageContext pageContext) => Accounts(
            context: pageContext,
          ),
        ),
        Page(
          title: '实体+',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/market/plus/entities',
          buildPage: (PageContext pageContext) => EntitiesPlus(
            context: pageContext,
          ),
        ),
        Page(
          title: '卖场+',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/market/plus/stores',
          buildPage: (PageContext pageContext) => StoresPlus(
            context: pageContext,
          ),
        ),
        Page(
          title: '服务+',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/market/plus/services',
          buildPage: (PageContext pageContext) => ServicesPlus(
            context: pageContext,
          ),
        ),
        Page(
          title: '金证银行',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/market/jzbanks',
          buildPage: (PageContext pageContext) => JZBanks(
            context: pageContext,
          ),
        ),
        Page(
          title: '帑银交易所',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/market/tydealmarket',
          buildPage: (PageContext pageContext) => TYDealMarket(
            context: pageContext,
          ),
        ),
        Page(
          title: '金证喷泉',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/geosphere/fountain',
          buildPage: (PageContext pageContext) => Geofountain(
            context: pageContext,
          ),
        ),
        Page(
          title: '元宝',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/geosphere/yuanbao',
          buildPage: (PageContext pageContext) => GeoYuanbao(
            context: pageContext,
          ),
        ),
        Page(
          title: '地圈设置',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/geosphere/settings',
          buildPage: (PageContext pageContext) => GeoSettings(
            context: pageContext,
          ),
        ),
        Page(
          title: '自地圈',
          subtitle: '我的地圈动态进入我的地微',
          icon: GalleryIcons.shrine,
          url: '/geosphere/insite',
          buildPage: (PageContext pageContext) => GeoInsite(
            context: pageContext,
          ),
        ),
        Page(
          title: '到地圈',
          subtitle: '我的地微推送到我的地圈',
          icon: GalleryIcons.shrine,
          url: '/geosphere/outsite',
          buildPage: (PageContext pageContext) => GeoOutsite(
            context: pageContext,
          ),
        ),
        Page(
          title: '自上游',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/geosphere/upstream',
          buildPage: (PageContext pageContext) => GeoUpstream(
            context: pageContext,
          ),
        ),
        Page(
          title: '到下游',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/geosphere/downstream',
          buildPage: (PageContext pageContext) => GeoDownstream(
            context: pageContext,
          ),
        ),
        Page(
          title: '到访客',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/geosphere/visitorsEntry',
          buildPage: (PageContext pageContext) => GeoVisitorsEntry(
            context: pageContext,
          ),
        ),
        Page(
          title: '自地圈',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/geosphere/outlook',
          buildPage: (PageContext pageContext) => GeoOutlook(
            context: pageContext,
          ),
        ),
        Page(
          title: '自地微',
          subtitle: '',
          desc: '个人的地理信息门户，里面有其发出的文章等，访客可申请访问，默认为公开',
          icon: GalleryIcons.shrine,
          url: '/geosphere/myspace',
          buildPage: (PageContext pageContext) => GeoMySpace(
            context: pageContext,
          ),
        ),
        Page(
          title: '银行卡',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/wallet/card/details',
          buildPage: (PageContext pageContext) => BankCardDetails(
            context: pageContext,
          ),
        ),
        Page(
          title: '联系人',
          subtitle: '',
          icon: FontAwesomeIcons.addressBook,
          url: '/contact/list',
          buildPage: (PageContext pageContext) => ContactList(
            context: pageContext,
          ),
        ),
        Page(
          title: '联系人信息',
          subtitle: '',
          icon: GalleryIcons.shrine,
          url: '/contact/viewer',
          buildPage: (PageContext pageContext) => ContactsViewer(
            context: pageContext,
          ),
        ),
        Page(
          title: '栏目列表',
          subtitle: '',
          desc: '列出门户栏目',
          icon: GalleryIcons.shrine,
          url: '/desktop/portlets',
          buildPage: (PageContext pageContext) => PortletList(
            context: pageContext,
          ),
        ),
      ],
    );
