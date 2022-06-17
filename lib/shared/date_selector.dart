import 'package:flutter/material.dart';

class DateSelector extends StatelessWidget {
  final Function onDatePressed;
  final String date;
  DateSelector({required this.onDatePressed, required this.date});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 3, top: 32, bottom: 20),
      child: Row(
        children: <Widget>[
          FlatButton(
            onPressed: this.onDatePressed as void Function()?,
            child: Row(
              children: <Widget>[
                Text(
                  this.date,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_drop_down),
                  color: Colors.grey,
                  onPressed: onDatePressed as void Function()?,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
