import 'package:flutter/material.dart';

import 'package:bookoo2/utils/general.dart' show General;
import 'package:bookoo2/shared/home_header.dart' show renderHomeAppBar;

class HomeStatistic extends StatefulWidget {
  HomeStatistic({
    Key key,
    this.title = '',
  }) : super(key: key);
  final String title;

  @override
  _HomeStatisticState createState() => new _HomeStatisticState();
}

class _HomeStatisticState extends State<HomeStatistic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderHomeAppBar(
        context: context,
        title: widget.title,
        actions: [
          Container(
            width: 56.0,
            child: RawMaterialButton(
              padding: EdgeInsets.all(0.0),
              shape: CircleBorder(),
              onPressed: () => General.instance.navigateScreenNamed(context, '/ledger_item_add'),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
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
