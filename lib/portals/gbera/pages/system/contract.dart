import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gbera/netos/common.dart';

class UserContract extends StatelessWidget {
  PageContext context;

  UserContract({this.context});

  @override
  Widget build(BuildContext context) {
    var bb = this.context.parameters['back_button'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.context.page?.title,
        ),
        titleSpacing: 0,
        elevation: 1.0,
        automaticallyImplyLeading: bb == null ? true : false,
        leading: getLeading(bb),
      ),
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('lib/portals/gbera/data/user_constract'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return CustomScrollView(
            shrinkWrap: true,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                    bottom: 100,
                  ),
                  child: Text(
                    snapshot.data,
                    softWrap: true,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.only(bottom: 10,),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '广州点背信息科技有限公司',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  getLeading(bb) {
    if (bb == null) return null;
    return IconButton(
      onPressed: () {
        this.context.goBack();
      },
      icon: Icon(
        Icons.clear,
        size: 18,
      ),
    );
  }
}
