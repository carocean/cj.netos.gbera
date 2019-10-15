import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gbera/gbera/common.dart';

class MarketDisplay extends StatefulWidget {
  final PageContext context;

  MarketDisplay({this.context});

  @override
  _MarketDisplayState createState() => _MarketDisplayState();
}

class _MarketDisplayState extends State<MarketDisplay> {
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
        child: ListTile(
          title: Text('实体+'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 14,
          ),
          leading: Icon(
            Icons.shop_two,
            size: 35,
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
        child: ListTile(
          title: Text('卖场+'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 14,
          ),
          leading: Icon(
            Icons.shopping_cart,
            size: 35,
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
        child: ListTile(
          title: Text('服务大厅+'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 14,
          ),
          leading: Icon(
            Icons.local_laundry_service,
            size: 35,
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
        child: ListTile(
          title: Text('地商'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 14,
          ),
          leading: Icon(
            Icons.edit_location,
            size: 35,
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
        child: ListTile(
          title: Text('帑银交易市场'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 14,
          ),
          leading: Icon(
            Icons.markunread_mailbox,
            size: 35,
          ),
        ),
      ),
    ];

    List<Widget> panel = [
      SliverAppBar(
        title: Text('市场'),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
