import 'package:flutter/material.dart';

import '../widgets/home_header.dart' show renderHomeAppBar;
import '../widgets/edit_text.dart' show EditText;
import '../widgets/button.dart' show Button;
import '../utils/localization.dart' show Localization;
import '../utils/theme.dart' as Theme;

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
      appBar: renderHomeAppBar(title: widget.title),
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
