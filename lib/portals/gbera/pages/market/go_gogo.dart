import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/common/util.dart';

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
          fit: StackFit.loose,
          children: <Widget>[
            TabBarView(
              controller: _controller,
              children: _pages.map<Widget>((_Page page) {
                return Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: _PageRegion(
                    context: widget.context,
                    page: page,
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
        title: 'HoME',
        categories: [
          Category(
            id: 'all',
            title: '全部',
          ),
          Category(
            id: 'liuxing',
            title: '流行',
          ),
          Category(
            id: 'zhaoshang',
            title: '招商',
          ),
        ],
        merchandises: [
          _Merchandise(
              name: '超级至尊比萨1',
              category: 'liuxing',
              price: '99.00',
              images: [
                'https://img.4008123123.com/resource/VersionP/phdi/3_348.JPG',
                'https://img.4008123123.com/resource/VersionP/phdi/3_348.JPG'
              ],
              desc:
                  '腊肉肠、香肠、火腿、牛肉，搭配菠萝、蘑菇、洋葱、青椒等蔬菜水果，如此丰盛馅料，口口都是令人满足的好滋味。主要原料:面团、牛肉粒、猪肉粒、火腿、腊肉肠、芝士、蔬菜、菠萝、黑橄榄。铁盘个人装250克建议1人用，铁盘普通装440克建议2-3人用，铁盘大装880克建议3-4人用，芝心普通装570克建议2-3人用，大方薄底普通装390克建议2-3人用。'),
          _Merchandise(
              name: '超级至尊比萨1',
              category: 'liuxing',
              price: '82.25',
              images: [
                'https://img.4008123123.com/resource/VersionP/phdi/3_348.JPG'
              ],
              desc:
                  '腊肉肠、香肠、火腿、牛肉，搭配菠萝、蘑菇、洋葱、青椒等蔬菜水果，如此丰盛馅料，口口都是令人满足的好滋味。主要原料:面团、牛肉粒、猪肉粒、火腿、腊肉肠、芝士、蔬菜、菠萝、黑橄榄。铁盘个人装250克建议1人用，铁盘普通装440克建议2-3人用，铁盘大装880克建议3-4人用，芝心普通装570克建议2-3人用，大方薄底普通装390克建议2-3人用。'),
          _Merchandise(
              name: '超级至尊比萨2',
              category: 'zhaoshang',
              images: [
                'https://img.4008123123.com/resource/VersionP/phdi/3_348.JPG'
              ],
              desc:
                  '腊肉肠、香肠、火腿、牛肉，搭配菠萝、蘑菇、洋葱、青椒等蔬菜水果，如此丰盛馅料，口口都是令人满足的好滋味。主要原料:面团、牛肉粒、猪肉粒、火腿、腊肉肠、芝士、蔬菜、菠萝、黑橄榄。铁盘个人装250克建议1人用，铁盘普通装440克建议2-3人用，铁盘大装880克建议3-4人用，芝心普通装570克建议2-3人用，大方薄底普通装390克建议2-3人用。'),
        ],
      ),
      _Page(
        title: 'GoDOWN',
        categories: [
          Category(
            id: 'liuxing',
            title: '餐饮',
          ),
          Category(
            id: 'zhaoshang',
            title: '休闲',
          ),
        ],
        merchandises: [
          _Merchandise(
              name: '北味川菜馆',
              category: 'liuxing',
              price: '99.00',
              images: [
                'https://img.4008123123.com/resource/VersionP/phdi/3_348.JPG',
                'https://img.4008123123.com/resource/VersionP/phdi/3_348.JPG'
              ],
              desc:
                  '腊肉肠、香肠、火腿、牛肉，搭配菠萝、蘑菇、洋葱、青椒等蔬菜水果，如此丰盛馅料，口口都是令人满足的好滋味。主要原料:面团、牛肉粒、猪肉粒、火腿、腊肉肠、芝士、蔬菜、菠萝、黑橄榄。铁盘个人装250克建议1人用，铁盘普通装440克建议2-3人用，铁盘大装880克建议3-4人用，芝心普通装570克建议2-3人用，大方薄底普通装390克建议2-3人用。'),
          _Merchandise(
              name: '超级至尊比萨1',
              category: 'liuxing',
              price: '82.25',
              images: [
                'https://img.4008123123.com/resource/VersionP/phdi/3_348.JPG'
              ],
              desc:
                  '腊肉肠、香肠、火腿、牛肉，搭配菠萝、蘑菇、洋葱、青椒等蔬菜水果，如此丰盛馅料，口口都是令人满足的好滋味。主要原料:面团、牛肉粒、猪肉粒、火腿、腊肉肠、芝士、蔬菜、菠萝、黑橄榄。铁盘个人装250克建议1人用，铁盘普通装440克建议2-3人用，铁盘大装880克建议3-4人用，芝心普通装570克建议2-3人用，大方薄底普通装390克建议2-3人用。'),
          _Merchandise(
              name: '超级至尊比萨2',
              category: 'zhaoshang',
              images: [
                'https://img.4008123123.com/resource/VersionP/phdi/3_348.JPG'
              ],
              desc:
                  '腊肉肠、香肠、火腿、牛肉，搭配菠萝、蘑菇、洋葱、青椒等蔬菜水果，如此丰盛馅料，口口都是令人满足的好滋味。主要原料:面团、牛肉粒、猪肉粒、火腿、腊肉肠、芝士、蔬菜、菠萝、黑橄榄。铁盘个人装250克建议1人用，铁盘普通装440克建议2-3人用，铁盘大装880克建议3-4人用，芝心普通装570克建议2-3人用，大方薄底普通装390克建议2-3人用。'),
        ],
      ),
      _Page(
        title: 'GoUP',
        categories: [
          Category(
            id: 'liuxing',
            title: '女装卖场',
          ),
          Category(
            id: 'zhaoshang',
            title: '手机卖场',
          ),
        ],
        merchandises: [
          _Merchandise(
              name: '超级至尊比萨1',
              category: 'liuxing',
              price: '99.00',
              images: [
                'https://img.4008123123.com/resource/VersionP/phdi/3_348.JPG',
                'https://img.4008123123.com/resource/VersionP/phdi/3_348.JPG'
              ],
              desc:
                  '腊肉肠、香肠、火腿、牛肉，搭配菠萝、蘑菇、洋葱、青椒等蔬菜水果，如此丰盛馅料，口口都是令人满足的好滋味。主要原料:面团、牛肉粒、猪肉粒、火腿、腊肉肠、芝士、蔬菜、菠萝、黑橄榄。铁盘个人装250克建议1人用，铁盘普通装440克建议2-3人用，铁盘大装880克建议3-4人用，芝心普通装570克建议2-3人用，大方薄底普通装390克建议2-3人用。'),
          _Merchandise(
              name: '超级至尊比萨1',
              category: 'liuxing',
              price: '82.25',
              images: [
                'https://img.4008123123.com/resource/VersionP/phdi/3_348.JPG'
              ],
              desc:
                  '腊肉肠、香肠、火腿、牛肉，搭配菠萝、蘑菇、洋葱、青椒等蔬菜水果，如此丰盛馅料，口口都是令人满足的好滋味。主要原料:面团、牛肉粒、猪肉粒、火腿、腊肉肠、芝士、蔬菜、菠萝、黑橄榄。铁盘个人装250克建议1人用，铁盘普通装440克建议2-3人用，铁盘大装880克建议3-4人用，芝心普通装570克建议2-3人用，大方薄底普通装390克建议2-3人用。'),
          _Merchandise(
              name: '超级至尊比萨2',
              category: 'zhaoshang',
              images: [
                'https://img.4008123123.com/resource/VersionP/phdi/3_348.JPG'
              ],
              desc:
                  '腊肉肠、香肠、火腿、牛肉，搭配菠萝、蘑菇、洋葱、青椒等蔬菜水果，如此丰盛馅料，口口都是令人满足的好滋味。主要原料:面团、牛肉粒、猪肉粒、火腿、腊肉肠、芝士、蔬菜、菠萝、黑橄榄。铁盘个人装250克建议1人用，铁盘普通装440克建议2-3人用，铁盘大装880克建议3-4人用，芝心普通装570克建议2-3人用，大方薄底普通装390克建议2-3人用。'),
        ],
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
  List<Category> categories;
  List<_Merchandise> merchandises;

  _Page({this.title, this.categories, this.merchandises}) {
    if (this.categories == null) {
      this.categories = [];
    }
    if (this.merchandises == null) this.merchandises = [];
  }
}

///商品
class _Merchandise {
  String category;
  String name;
  String desc;
  List<String> images;
  String price;
  int count;

  _Merchandise(
      {this.category,
      this.name,
      this.desc,
      this.images,
      this.price,
      this.count}) {
    if (images == null) {
      this.images = [];
    }
  }
}

class Category {
  String id;
  String title;

  @override
  bool operator ==(other) {
    return id == other?.id;
  }

  @override
  int get hashCode {
    return id == null ? super.hashCode : id.hashCode;
  }

  Category({this.id, this.title});
}

class _PageRegion extends StatefulWidget {
  PageContext context;
  _Page page;
  Category filter;
  _PageRegion({this.context, this.page,this.filter});

  @override
  __PageRegionState createState() => __PageRegionState();
}

class __PageRegionState extends State<_PageRegion> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          children: widget.page.categories.map((category) {
            if(widget.filter==null||widget.filter==Category(id: 'all',)){
              List<_Merchandise> merchandises = [];
              widget?.page?.merchandises?.forEach((m) {
                if (m?.category == category?.id) {
                  merchandises.add(m);
                }
              });
              return _CategoryRegion(
                category: category,
                merchandises: merchandises,
              );
            }
            if(widget.filter==category){
              List<_Merchandise> merchandises = [];
              widget?.page?.merchandises?.forEach((m) {
                if (m?.category == category?.id) {
                  merchandises.add(m);
                }
              });
              return _CategoryRegion(
                category: category,
                merchandises: merchandises,
              );
            }
            return Container(height: 0,width: 0,);
          }).toList(),
        ),
        Positioned(
          right: 10,
          top: 6,
          child: GestureDetector(
            child: Icon(
              FontAwesomeIcons.filter,
              color: Colors.grey,
              size: 16,
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return widget.context.part(
                        '/goGOGO/category/filter', context,
                        arguments: <String, Object>{
                          'categories': widget.page.categories
                        });
                  }).then((result){
                    print('----$result');
                    setState(() {
                      widget.filter=result['category'];
                    });
              });
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryRegion extends StatefulWidget {
  Category category;
  List<_Merchandise> merchandises;

  _CategoryRegion({this.category, this.merchandises});

  @override
  __CategoryRegionState createState() => __CategoryRegionState();
}

class __CategoryRegionState extends State<_CategoryRegion> {
  @override
  Widget build(BuildContext context) {
    if (widget.merchandises.isEmpty) {
      return Container(
        height: 0,
        width: 0,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 5,
          ),
          child: Text(
            widget.category.title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.merchandises?.map((merchandise) {
//                          return _CategoryRegion(merchandise);
            return _MerchandiseRegion(
              merchandise: merchandise,
            );
          })?.toList(),
        ),
        Container(
          height: 20,
        ),
      ],
    );
  }
}

class _MerchandiseRegion extends StatefulWidget {
  _Merchandise merchandise;

  _MerchandiseRegion({this.merchandise});

  @override
  __MerchandiseRegionState createState() => __MerchandiseRegionState();
}

class __MerchandiseRegionState extends State<_MerchandiseRegion> {
  int maxLines = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Wrap(
                spacing: 10,
                children: widget.merchandise.images.length == 1
                    ? [
                        Image.network(
                          widget.merchandise.images[0],
                          fit: BoxFit.cover,
                        )
                      ]
                    : widget.merchandise.images.map((img) {
                        return Image.network(
                          img,
                          fit: BoxFit.cover,
                          width: Adapt.screenW() / 2 - 25,
                        );
                      }).toList(),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  TextSpan(
                    text: widget.merchandise.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(text: '  '),
                      TextSpan(
                        text: '¥${widget.merchandise.price ?? ''}',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Text.rich(
                  TextSpan(
                    text: widget.merchandise.desc ?? '',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          if (maxLines == 2) {
                            maxLines = 100;
                          } else {
                            maxLines = 2;
                          }
                        });
                      },
                  ),
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 10,
        ),
      ],
    );
  }
}
