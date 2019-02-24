import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    this.text = '',
    this.image,
    this.width,
    this.height = 52.0,
    this.onPress,
    this.color = Colors.white,
    this.fontSize = 14.0,
    this.margin = const EdgeInsets.only(left: 28.0, right: 28.0),
  });

  final String text;
  final Image image;
  final double width;
  final double height;
  final VoidCallback onPress;
  final color;
  final double fontSize;
  final margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              child: Container(child: this.image),
              left: 2.0,
            ),
            Container(
              child: Center(
                child: Text(
                  this.text,
                  style: TextStyle(
                    color: this.color,
                    fontSize: this.fontSize,
                  ),
                ),
              ),
            ),
          ],
        ),
        onPressed: () {
          this.onPress();
        },
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: this.color),
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
      ),
      margin: this.margin,
      height: this.height,
      width:
          this.width != null ? this.width : MediaQuery.of(context).size.width,
    );
  }
}
