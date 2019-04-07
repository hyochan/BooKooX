import 'package:flutter/material.dart';

import '../widgets/edit_text.dart' show EditText;
import '../widgets/button.dart' show Button;
import '../utils/localization.dart' show Localization;
import '../utils/theme.dart' as Theme;

class HomeList extends StatefulWidget {
  HomeList({Key key}) : super(key: key);

  @override
  _HomeListState createState() => new _HomeListState();
}

class _HomeListState extends State<HomeList> {
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
