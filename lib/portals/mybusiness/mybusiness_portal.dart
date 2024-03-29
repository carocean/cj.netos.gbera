import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/mybusiness/scaffolds.dart';
import 'package:gbera/portals/mybusiness/styles/blue_styles.dart' as blue;

var buildPortal = (IServiceProvider site) => Portal(
      id: 'mybusiness',
      name: '我的生意',
      icon: Icons.add,
      buildThemes: (portal, site) => <ThemeStyle>[
        ThemeStyle(
          title: '蓝色',
          desc: '呈现淡蓝，接近白',
          url: '/blue',
          iconColor: Colors.blue[500],
          buildStyle: (portal,site) => blue.buildStyles(portal,site),
          buildTheme: (context) => ThemeData(
            backgroundColor: Color(0xFFF5F5f5),
            scaffoldBackgroundColor: Color(0xFFF5F5f5),
            brightness: Brightness.light,
            appBarTheme: AppBarTheme.of(context).copyWith(
              color: Color(0xFFF5F5f5),
              textTheme: TextTheme(
                title: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actionsIconTheme: IconThemeData(
                color: Colors.blue[700],
                opacity: 1,
                size: 20,
              ),
              brightness: Brightness.light,
              iconTheme: IconThemeData(
                color: Colors.blue[700],
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
          ),
        ),
      ],
      buildDesklets: (portal, site) => <Desklet>[],
      buildPages: (portal, site) => <Page>[
        Page(
          title: '我的生意',
          subtitle: '',
          icon: Icons.business,
          url: '/scaffolds/mybusiness',
          buildPage: (PageContext pageContext) => MyBusinessScaffold(
            context: pageContext,
          ),
        ),
      ],
    );
