import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/common/voice_widget.dart';

import 'parts/bottoms.dart';

class WithBottomScaffold extends StatefulWidget {
  PageContext context;

  WithBottomScaffold({this.context});

  @override
  _WithBottomScaffoldState createState() => _WithBottomScaffoldState();
}

class _WithBottomScaffoldState extends State<WithBottomScaffold> {
  int selectedIndex = 0;
  var parts = <Widget>[];
  var wallpaper;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: this.selectedIndex);
    wallpaper = widget.context.sharedPreferences().getString('@.wallpaper');
    widget.context.parameters['use_wallpapper'] =
        StringUtil.isEmpty(wallpaper) ? false : true;

    parts.add(widget.context.part('/desktop', context,
        arguments: {'From-Page-Url': widget.context.page.url}));
    parts.add(widget.context.part('/netflow', context,
        arguments: {'From-Page-Url': widget.context.page.url}));
    parts.add(widget.context.part('/geosphere', context,
        arguments: {'From-Page-Url': widget.context.page.url}));
    parts.add(widget.context.part('/market', context,
        arguments: {'From-Page-Url': widget.context.page.url}));
  }

  @override
  void dispose() {
    parts.clear();
    selectedIndex = 0;
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    wallpaper = widget.context.sharedPreferences().getString('@.wallpaper');
    var use_wallpapper = widget.context.parameters['use_wallpapper'] =
        StringUtil.isEmpty(wallpaper) ? false : true;
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
        child: PageView(
          physics: NeverScrollableScrollPhysics(), //禁止页面左右滑动切换
          controller: _pageController,
          children: parts,
        ),
      ),
      bottomNavigationBar: GberaBottomNavigationBar(
        pageContext: widget.context,
        selectedIndex: selectedIndex,
        onSelected: (index) {
          setState(() {
            this.selectedIndex = index;
            this._pageController.jumpToPage(this.selectedIndex);
          });
        },
      ),
      floatingActionButton: selectedIndex == 2
          ? MyFloating():null,
    );
  }

}
class MyFloating extends StatefulWidget {
  @override
  _MyFloatingState createState() => _MyFloatingState();
}

class _MyFloatingState extends State<MyFloating> {
  var _hover=Colors.grey[500];
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: MyVoiceWidget(
        startRecord: () {
          print('-----startRecord');
          _hover=Colors.green;
          setState(() {

          });
        },
        stopRecord: (path, timelength,r,a) {
          _hover=Colors.grey[500];
          setState(() {

          });
          print('--voice-$path');
//                  if(a=='send') {
          r.play();
//                  }

        },
      ),
      backgroundColor: _hover,
    );
  }
}
