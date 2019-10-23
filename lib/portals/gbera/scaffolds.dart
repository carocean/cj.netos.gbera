import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gbera/netos/common.dart';

import 'parts/bottoms.dart';

class WithBottomScaffold extends StatefulWidget {
  PageContext context;

  WithBottomScaffold({this.context});

  @override
  _WithBottomScaffoldState createState() => _WithBottomScaffoldState();
}

class _WithBottomScaffoldState extends State<WithBottomScaffold> {
  int selectedIndex = 0;
  var parts = [];
  bool use_wallpapper=false;
  var wallpaper;

  @override
  void initState() {
    super.initState();
    wallpaper = widget.context.sharedPreferences().getString('@.wallpaper');
    use_wallpapper = StringUtil.isEmpty(wallpaper) ? false : true;
    widget.context.parameters['use_wallpapper'] = use_wallpapper;

    parts.add(widget.context.part('/desktop', widget.context));
    parts.add(widget.context.part('/netflow', widget.context));
    parts.add(widget.context.part('/geosphere', widget.context));
    parts.add(widget.context.part('/market', widget.context));
  }

  @override
  Widget build(BuildContext context) {
    wallpaper = widget.context.sharedPreferences().getString('@.wallpaper');
    use_wallpapper = StringUtil.isEmpty(wallpaper) ? false : true;
    return Scaffold(
//      appBar: headers[selectedIndex],
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: use_wallpapper
              ? DecorationImage(
                  image: AssetImage(wallpaper),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: parts[selectedIndex],
      ),
      bottomNavigationBar: GberaBottomNavigationBar(
        pageContext: widget.context,
        selectedIndex: selectedIndex,
        onSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
