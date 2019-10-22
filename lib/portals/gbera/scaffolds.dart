import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gbera/netos/common.dart';

import 'parts/bottoms.dart';

class WithBottomScaffold extends StatefulWidget {
  PageContext context;
  var use_wallpapper; //是否使用墙纸的开关
  WithBottomScaffold({this.context, this.use_wallpapper = true});

  @override
  _WithBottomScaffoldState createState() => _WithBottomScaffoldState();
}

class _WithBottomScaffoldState extends State<WithBottomScaffold> {
  int selectedIndex = 0;
  var parts = [];

  @override
  void initState() {
    super.initState();
    widget.context.parameters['use_wallpapper']=widget.use_wallpapper;
    parts.add(widget.context.part('/desktop', widget.context));
    parts.add(widget.context.part('/netflow', widget.context));
    parts.add(widget.context.part('/geosphere', widget.context));
    parts.add(widget.context.part('/market', widget.context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: headers[selectedIndex],
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: widget.use_wallpapper
              ? DecorationImage(
                  image: NetworkImage(
                      'http://ku.90sjimg.com/back_pic/05/39/03/755a5213bd7e696.jpg%21/fwfh/804x1206/quality/90/unsharp/true/compress/true/watermark/text/OTDorr7orqE=/font/simkai/align/southeast/opacity/20/size/50'),
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
