import 'package:flutter/material.dart';

class TabPageView {
  String title;
  Widget view;

  TabPageView({
    this.title,
    this.view,
  });
}

class ContractDescPageView extends StatefulWidget {
  @override
  _ContractDescPageViewState createState() => _ContractDescPageViewState();
}

class _ContractDescPageViewState extends State<ContractDescPageView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('我来了'),
    );
  }
}
