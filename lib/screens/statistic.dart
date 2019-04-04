import 'package:flutter/material.dart';

import '../screens/my_drawer.dart' show MyDrawer;
import '../widgets/edit_text.dart' show EditText;
import '../widgets/button.dart' show Button;
import '../utils/localization.dart' show Localization;
import '../utils/theme.dart' as Theme;

class Statistic extends StatefulWidget {
  Statistic({Key key}) : super(key: key);

  @override
  _StatisticState createState() => new _StatisticState();
}

class _StatisticState extends State<Statistic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Theme.Colors.dusk,
        ),
      ),
      drawer: Drawer(
        child: MyDrawer(
          onClose: () => Navigator.of(context).pop(),
          onSetting: () => Navigator.of(context).pop(),
        ),
      ),
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
