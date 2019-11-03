import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class InSiteRequest extends StatelessWidget {
  PageContext context;

  InSiteRequest({this.context});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 5,
              bottom: 5,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        right: 5,
                      ),
                      child: Image.network(
                        'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2643559829,3576111536&fm=26&gp=0.jpg',
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: '来自',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          TextSpan(
                            text: '大飞果果',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w800,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                this.context.backward();
                                this.context.forward('/site/personal');
                              },
                          ),
                          TextSpan(
                            text: '的管道',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: '云台花园',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w800,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                this.context.backward();
                                this.context.forward('/channel/viewer');
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  '入站申请',
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 45,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('通过'),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5,
                                    ),
                                    child: Text('¥6.25'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('拒绝接收其信息'),
                              Row(
                                children: <Widget>[],
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
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
}
