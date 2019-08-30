import 'package:flutter/material.dart';

final EdgeInsets _titlePadding = EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0);

class HomeHeaderExpanded extends StatelessWidget {
  HomeHeaderExpanded({
    Key key,
    this.title = '',
    this.actions,
  }) : super(key: key);
  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 136.0,
      floating: false,
      pinned: true,
      elevation: 1.0,
      actions: this.actions,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: _titlePadding,
        title: Text(this.title,
          style: TextStyle(
            color: Theme.of(context).primaryTextTheme.title.color,
            fontSize: 16.0,
          ),
        ),
        background: Container(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

AppBar renderHomeAppBar({
  Key key,
  @required BuildContext context,
  String title = '',
  List<Widget> actions,
}) {
  return AppBar(
    elevation: 1.0,
    actions: actions,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: false,
      titlePadding: _titlePadding,
      title: Text(title,
        style: TextStyle(
          color: Theme.of(context).primaryTextTheme.title.color,
          fontSize: 16.0,
        ),
      ),
      background: Container(
        color: Theme.of(context).primaryColor,
      ),
    ),
  );
}