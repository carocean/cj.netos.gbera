import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/common/util.dart';
import 'package:gbera/portals/gbera/parts/parts.dart';

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
        id: 'home',
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
              name:
                  '华为 HUAWEI Mate 30 Pro 5G 麒麟990 OLED环幕屏双4000万徕卡电影四摄8GB+256GB丹霞橙5G全网通版',
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
        id: 'godown',
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
        id: 'goup',
        title: 'GoUP',
        categories: [
          Category(
            id: 'phone',
            title: '手机卖场',
          ),
          Category(
            id: 'liuxing',
            title: '女装卖场',
          ),
        ],
        merchandises: [
          _Merchandise(
              name:
                  '华为 HUAWEI Mate 30 Pro 5G 麒麟990 OLED环幕屏双4000万徕卡电影四摄8GB+256GB丹霞橙5G全网通版',
              category: 'phone',
              price: '99.00',
              sites: [
                _MerchantSite(
                    siteAvatar:
                        'https://g-search1.alicdn.com/img/bao/uploaded/i4//eb/1d/T19AHNFdJbXXb1upjX.jpg_140x140Q90.jpg',
                    siteTitle: '中国移动官方旗舰店'),
                _MerchantSite(
                    siteAvatar:
                        'https://g-search1.alicdn.com/img/bao/uploaded/i4//c4/13/TB1etCbSpXXXXcsXXXXSutbFXXX.jpg_140x140Q90.jpg',
                    siteTitle: 'Apple 产品京东自营旗舰店'),
              ],
              images: [
                'https://img11.360buyimg.com/n1/s450x450_jfs/t1/100072/19/531/218255/5dafcdf6E996f8eda/5ffdb56099d4da7c.jpg',
                'https://img11.360buyimg.com/n1/s450x450_jfs/t1/81012/28/13665/159765/5dafcdf7Eb247ff7f/c516fc4de783079c.jpg',
                'https://img11.360buyimg.com/n1/s450x450_jfs/t1/85120/6/577/92522/5dafcdf7E3ed87530/777b12adea1822f6.jpg',
                'https://img11.360buyimg.com/n1/s450x450_jfs/t1/85862/1/558/120277/5dafcdf8E2d92f14a/f0a5f500c3188252.jpg',
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
              name: 'Apple iPhone 11 (A2223) 128GB 黑色 移动联通电信4G手机 双卡双待',
              category: 'phone',
              images: [
                'https://img12.360buyimg.com/n1/s450x450_jfs/t1/59022/28/10293/141808/5d78088fEf6e7862d/68836f52ffaaad96.jpg',
                'https://img12.360buyimg.com/n1/s450x450_jfs/t1/61588/10/9949/164377/5d7808a1E6c3615dd/7c45f7039b9cbae8.jpg',
              ],
              desc: 'iPhoneXS系列性能强劲，样样出色，现特惠来袭，低至5599元。'),
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
  String id;
  List<Category> categories;
  List<_Merchandise> merchandises;

  _Page({this.id, this.title, this.categories, this.merchandises}) {
    if (this.categories == null) {
      this.categories = [];
    }
    if (this.merchandises == null) this.merchandises = [];
  }
}

class _MerchantSite {
  String siteTitle;
  String siteAvatar;

  _MerchantSite({this.siteTitle, this.siteAvatar});
}

///商品
class _Merchandise {
  String category;
  String name;
  String desc;
  List<String> images;
  List<_MerchantSite> sites;
  String price;
  int count;

  _Merchandise(
      {this.category,
      this.sites,
      this.name,
      this.desc,
      this.images,
      this.price,
      this.count}) {
    if (images == null) {
      this.images = [];
    }
    if (sites == null) {
      this.sites = [];
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

  _PageRegion({this.context, this.page, this.filter});

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
            if (widget.filter == null ||
                widget.filter ==
                    Category(
                      id: 'all',
                    )) {
              List<_Merchandise> merchandises = [];
              widget?.page?.merchandises?.forEach((m) {
                if (m?.category == category?.id) {
                  merchandises.add(m);
                }
              });
              return _CategoryRegion(
                pageid: widget.page.id,
                category: category,
                merchandises: merchandises,
                context: widget.context,
              );
            }
            if (widget.filter == category) {
              List<_Merchandise> merchandises = [];
              widget?.page?.merchandises?.forEach((m) {
                if (m?.category == category?.id) {
                  merchandises.add(m);
                }
              });
              return _CategoryRegion(
                context: widget.context,
                pageid: widget.page.id,
                category: category,
                merchandises: merchandises,
              );
            }
            return Container(
              height: 0,
              width: 0,
            );
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
                  }).then((result) {
                print('----$result');
                setState(() {
                  widget.filter = result['category'];
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
  String pageid;
  Category category;
  List<_Merchandise> merchandises;
  PageContext context;
  _CategoryRegion({this.context,this.pageid, this.category, this.merchandises});

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
            switch (widget.pageid) {
              case 'home':
                return _HomeRegion();
              case 'godown':
                return _GodownRegion();
              case 'goup':
                return _GoodsRegion(
                  merchandise: merchandise,
                  context: widget.context,
                );
              default:
                return Container(
                  height: 0,
                  width: 0,
                );
            }
          })?.toList(),
        ),
        Container(
          height: 10,
        ),
      ],
    );
  }
}

