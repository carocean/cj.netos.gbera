import 'package:flutter/widgets.dart';
import 'package:gbera/gbera/common.dart';

class GeosphereDisplay extends StatefulWidget {
  final PageContext context;

  GeosphereDisplay({this.context});
  @override
  _GeosphereDisplayState createState() => _GeosphereDisplayState();
}

class _GeosphereDisplayState extends State<GeosphereDisplay> {
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
