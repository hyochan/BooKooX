import 'package:flutter/material.dart';

import '../utils/theme.dart' as Theme;

final EdgeInsets _titlePadding = EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0);

class HomeHeaderExpanded extends StatelessWidget {
  HomeHeaderExpanded({
    Key key,
    this.title = '',
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 136.0,
      floating: false,
      pinned: true,
      elevation: 1.0,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Icon(Icons.book),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Icon(Icons.add),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: _titlePadding,
        title: Text(this.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        background: Container(
          color: Theme.Colors.dusk,
        ),
      ),
    );
  }
}

AppBar renderHomeAppBar({
  Key key,
  String title = '',
}) {
  return AppBar(
    elevation: 1.0,
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Icon(Icons.add),
      ),
    ],
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: false,
      titlePadding: _titlePadding,
      title: Text(title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      background: Container(
        color: Theme.Colors.dusk,
      ),
    ),
  );
}