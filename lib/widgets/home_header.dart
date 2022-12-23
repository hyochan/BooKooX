import 'package:wecount/models/ledger_model.dart';
import 'package:flutter/material.dart';
import 'package:wecount/utils/asset.dart' as asset;
import 'package:wecount/utils/colors.dart';

var _titlePadding =
    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0);

class HomeHeaderExpanded extends StatelessWidget {
  const HomeHeaderExpanded({
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
      pinned: true,
      expandedHeight: 136.0,
      floating: false,
      elevation: 1.0,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: _titlePadding,
        title: SafeArea(
          right: false,
          child: Container(
            margin: const EdgeInsets.only(left: 3),
            child: Text(
              title,
              style: TextStyle(
                color: fontColor ?? Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        background: Container(
          color: color ?? asset.Colors.getColor(colorItems[4]),
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
          color: fontColor ?? AppColors.text.basic,
          fontSize: 16.0,
        ),
      ),
    ),
  );
}
