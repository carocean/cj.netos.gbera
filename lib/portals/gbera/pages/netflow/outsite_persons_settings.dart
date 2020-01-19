import 'package:flutter/material.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/parts/CardItem.dart';

class OutsitePersonsSettings extends StatefulWidget {
  PageContext context;

  OutsitePersonsSettings({this.context});

  @override
  _OutsitePersonsSettingsState createState() => _OutsitePersonsSettingsState();
}

class _OutsitePersonsSettingsState extends State<OutsitePersonsSettings> {
  OutsitePersonsSettingStrategy value;
  OutsitePersonsSettingStrategy group_value;

  @override
  void initState() {
    value = OutsitePersonsSettingStrategy.all_except;
    group_value = value;

    super.initState();
  }

  @override
  void dispose() {
    group_value = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('权限'),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 15,
              bottom: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    group_value = OutsitePersonsSettingStrategy.all_except;
                    setState(() {});
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        '所有公众除了',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Radio(
                          value: OutsitePersonsSettingStrategy.all_except,
                          groupValue: group_value,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    group_value = OutsitePersonsSettingStrategy.only_select;
                    setState(() {});
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        '仅限选定的公众',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Radio(
                          value: OutsitePersonsSettingStrategy.only_select,
                          groupValue: group_value,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              children: <Widget>[
                CardItem(
                  leading: Icon(
                    Icons.forward,
                  ),
                  paddingBottom: 10,
                  paddingTop: 10,
                  title: 'cj',
                  tail: Icon(
                    Icons.check,
                    color: Colors.red,
                  ),
                ),
                Divider(
                  height: 1,
                  indent: 0,
                ),
                CardItem(
                  leading: Icon(
                    Icons.person,
                  ),
                  paddingBottom: 10,
                  paddingTop: 10,
                  title: 'tom',
                  tail: Icon(
                    Icons.check,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum OutsitePersonsSettingStrategy {
  only_select,
  all_except,
}
