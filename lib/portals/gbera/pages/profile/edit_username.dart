import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';

class EditUserName extends StatefulWidget {
  PageContext context;

  EditUserName({this.context});

  @override
  _EditUserNameState createState() => _EditUserNameState();
}

class _EditUserNameState extends State<EditUserName> {
  @override
  Widget build(BuildContext context) {
    var bb = widget.context.page.parameters['back_button'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.context.page?.title,
        ),
        titleSpacing: 0,
        elevation: 0,
        automaticallyImplyLeading: bb == null ? true : false,
        leading: getLeading(bb),
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: TextField(
                      decoration:
                          InputDecoration(labelText: '姓名', hintText: '输入姓名'),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text('确认'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getLeading(bb) {
    if (bb == null) return null;
    return IconButton(
      onPressed: () {
        widget.context.backward();
      },
      icon: Icon(
        Icons.clear,
        size: 18,
      ),
    );
  }
}
