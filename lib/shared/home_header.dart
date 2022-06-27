import 'package:wecount/models/ledger.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

final EdgeInsets _titlePadding =
    EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0);

class HomeHeaderExpanded extends StatelessWidget {
  HomeHeaderExpanded({
    Key? key,
    this.title = '',
    this.actions,
    this.color,
    this.fontColor,
  }) : super(key: key);

  final String title;
  final List<Widget>? actions;
  final Color? color;
  final Color? fontColor;

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
        title: SafeArea(
          right: false,
          child: Container(
            margin: EdgeInsets.only(left: 3),
            child: Text(
              this.title,
              style: TextStyle(
                color: fontColor ?? Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        background: Container(
          color: this.color != null ? color : getColor(colorItems[4]),
        ),
      ),
    );
  }
}

AppBar renderHomeAppBar({
  Key? key,
  required BuildContext context,
  String title = '',
  List<Widget>? actions,
  Color? color,
  Color? fontColor,
}) {
  return AppBar(
    elevation: 1.0,
    actions: actions,
    backgroundColor: color,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: false,
      titlePadding: _titlePadding,
      title: Text(
        title,
        style: TextStyle(
          color: fontColor ?? Theme.of(context).textTheme.headline1!.color,
          fontSize: 16.0,
        ),
      ),
    ),
  );
}
