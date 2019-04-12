import 'package:flutter/material.dart';

import '../widgets/home_header.dart' show renderHomeAppBar;
import '../widgets/edit_text.dart' show EditText;
import '../widgets/button.dart' show Button;
import '../utils/localization.dart' show Localization;
import '../utils/theme.dart' as Theme;

class HomeStatistic extends StatefulWidget {
  HomeStatistic({Key key}) : super(key: key);

  @override
  _HomeStatisticState createState() => new _HomeStatisticState();
}

class _HomeStatisticState extends State<HomeStatistic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderHomeAppBar(title: 'Dream Worker'),
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
