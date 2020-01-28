import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/parts/CardItem.dart';

class ContactSearchDelegate extends SearchDelegate {
  PageContext context;

  ContactSearchDelegate({this.context});

  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => '朋友';

  @override
  List<Widget> buildActions(BuildContext context) {
    //右侧显示内容 这里放清除按钮
    return [
      IconButton(
        tooltip: '清除',
        icon: const Icon(
          Icons.clear_all,
        ),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
      IconButton(
        tooltip: '添加好友',
        icon: const Icon(
          Icons.person_add,
        ),
        onPressed: () {
          this.context.forward('/portlet/chat/add_friend');
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //左侧显示内容 这里放了返回按钮
    return IconButton(
      tooltip: '返回',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
//点击了搜索窗显示的页面
    print('-----@buildSuggestions-----$query');
    //如果符合过滤条件则跳到结果页
//  showResults(context);
    return ContactList(
      query: query,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
//点击了搜索显示的页面
    print('-----@buildResults-----$query');
    return ContactList(
      query: query,
    );
  }
}

class ContactList extends StatefulWidget {
  String query;

  ContactList({this.query});

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  List<Friend> _friends;

  @override
  void initState() {
    _friends = [];
    _onLoad().then((v) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _friends.clear();
    super.dispose();
  }

  Future<Friend> _onLoad() async {
    for (var i = 0; i < 10; i++) {
      _friends.add(
        Friend(
          avatar:
              'http://47.105.165.186:7100/public/avatar/24f8e8d3f423d40b5b390691fbbfb5d7.jpg',
          name: 'Anson 老卢',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      onLoad: _onLoad,
      shrinkWrap: true,
      slivers: _friends.map((friend) {
        return SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                CardItem(
                  title: friend.name,
                  paddingLeft: 15,
                  paddingRight: 15,
                  paddingBottom: 10,
                  paddingTop: 10,
                  leading: ClipRRect(
                    child: Image.network(
                      '${friend.avatar}',
                      fit: BoxFit.cover,
                      width: 35,
                      height: 35,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                ),
                Divider(height: 1, indent: 60),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class Friend {
  String avatar;
  String name;

  Friend({this.avatar, this.name});
}
