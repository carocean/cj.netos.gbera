import 'package:flutter/widgets.dart';
import 'package:gbera/netos/common.dart';

class Geosphere extends StatefulWidget {
  final PageContext context;

  Geosphere({this.context});
  @override
  _GeosphereState createState() => _GeosphereState();
}

class _GeosphereState extends State<Geosphere> {
  @override
  Widget build(BuildContext context) {
    //SliverPersistentHeaderDelegate 滑动可折叠头
    List<Widget> panel = [

    ];
    return SafeArea(
      child: CustomScrollView(
        slivers: panel,
      ),
    );
  }
}
