import 'package:flutter/material.dart';

class DateSelector extends StatelessWidget {
  final Function onDatePressed;
  final String date;
  DateSelector({@required this.onDatePressed, @required this.date});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          /// todo: make a better clickable effect
          InkWell(
            onTap: this.onDatePressed,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                this.date,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_drop_down),
            color: Colors.grey,
            onPressed: onDatePressed,
          ),
        ],
      ),
    );
  }
}
