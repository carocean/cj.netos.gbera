import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/parts/CardItem.dart';

///区域市场
class GeoRegion extends StatefulWidget {
  PageContext context;

  GeoRegion({this.context});

  @override
  _GeoRegionState createState() => _GeoRegionState();
}

class _GeoRegionState extends State<GeoRegion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Text(
              widget.context.page.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            child: Divider(
              height: 1,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: CardItem(
                            title: '旺生堂金证银行',
                            subtitle: Text(
                              '涨:0.00001200002',
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.red[700],
                              ),
                            ),
                            titleColor: Colors.grey[800],
                            leading: Image.network(
                              'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=201729472,2326921524&fm=26&gp=0.jpg',
                              width: 30,
                              height: 30,
                            ),
                            tail: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[400],
                              size: 18,
                            ),
                            tipsText: '0.2838277773元/纹',
                          ),
                        ),
                        Divider(
                          height: 1,
                          indent: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: CardItem(
                            title: '千牛商家拆借交易所',
                            subtitle: Text(
                              '涨:0.08',
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.red[700],
                              ),
                            ),
                            titleColor: Colors.grey[800],
                            leading: Image.network(
                              'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=331142760,931679119&fm=26&gp=0.jpg',
                              height: 30,
                              width: 30,
                            ),
                            tail: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[400],
                              size: 16,
                            ),
                            tipsText: '2.17元/帑',
                          ),
                        ),
                        Divider(
                          height: 1,
                          indent: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: CardItem(
                            title: '元丰帑银交易所',
                            subtitle: Text(
                              '跌:0.12',
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.green[700],
                              ),
                            ),
                            titleColor: Colors.grey[800],
                            leading: Image.network(
                              'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2873093951,318547924&fm=26&gp=0.jpg',
                              height: 30,
                              width: 30,
                            ),
                            tail: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[400],
                              size: 16,
                            ),
                            tipsText: '1.61元/帑',
                          ),
                        ),
                      ],
                    ),
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
