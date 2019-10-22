import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';

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

    List<Widget> panel = [
      SliverAppBar(
        title: Text('市场'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          tiles_plus.toList(),
        ),
      ),
      SliverToBoxAdapter(
        //分隔栏
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          tiles_markets.toList(),
        ),
      ),
    ];
    return SafeArea(
      child: CustomScrollView(
        slivers: panel,
      ),
    );
  }
}
