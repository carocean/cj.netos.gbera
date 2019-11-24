import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:gbera/netos/common.dart';

class TZList extends StatefulWidget {
  PageContext context;

  TZList({this.context});

  @override
  _TZListState createState() => _TZListState();
}

class _TZListState extends State<TZList> {
  double zxWidth = 70;
  double zfWidth = 60;
  double zdWidth = 50;
  List<_TYMarket> _marketList = [];

  @override
  void initState() {
    super.initState();
    _marketList = _allMarkets();
  }

  @override
  void dispose() {
    super.dispose();
    _marketList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: Text(
          widget.context.page.title,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
          ),
          onPressed: () {
            widget.context.backward();
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
              ),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '帑指交易所',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: zxWidth,
                    child: Text(
                      '标的',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: zfWidth,
                    child: Text(
                      '涨幅',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: zdWidth,
                    child: Text(
                      '涨跌',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 10,
              ),
              child: Divider(
                height: 1,
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(
                  top: 10,
                ),
                children: _marketList.map((item) {
                  return _TYMarketRowView(
                    zdWidth: zdWidth,
                    zfWidth: zfWidth,
                    zxWidth: zxWidth,
                    tyMarket: item,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<_TYMarket> _allMarkets() {
    return [
      _TYMarket(
        title: '东方之珠',
        avatar:
            'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2873093951,318547924&fm=26&gp=0.jpg',
        subtitle: '广东·帑指交易所',
        zd: 24.12,
        zf: 0.84,
        bdTYMarketZX: 2885.29,
        bdTYMarketName: '元丰',
      ),
      _TYMarket(
        title: '卓玛',
        avatar:
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1574586017963&di=93ba1695e47be69c6aaf6d83359f05de&imgtype=0&src=http%3A%2F%2Fpic34.nipic.com%2F20131023%2F13997442_154947337000_2.jpg',
        subtitle: '北京·帑指交易所',
        zd: -11.31,
        zf: -0.64,
        bdTYMarketZX: 2897.64,
        bdTYMarketName: '马恩河谷',
      ),
      _TYMarket(
        title: '谷元春',
        avatar:
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1574586324784&di=fd32ca70cc438a9f5814b4ee6fdaee70&imgtype=0&src=http%3A%2F%2Fpic31.nipic.com%2F20130710%2F12886433_124405333000_2.jpg',
        subtitle: '湖南·帑指交易所',
        zd: 2.98,
        zf: 0.37,
        bdTYMarketZX: 1923.11,
        bdTYMarketName: '德怀天下',
      ),
    ];
  }
}

class _TYMarket {
  String title;
  String subtitle;
  String avatar;
  String bdTYMarketName;
  double zf;
  double zd;
  double bdTYMarketZX;
  _TYMarket(
      {this.title, this.subtitle, this.avatar, this.bdTYMarketName, this.zf, this.zd,this.bdTYMarketZX});
}

class _TYMarketRowView extends StatefulWidget {
  double zxWidth = 70;
  double zfWidth = 60;
  double zdWidth = 50;
  _TYMarket tyMarket;

  _TYMarketRowView({this.zxWidth, this.zfWidth, this.zdWidth, this.tyMarket});

  @override
  _TYMarketRowViewState createState() => _TYMarketRowViewState();
}

class _TYMarketRowViewState extends State<_TYMarketRowView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                          right: 5,
                        ),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.network(
                            widget.tyMarket.avatar,
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: widget.tyMarket.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(text: '\r\n'),
                            TextSpan(
                              text: widget.tyMarket.subtitle,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: widget.zxWidth,
                child: Text.rich(
                  TextSpan(
                    text: '${widget.tyMarket.bdTYMarketZX.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: _getColor(),
                    ),
                    children: [
                      TextSpan(
                        text: '\r\n',
                      ),
                      TextSpan(
                        text: '${widget.tyMarket.bdTYMarketName ?? ''}·帑指',
                        style: TextStyle(
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: widget.zfWidth,
                child: Text(
                  '${widget.tyMarket.zf.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: _getColor(),
                  ),
                ),
              ),
              SizedBox(
                width: widget.zdWidth,
                child: Text(
                  '${widget.tyMarket.zd.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: _getColor(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Divider(
            height: 1,
            indent: 45,
            color: Colors.black12,
          ),
        ),
      ],
    );
  }

  _getColor() {
    double zf = widget.tyMarket.zf;
    if (zf == 0) {
      return Colors.black;
    }
    if (zf < 0) {
      return Colors.green;
    }
    return Colors.red;
  }
}