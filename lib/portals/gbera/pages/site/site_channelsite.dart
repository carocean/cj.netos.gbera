import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class SiteChannelBinder extends StatelessWidget {
  PageContext context;

  SiteChannelBinder({this.context});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Text(
              '微站出口儿管道',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          Expanded(
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: _ChannelItem(
                    title: '地推',
                    imgSrc:
                        'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2948649887,2339419726&fm=26&gp=0.jpg',
                    imgCtx: [
                      'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2944276524,3804143005&fm=26&gp=0.jpg',
                      'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2218846181,4285029227&fm=26&gp=0.jpg',
                      'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2406240195,3794772291&fm=26&gp=0.jpg',
                      'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1440641638,1437420885&fm=26&gp=0.jpg',
                      'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1972199415,3618644349&fm=26&gp=0.jpg',
                    ],
                    onTap: () {
                      this.context.backward(result: {'select':'channel2'});
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 10,
                  ),
                ),
                SliverToBoxAdapter(
                  child: _ChannelItem(
                    title: '邮政客服',
                    imgSrc:
                        'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1874770391,2780961589&fm=26&gp=0.jpg',
                    imgCtx: [
                      'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2131900639,783782282&fm=26&gp=0.jpg',
                      'https://f12.baidu.com/it/u=3389538806,1178863563&fm=72',
                      'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2777017115,4260813476&fm=26&gp=0.jpg',
                    ],
                    onTap: () {
                      this.context.backward(result: {'select':'channel2'});
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChannelItem extends StatelessWidget {
  String title;
  String imgSrc;
  var imgCtx = <dynamic>[];
  var onTap;

  _ChannelItem({this.title, this.imgSrc, this.imgCtx, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 10,
        ),
        child: Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.network(
                    imgSrc,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      children: imgCtx.map((value) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                          ),
                          child: Image.network(
                            value,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
