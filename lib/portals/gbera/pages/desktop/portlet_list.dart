import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class PortletList extends StatefulWidget {
  PageContext context;

  PortletList({this.context});

  @override
  _PortletListState createState() => _PortletListState();
}

class _PortletListState extends State<PortletList> {
  @override
  Widget build(BuildContext context) {
    Desklet desklet = widget.context.parameters['desklet'];
    debugPrint('-----${desklet?.title}');
    var bb = widget.context.parameters['back_button'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.context.page?.title,
        ),
        titleSpacing: 0,
        elevation: 1.0,
        automaticallyImplyLeading: bb == null ? true : false,
        leading: getLeading(bb),
      ),
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('lib/portals/gbera/data/portlets.json'),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                widget.context.forward('/error',
                    arguments: {'error': 'Error: ${snapshot.error}'});
              }
              return _getPortletListView(snapshot, desklet);
            default:
              return null;
          }
        },
      ),
    );
  }

  getLeading(bb) {
    if (bb == null) return null;
    return IconButton(
      onPressed: () {
        widget.context.goBack();
      },
      icon: Icon(
        Icons.clear,
        size: 18,
      ),
    );
  }

  Widget _getPortletListView(AsyncSnapshot snapshot, Desklet desklet) {
    var data = snapshot.data;
    var list = jsonDecode(data);
    var portlets = [];
    for (var item in list) {
      if (desklet.url == item['deskletUrl']) {
        portlets.add(item);
      }
    }
    return ListView.separated(
        itemBuilder: (context, index) {
          var let = portlets[index];
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(
                top: 15,
                bottom: 15,
                left: 10,
                right: 10,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                          ),
                          child: Image.network(
                            let['imgSrc'],
                            fit: BoxFit.contain,
                            width: 30,
                            height: 30,
                            color: widget.context
                                .style('/desktop/desklets/settings.icon'),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 5,
                              ),
                              child: Text(
                                let['title'],
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              let['desc'],
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: let['renderMethod'] != 'nope',
                    activeColor: widget.context.style('/desktop/settings/portlet.activeColor'),
                    onChanged: (v) {
                      setState(() {
                        //刷新
                        if(v)
                        let['renderMethod']='nope';
                        else
                          let['renderMethod']='renderByPortletConfig';
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
            indent: 40,
          );
        },
        itemCount: portlets.length);
  }
}
