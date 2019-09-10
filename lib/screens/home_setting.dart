import 'package:flutter/material.dart';

import 'package:bookoo2/shared/home_header.dart' show renderHomeAppBar;
import 'package:bookoo2/utils/general.dart' show General;

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
        actions: <Widget>[
          Container(
            width: 56.0,
            child: RawMaterialButton(
              padding: EdgeInsets.all(0.0),
              shape: CircleBorder(),
              onPressed: () => General.instance.navigateScreenNamed(
                context, '/ledger_item_add',
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
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
