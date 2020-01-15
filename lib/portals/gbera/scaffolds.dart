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
  var wallpaper;
  @override
  void initState() {
    super.initState();
    wallpaper = widget.context.sharedPreferences().getString('@.wallpaper');
    widget.context.parameters['use_wallpapper'] = StringUtil.isEmpty(wallpaper) ? false : true;

    parts.add(widget.context.part('/desktop', context,arguments:{'From-Page-Url': widget.context.page.url}));
    parts.add(widget.context.part('/netflow', context,arguments:{'From-Page-Url': widget.context.page.url}));
    parts.add(widget.context.part('/geosphere', context,arguments:{'From-Page-Url': widget.context.page.url}));
    parts.add(widget.context.part('/market', context,arguments:{'From-Page-Url': widget.context.page.url}));
  }
  @override
  void dispose() {
    parts.clear();
    selectedIndex=0;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    wallpaper = widget.context.sharedPreferences().getString('@.wallpaper');
    var use_wallpapper=widget.context.parameters['use_wallpapper'] = StringUtil.isEmpty(wallpaper) ? false : true;
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
