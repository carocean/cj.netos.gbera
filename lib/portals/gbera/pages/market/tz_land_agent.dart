import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gbera/netos/common.dart';
import 'package:flutter_k_chart/flutter_k_chart.dart';
import 'package:flutter_k_chart/k_chart_widget.dart';

class LandAgentFutrue extends StatefulWidget {
  PageContext context;

  LandAgentFutrue({this.context});

  @override
  _LandAgentFutrueState createState() => _LandAgentFutrueState();
}

class _LandAgentFutrueState extends State<LandAgentFutrue>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    this.tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            titleSpacing: 0,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                  height: 30,
                  child: Image.network(
                    'http://47.105.165.186:7100/public/market/timg-3.jpeg?App-ID=${widget.context.userPrincipal.appid}&Access-Token=${widget.context.userPrincipal.accessToken}',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '德宝科技',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    children: [
                      TextSpan(text: '\r\n'),
                      TextSpan(
                        text: '广州市·F00038',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: _HeaderCard(),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: _KChartCard(context: widget.context,),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 10,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                labelColor: Colors.black,
                controller: this.tabController,
                tabs: <Widget>[
                  Tab(text: '盘口'),
                  Tab(text: '成交明细'),
                ],
              ),
            ),
          ),

          SliverFillRemaining(
            child: TabBarView(
              controller: this.tabController,
              children: <Widget>[
                Center(child: Text('Content of Home')),
                Center(child: Text('Content of Profile')),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('下单'),
        onPressed: () {},
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _HeaderCard extends StatefulWidget {
  @override
  __HeaderCardState createState() => __HeaderCardState();
}

class __HeaderCardState extends State<_HeaderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: 5,
            ),
            child: Text('5.23'),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 5,
            ),
            child: Text.rich(
              TextSpan(
                text: '-0.78',
                children: [
                  TextSpan(
                    text: '   ',
                  ),
                  TextSpan(
                    text: '-0.36%',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KChartCard extends StatefulWidget {
  PageContext context;

  _KChartCard({this.context});

  @override
  _KChartCardState createState() => _KChartCardState();
}

class _KChartCardState extends State<_KChartCard> {
  List<KLineEntity> datas;
  bool showLoading = true;
  MainState _mainState = MainState.MA;
  SecondaryState _secondaryState = SecondaryState.MACD;
  bool isLine = true;
  List<DepthEntity> _bids, _asks;
  @override
  void initState() {
    super.initState();
    getData('1day');
    rootBundle.loadString('lib/portals/gbera/data/depth.json').then((result) {
      final parseJson = json.decode(result);
      Map tick = parseJson['tick'];
      var bids = tick['bids'].map((item) => DepthEntity(item[0], item[1])).toList().cast<DepthEntity>();
      var asks = tick['asks'].map((item) => DepthEntity(item[0], item[1])).toList().cast<DepthEntity>();
      initDepth(bids, asks);
    });
  }

  void initDepth(List<DepthEntity> bids, List<DepthEntity> asks) {
    if (bids == null || asks == null || bids.isEmpty || asks.isEmpty) return;
    _bids = List();
    _asks = List();
    double amount = 0.0;
    bids?.sort((left, right) => left.price.compareTo(right.price));
    //倒序循环 //累加买入委托量
    bids.reversed.forEach((item) {
      amount += item.amount;
      item.amount = amount;
      _bids.insert(0, item);
    });

    amount = 0.0;
    asks?.sort((left, right) => left.price.compareTo(right.price));
    //循环 //累加买入委托量
    asks?.forEach((item) {
      amount += item.amount;
      item.amount = amount;
      _asks.add(item);
    });
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(children: <Widget>[
          Container(
            height: 350,
            width: double.infinity,
            child: KChartWidget(
              datas,
              isLine: isLine,
              mainState: _mainState,
              secondaryState: _secondaryState,
              volState: VolState.VOL,
              fractionDigits: 4,
            ),
          ),
          if (showLoading)
            Container(
                width: double.infinity, height: 350, alignment: Alignment.center, child: CircularProgressIndicator()),
        ]),
        buildButtons(),
        Container(
          height: 130,
          width: double.infinity,
          child: DepthChart(_bids, _asks),
        )
      ],
    );
  }
  Widget buildButtons() {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: <Widget>[
        button("分时", onPressed: () => isLine = true),
        button("k线", onPressed: () => isLine = false),
        button("MA", onPressed: () => _mainState = MainState.MA),
        button("BOLL", onPressed: () => _mainState = MainState.BOLL),
        button("隐藏", onPressed: () => _mainState = MainState.NONE),
        button("MACD", onPressed: () => _secondaryState = SecondaryState.MACD),
        button("KDJ", onPressed: () => _secondaryState = SecondaryState.KDJ),
        button("RSI", onPressed: () => _secondaryState = SecondaryState.RSI),
        button("WR", onPressed: () => _secondaryState = SecondaryState.WR),
        button("隐藏副视图", onPressed: () => _secondaryState = SecondaryState.NONE),
        button("update", onPressed: (){
          //更新最后一条数据
          datas.last.close += (Random().nextInt(100)-50).toDouble();
          datas.last.high=max(datas.last.high,datas.last.close );
          datas.last.low=min(datas.last.low,datas.last.close );
          DataUtil.updateLastData(datas);
        }),
        button("addData", onPressed: () {
          //拷贝一个对象，修改数据
          var kLineEntity = KLineEntity.fromJson(datas.last.toJson());
          kLineEntity.id += 60*60*24;
          kLineEntity.open = kLineEntity.close;
          kLineEntity.close += (Random().nextInt(100)-50).toDouble();
          datas.last.high=max(datas.last.high,datas.last.close );
          datas.last.low=min(datas.last.low,datas.last.close );
          DataUtil.addLastData(datas,kLineEntity);
        }),
      ],
    );
  }

  Widget button(String text, {VoidCallback onPressed}) {
    return FlatButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed();
            setState(() {});
          }
        },
        child: Text("$text"),
        color: Colors.blue);
  }

  void getData(String period) async {
    String result;
    try {
      result = await rootBundle.loadString('lib/portals/gbera/data/kline.json');
    } catch (e) {
      print('获取数据失败,获取本地数据');
    }finally{
      Map parseJson = json.decode(result);
      List list = parseJson['data'];
      datas = list.map((item) => KLineEntity.fromJson(item)).toList().reversed.toList().cast<KLineEntity>();
      DataUtil.calculate(datas);
      showLoading = false;
      setState(() {});
    }
  }
}
