import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class Gogogo extends StatefulWidget {
  PageContext context;

  Gogogo({this.context});

  @override
  _GogogoState createState() => _GogogoState();
}

class _GogogoState extends State<Gogogo> with SingleTickerProviderStateMixin {
  TabController _controller;
  List<_Page> _pages;

  @override
  void initState() {
    super.initState();
    _pages = _allPages();
    _controller = TabController(vsync: this, length: _pages.length);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _pages.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(
                widget.context.page.title,
              ),
              expandedHeight: 220.0,
              floating: false,
              pinned: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              actions: <Widget>[
                PopupMenuButton(
                  elevation: 0,
                  offset: Offset(20, 50),
//                  initialValue: 'myorders',
                  onSelected: (v) {
                    print('-----$v');
                  },
                  itemBuilder: (context) {
                    return <PopupMenuItem>[
                      PopupMenuItem(
                        child: Text('我的订单'),
                        value: 'myorders',
                      ),
                      PopupMenuItem(
                        child: Text('我的收藏'),
                        value: 'mycollects',
                      ),
                    ];
                  },
                ),
              ],
              leading: IconButton(
                icon: Icon(
                  Icons.clear,
                ),
                onPressed: () {
                  widget.context.backward();
                },
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Container(
                  margin: EdgeInsets.only(
                    bottom: 45,
                  ),
                  child: Image.network(
                    'https://f11.baidu.com/it/u=2675671810,782288130&fm=72',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              bottom: TabBar(
                controller: _controller,
                isScrollable: true,
                labelColor: Colors.black,
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                tabs: _pages.map<Tab>((_Page page) {
                  return Tab(
                    text: page.title,
                  );
                }).toList(),
              ),
            ),
          ];
        },
        body: Stack(
          children: <Widget>[
            TabBarView(
              controller: _controller,
              children: _pages.map<Widget>((_Page page) {
                return SafeArea(
                  top: false,
                  bottom: false,
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: _PageRegion(
                      context: widget.context,
                      page: page,
                    ),
                  ),
                );
              }).toList(),
            ),
            _ShoppingCartBar(
              onOpenCart: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return widget.context
                          .part('/market/shopping_cart', context);
                    });
              },
            ),
          ],
        ),
      ),
    );
  }

  List<_Page> _allPages() {
    return <_Page>[
      _Page(
        title: 'Home',
        categories: [
          _Category(
            title: '流行',
          ),
          _Category(
            title: '招商',
          ),
        ],
      ),
      _Page(
        title: 'GoDOWN',
      ),
      _Page(
        title: 'GoUP',
      ),
    ];
  }
}

class _ShoppingCartBar extends StatefulWidget {
  Function() onOpenCart;

  _ShoppingCartBar({this.onOpenCart});

  @override
  __ShoppingCartBarState createState() => __ShoppingCartBarState();
}

class __ShoppingCartBarState extends State<_ShoppingCartBar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onOpenCart,
        child: Container(
          padding: EdgeInsets.only(
            left: 15,
            right: 20,
            bottom: 10,
            top: 10,
          ),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0,
                ),
              ]),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Icon(
                  Icons.add_shopping_cart,
                  size: 20,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Page {
  String title;
  List<_Category> categories;

  _Page({this.title, this.categories}) {
    if (this.categories == null) {
      this.categories = [];
    }
  }
}

class _Category {
  String title;

  _Category({this.title});
}

class _PageRegion extends StatefulWidget {
  PageContext context;
  _Page page;

  _PageRegion({this.context, this.page});

  @override
  __PageRegionState createState() => __PageRegionState();
}

class __PageRegionState extends State<_PageRegion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[],
      ),
    );
  }
}
