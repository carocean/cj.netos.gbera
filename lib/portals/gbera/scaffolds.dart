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

  @override
  void initState() {
    super.initState();
    parts.add(widget.context.part('gbera://desktop',widget.context));
    parts.add(widget.context.part('gbera://netflow',widget.context));
    parts.add(widget.context.part('gbera://geosphere',widget.context));
    parts.add(widget.context.part('gbera://market',widget.context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: headers[selectedIndex],
      body: parts[selectedIndex],
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
