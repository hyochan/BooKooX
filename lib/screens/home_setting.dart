import 'package:flutter/material.dart';

import '../shared/home_header.dart' show renderHomeAppBar;

class HomeSetting extends StatefulWidget {
  HomeSetting({
    Key key,
    this.title = '',
  }) : super(key: key);
  final String title;

  @override
  _HomeSettingState createState() => new _HomeSettingState();
}

class _HomeSettingState extends State<HomeSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderHomeAppBar(
        context: context,
        title: widget.title,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.only(top: 44.0, left: 60.0, right: 60.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
