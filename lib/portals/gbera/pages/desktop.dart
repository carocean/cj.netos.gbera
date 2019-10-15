import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/common/util.dart';
import 'package:intl/intl.dart';

import '../parts/parts.dart';

class Desktop extends StatefulWidget {
  PageContext context;

  Desktop({this.context});

  @override
  _DesktopState createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  @override
  Widget build(BuildContext context) {
    var myarea = SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 210,
            floating: false,
            title: Text(widget?.context?.page?.title),
            titleSpacing: 10,
            centerTitle: false,
            automaticallyImplyLeading: false,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                // Use the FontAwesomeIcons class for the IconData
                icon: new Icon(Icons.crop_free),
                onPressed: () {
                  print("Pressed");
                },
              ),
              IconButton(
                // Use the FontAwesomeIcons class for the IconData
                icon: new Icon(Icons.apps),
                onPressed: () {
                  print("Pressed");
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
                      top: 50,
                    ),
                    child: ListTile(
                      title: Text('carocean'),
                      subtitle: Text('我回家吃了饭'),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'http://pic-bucket.ws.126.net/photo/0001/2019-08-13/EMENLA1600AN0001NOS.jpg'),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('12'),
                                Text('零钱'),
                              ],
                            ),
                          ),
                          VerticalDivider(
                            width: 1,
                            color: Colors.red,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('2383.0303883'),
                                Text('帑银资产'),
                              ],
                            ),
                          ),
                          VerticalDivider(
                            width: 1,
                            color: Colors.red,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('8892.884732'),
                                Text('纹银资产'),
                              ],
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
                    child: Text('桌面'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('总资产'),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('82828.82812'),
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
                                width: 30.0,
                                height: 30.0,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'http://pic-bucket.ws.126.net/photo/0001/2019-08-13/EMENLA1600AN0001NOS.jpg'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Align(
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Text(
                                        '丰都集团·区级地商',
                                      ),
                                      Positioned(
                                        top: 20,
                                        left: 0,
                                        child: Text('挥泪抛售,一降再降,卖完为止。'),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.topRight,
                                  heightFactor: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.topRight,
                            heightFactor: 2,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.directions_walk,
                                  size: 14,
                                ),
                                Text('天河区'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
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
                          child: Text('2393.02331239'),
                        ),
                        Text(
                          '日成交：',
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                          ),
                          child: Text('382.384742'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: Adapt.screenW() - Adapt.px(46),
                            maxHeight: 250,
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
                  Flex(
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
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return new Divider(
                        height: 1.0,
                        color: Colors.blue,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Stack(
                          children: <Widget>[
                            Icon(
                              Icons.account_balance,
                              size: 25,
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
