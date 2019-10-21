import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/common/util.dart';
import 'package:intl/intl.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import '../parts/parts.dart';

class Desktop extends StatefulWidget {
  PageContext context;

  Desktop({this.context});

  @override
  _DesktopState createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  var _controller;
  var _backgroud_transparent = true;
  var use_wallpapper = true; //是否使用墙纸的开关
  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  _listener() {
    if (!use_wallpapper) {
      return;
    }
    if (_backgroud_transparent && _controller.offset >= 210 - 40) {//40是appbar的高度，210是appbar展开发的总高
      setState(() {
        _backgroud_transparent = false;
      });
      return;
    }
    if (!_backgroud_transparent && _controller.offset < 210 - 40) {
      setState(() {
        _backgroud_transparent = true;
      });
      return;
    }
  }

  _DesktopState() {
    _controller = ScrollController(initialScrollOffset: 0.0);
    _controller.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    var onProfileTap = () {
      widget.context.forward('/profile');
    };
    var url = widget.context.page.parameters['From-Page-Url'];
    var scaffold =
        widget.context.findPage('${widget.context.page.portal}:/$url');
    var myarea = Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: use_wallpapper
            ? DecorationImage(
                image: NetworkImage(
                    'http://ku.90sjimg.com/back_pic/05/39/03/755a5213bd7e696.jpg%21/fwfh/804x1206/quality/90/unsharp/true/compress/true/watermark/text/OTDorr7orqE=/font/simkai/align/southeast/opacity/20/size/50'),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: CustomScrollView(
        controller: _controller,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 210,
            floating: false,
            title: Text(
              scaffold?.title ?? '',
            ),
            titleSpacing: 10,
            centerTitle: false,
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: use_wallpapper && _backgroud_transparent
                ? Colors.transparent
                : null,
            actions: <Widget>[
              IconButton(
                // Use the FontAwesomeIcons class for the IconData
                icon: new Icon(Icons.crop_free),
                onPressed: () async {
                  String cameraScanResult = await scanner.scan();
                  showDialog(
                    context: context,
                    barrierDismissible: true, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('扫好友、扫地物、支付、收款等'),
                        content: Text(cameraScanResult),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('YES'),
                            onPressed: () {
                              print('yes...');
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('NO'),
                            onPressed: () {
                              print('no...');
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                        backgroundColor: Colors.yellowAccent,
                        elevation: 20,
                        semanticLabel: '哈哈哈哈',
                        // 设置成 圆角
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      );
                    },
                  );
                },
              ),
              IconButton(
                // Use the FontAwesomeIcons class for the IconData
                icon: new Icon(
                  widget.context.findPage('/desktop/lets/settings')?.icon,
                ),
                onPressed: () {
                  widget.context.forward(
                    '/desktop/lets/settings',
                    arguments: {
                      'back_button': true,
                    },
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: 0,
                      top: 80,
                    ),
                    child: ListTile(
                      title: Text(
                        '${widget.context.userPrincipal?.accountName}',
                        softWrap: true,
                      ),
                      subtitle: Text(
                        '我回家吃了饭',
                        softWrap: true,
                      ),
                      leading: GestureDetector(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'http://pic-bucket.ws.126.net/photo/0001/2019-08-13/EMENLA1600AN0001NOS.jpg'),
                        ),
                        onTap: onProfileTap,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => widget.context.forward(
                                '/wallet/change',
                                arguments: {
                                  'back_button': true,
                                },
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '6500.50',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    '零钱',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          VerticalDivider(
                            width: 1,
                            color: Colors.red,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => widget.context.forward(
                                '/wallet/ty',
                                arguments: {
                                  'back_button': true,
                                },
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '5400.03',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    '帑银资产',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          VerticalDivider(
                            width: 1,
                            color: Colors.red,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => widget.context.forward(
                                '/wallet/wy',
                                arguments: {
                                  'back_button': true,
                                },
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '201.88',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    '纹银资产',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 2),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      '桌面',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          print('press key ..');
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                right: 5,
                              ),
                              child: Text(
                                '总资产:',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Text(
                              '11000.82',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              margin: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                child: Column(
                  children: <Widget>[
                    Flex(
                      mainAxisSize: MainAxisSize.max,
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: <Widget>[
                              Image(
                                width: 20.0,
                                height: 20.0,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'http://pic-bucket.ws.126.net/photo/0001/2019-08-13/EMENLA1600AN0001NOS.jpg'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Align(
                                  child: Text(
                                    '丰都集团',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  alignment: Alignment.topRight,
                                  heightFactor: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.topRight,
                            heightFactor: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.directions_walk,
                                  size: 12,
                                ),
                                Text(
                                  '天河区·地商',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '指数：',
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 5,
                              right: 10,
                            ),
                            child: Text('2393.02'),
                          ),
                          Text(
                            '日成交：',
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 5,
                            ),
                            child: Text('382.38'),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: Adapt.screenW() - Adapt.px(100),
                            maxHeight: 150,
                          ),
                          child: CustomAxisTickFormatters.withSampleData(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: CardStore(
              content: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text('您的资产'),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('当前价/原价'),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('奖池/买单数'),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return new Divider(
                        height: 1.0,
                        color: Colors.grey[300],
                      );
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: <Widget>[
                            Icon(
                              Icons.account_balance,
                              size: 25,
                              color: Colors.grey[400],
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: <Widget>[
                                      Text('旺角女装'),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text('2838.23'),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: <Widget>[
                                      Text('2393.53'),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text('939.12'),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: <Widget>[
                                      Text('82.00'),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text('25.98'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    return myarea;
  }

  _buildCards(BuildContext context) {}
}

class CustomAxisTickFormatters extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  CustomAxisTickFormatters(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory CustomAxisTickFormatters.withSampleData() {
    return new CustomAxisTickFormatters(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Formatter for numeric ticks using [NumberFormat] to format into currency
    ///
    /// This is what is used in the [NumericAxisSpec] below.
    final simpleCurrencyFormatter =
        new charts.BasicNumericTickFormatterSpec.fromNumberFormat(
            new NumberFormat.compactSimpleCurrency());

    /// Formatter for numeric ticks that uses the callback provided.
    ///
    /// Use this formatter if you need to format values that [NumberFormat]
    /// cannot provide.
    ///
    /// To see this formatter, change [NumericAxisSpec] to use this formatter.
    // final customTickFormatter =
    //   charts.BasicNumericTickFormatterSpec((num value) => 'MyValue: $value');

    return new charts.TimeSeriesChart(seriesList,
        animate: animate,
        // Sets up a currency formatter for the measure axis.
        primaryMeasureAxis: new charts.NumericAxisSpec(
            tickFormatterSpec: simpleCurrencyFormatter),

        /// Customizes the date tick formatter. It will print the day of month
        /// as the default format, but include the month and year if it
        /// transitions to a new month.
        ///
        /// minute, hour, day, month, and year are all provided by default and
        /// you can override them following this pattern.
        domainAxis: new charts.DateTimeAxisSpec(
            tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
                day: new charts.TimeFormatterSpec(
                    format: 'd', transitionFormat: 'MM/dd/yyyy'))));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<MyRow, DateTime>> _createSampleData() {
    final data = [
      new MyRow(new DateTime(2017, 9, 25), 6),
      new MyRow(new DateTime(2017, 9, 26), 8),
      new MyRow(new DateTime(2017, 9, 27), 6),
      new MyRow(new DateTime(2017, 9, 28), 9),
      new MyRow(new DateTime(2017, 9, 29), 11),
      new MyRow(new DateTime(2017, 9, 30), 15),
      new MyRow(new DateTime(2017, 10, 01), 25),
      new MyRow(new DateTime(2017, 10, 02), 33),
      new MyRow(new DateTime(2017, 10, 03), 27),
      new MyRow(new DateTime(2017, 10, 04), 31),
      new MyRow(new DateTime(2017, 10, 05), 23),
    ];

    return [
      new charts.Series<MyRow, DateTime>(
        id: 'Cost',
        domainFn: (MyRow row, _) => row.timeStamp,
        measureFn: (MyRow row, _) => row.cost,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class MyRow {
  final DateTime timeStamp;
  final int cost;

  MyRow(this.timeStamp, this.cost);
}