class _HomeRegion extends StatefulWidget {
  @override
  _HomeRegionState createState() => _HomeRegionState();
}

class _HomeRegionState extends State<_HomeRegion> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

///商家展窗
class _GodownRegion extends StatefulWidget {
  @override
  _GodownRegionState createState() => _GodownRegionState();
}

class _GodownRegionState extends State<_GodownRegion> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

///商品展窗
class _GoodsRegion extends StatefulWidget {
  _Merchandise merchandise;
  PageContext context;
  _GoodsRegion({this.merchandise,this.context});

  @override
  _GoodsRegionState createState() => _GoodsRegionState();
}

class _GoodsRegionState extends State<_GoodsRegion> {
  int title_maxLines = 2;
  int desc_maxLines = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                child: DefaultTabController(
                  length: widget.merchandise.images.length,
                  child: PageSelector(
                    images: widget.merchandise.images,
                    height: 150,
                    onImageTap: (url) {
                      widget.context.forward(
                        '/images/viewer',
                        arguments: {
                          'imgSrc': url,
                          'text': '',
                        },
                      );
                    },
                  ),
                ),
                padding: EdgeInsets.only(
                  bottom: 5,
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {},
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Text(
                                        '本轮离成交剩',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        text: '¥',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.red,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '382.34',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 5,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 5),
                                                  child: Text(
                                                    '买单',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                                Text.rich(
                                                  TextSpan(
                                                    text: '423',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.red,
                                                    ),
                                                    children: [],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 5),
                                                  child: Text(
                                                    '卖单',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                                Text.rich(
                                                  TextSpan(
                                                    text: '428',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.red,
                                                    ),
                                                    children: [],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: Text(
                                      '下单',
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.grey[400],
                                  ),
                                ],
                              ),
                            ],
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 3,
                            bottom: 3,
                          ),
                          child: Divider(
                            height: 1,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Wrap(
                            spacing: 10,
                            alignment: WrapAlignment.end,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Text(
                                        '实时现价',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        text: '¥',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.blueGrey[800],
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '4382.34',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.blueGrey[800],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Text(
                                        '商开均价',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        text: '¥',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '5999.00',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.blueGrey[800],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Text(
                                        '成交轮次',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        text: '243',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.blueGrey[800],
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '万',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                      TextSpan(
                        text: widget.merchandise.name ?? '',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              if (title_maxLines == 2) {
                                title_maxLines = 10;
                              } else {
                                title_maxLines = 2;
                              }
                            });
                          },
                      ),
                      maxLines: title_maxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: Text.rich(
                      TextSpan(
                        text: widget.merchandise.desc ?? '',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              if (desc_maxLines == 3) {
                                desc_maxLines = 10;
                              } else {
                                desc_maxLines = 3;
                              }
                            });
                          },
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      maxLines: desc_maxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: widget.merchandise.sites.map((site) {
                            return Image.network(
                              site.siteAvatar,
                              fit: BoxFit.fitHeight,
                              height: 20,
                            );
                          }).toList(),
                        ),
                      ),
                      fit: FlexFit.loose,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 5,
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              right: 0,
                            ),
                            child: Text(
                              '125个商家 上货1003个',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    ),
                  ],
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

