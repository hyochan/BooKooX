import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({
    this.onClose, this.onSetting,
  });
  final Function onClose;
  final Function onSetting;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
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
      ),
    );
  }
}