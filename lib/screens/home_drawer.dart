import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({
    this.onClose, this.onSetting,
  });
  final Function onClose;
  final Function onSetting;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 24.0),
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          width: double.infinity,
          height: 56.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                iconSize: 24.0,
                onPressed: onClose,
              ),
              IconButton(
                icon: Icon(Icons.settings),
                iconSize: 24.0,
                onPressed: onSetting,
              ),
            ],
          ),
        ),
      ],
    );
  }
}