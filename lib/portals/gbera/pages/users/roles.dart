import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class Roles extends StatelessWidget {
  PageContext context;

  Roles({this.context});

  @override
  Widget build(BuildContext context) {
    var ucRoles=<Widget>[];
//    for(var role in this.context.userPrincipal.ucRoles) {
//      var role_item = _buildUcRole(role);
//      ucRoles.add(role_item);
//    }
    var tenantRoles=<Widget>[];
//    for(var role in this.context.userPrincipal.tenantRoles) {
//      var role_item = _buildTenantRole(role);
//      tenantRoles.add(role_item);
//    }
    var appRoles=<Widget>[];
//    for(var role in this.context.userPrincipal.appRoles) {
//      var role_item = _buildAppRole(role);
//      appRoles.add(role_item);
//    }
    var items_platform = Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            bottom: 5,
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: Image.asset(
                  'lib/portals/gbera/images/gbera.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 2,
                    ),
                    child: Text('平台'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Text(
                      '点背科技',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          indent: 50,
        ),
        Container(
          padding: EdgeInsets.only(
            left: 50,
            top: 10,
          ),
          child: Column(
            children:ucRoles,
          ),
        ),
      ],
    );
    var items_tenant = Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            bottom: 5,
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: Image.asset(
                  'lib/portals/gbera/images/gbera.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 2,
                    ),
                    child: Text('租户'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Text(
                      'netos',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          indent: 50,
        ),
        Container(
          padding: EdgeInsets.only(
            left: 50,
            top: 10,
          ),
          child: Column(
            children: tenantRoles,
          ),
        ),
      ],
    );
    var items_app = Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            bottom: 5,
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: Image.asset(
                  'lib/portals/gbera/images/gbera.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 2,
                    ),
                    child: Text('应用'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Text(
                      '${this.context.principal?.appid}',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          indent: 50,
        ),
        Container(
          padding: EdgeInsets.only(
            left: 50,
            top: 10,
          ),
          child: Column(
            children: appRoles,
          ),
        ),
      ],
    );
    var bb = this.context.parameters['back_button'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.context.page?.title,
        ),
        titleSpacing: 0,
        elevation: 0,
        automaticallyImplyLeading: bb == null ? true : false,
        leading: getLeading(bb),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10,
            ),
            child: items_platform,
          ),
          Container(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10,
            ),
            child: items_tenant,
          ),
          Container(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10,
            ),
            child: items_app,
          ),
        ],
      ),
    );
  }

  getLeading(bb) {
    if (bb == null) return null;
    return IconButton(
      onPressed: () {
        this.context.backward();
      },
      icon: Icon(
        Icons.clear,
        size: 18,
      ),
    );
  }

  _buildUcRole(Map role) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: 5,
            ),
            child: Text('-'),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 5,
            ),
            child: Text('${role['roleName']}'),
          ),
        ],
      ),
    );
  }
  _buildTenantRole(Map role) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: 5,
            ),
            child: Text('-'),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 5,
            ),
            child: Text('${role['roleName']}'),
          ),
        ],
      ),
    );
  }
  _buildAppRole(Map role) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: 5,
            ),
            child: Text('-'),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 5,
            ),
            child: Text('${role['roleName']}'),
          ),
        ],
      ),
    );
  }
}
