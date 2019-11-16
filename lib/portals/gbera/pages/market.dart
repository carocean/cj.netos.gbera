import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/parts/CardItem.dart';

class Market extends StatefulWidget {
  final PageContext context;

  Market({this.context});

  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    createDivider() {
      var divider = Container(
        height: 1,
        color: Colors.white,
        child: Divider(
          height: 1,
          indent: 60,
          color: Color(0xFFCECECE),
        ),
      );
      return divider;
    }

    var tiles_plus = [
      Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            widget.context.forward('/market/plus/entities');
          },
          child: ListTile(
            title: Text('实体+'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            leading: Icon(
              Icons.shop_two,
              size: 25,
            ),
          ),
        ),
      ),
      createDivider(),
      Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            widget.context.forward('/market/plus/stores');
          },
          child: ListTile(
            title: Text('卖场+'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            leading: Icon(
              Icons.shopping_cart,
              size: 25,
            ),
          ),
        ),
      ),
      createDivider(),
      Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            widget.context.forward('/market/plus/services');
          },
          child: ListTile(
            title: Text('服务+'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            leading: Icon(
              Icons.local_laundry_service,
              size: 25,
            ),
          ),
        ),
      ),
    ];

    var tiles_markets = [
      Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            widget.context.forward('/market/jzbanks');
          },
          child: ListTile(
            title: Text('金证银行'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            leading: Icon(
              FontAwesomeIcons.piggyBank,
              size: 25,
            ),
          ),
        ),
      ),
      createDivider(),
      Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            widget.context.forward('/market/tydealmarket');
          },
          child: ListTile(
            title: Text('帑银交易所'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            leading: Icon(
              Icons.markunread_mailbox,
              size: 25,
            ),
          ),
        ),
      ),
    ];

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('市场'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.userCircle,
              ),
              onPressed: () {
                widget.context.forward("/market/mine");
              },
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: _renderDealmarketRegion(),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 10,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            _platformServices().toList(),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 10,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            _shoppingMarket().toList(),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 10,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            _platformNewsDays().toList(),
          ),
        ),
      ],
    );
  }

  _renderDealmarketRegion() {
    return Container(
      padding: EdgeInsets.only(
        top: 30,
        bottom: 20,
      ),
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Icon(
                  IconData(0xe659, fontFamily: 'market'),
                  size: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                  ),
                  child: Text(
                    '帑指行情',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Icon(
                  IconData(0xe52a, fontFamily: 'market'),
                  size: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                  ),
                  child: Text(
                    '帑银行情',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _platformServices() {
    var services = <_PlatformService>[
      _PlatformService(
        name: '我要开实体店',
        icon: Icon(
          Icons.store,
          size: 30,
          color: Colors.grey[600],
        ),
      ),
      _PlatformService(
        name: '我要开线上卖场',
        icon: Icon(
          Icons.shop,
          size: 30,
          color: Colors.grey[600],
        ),
      ),
      _PlatformService(
        name: '我要开服务厅',
        icon: Icon(
          Icons.local_laundry_service,
          size: 30,
          color: Colors.grey[600],
        ),
      ),
      _PlatformService(
        name: '我要做地商',
        icon: Icon(
          IconData(0xe62d, fontFamily: 'geo_locations'),
          size: 30,
          color: Colors.grey[600],
        ),
      ),
    ];

    return services.map((service) {
      return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: CardItem(
                title: service.name,
                leading: service.icon,
              ),
            ),
            Container(
              child: Divider(
                height: 1,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _shoppingMarket() {
    var services = <_PlatformService>[
      _PlatformService(
        name: '购物',
        icon: Icon(
          Icons.shopping_basket,
          size: 30,
          color: Colors.grey[600],
        ),
      ),
    ];

    return services.map((service) {
      return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: CardItem(
                title: service.name,
                leading: service.icon,
              ),
            ),
            Container(
              child: Divider(
                height: 1,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _platformNewsDays() {
    return [
      _PlatformNewsDay(timeTitle: '今天资讯', timeSubtitle: '12:30'),
    ];
  }
}

class _PlatformNewsDay extends StatefulWidget {
  String timeTitle;
  String timeSubtitle;

  _PlatformNewsDay({this.timeTitle, this.timeSubtitle});

  @override
  __PlatformNewsDayState createState() => __PlatformNewsDayState();
}

class __PlatformNewsDayState extends State<_PlatformNewsDay> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _PlatformService {
  String name;
  Icon icon;

  _PlatformService({this.name, this.icon});
}
