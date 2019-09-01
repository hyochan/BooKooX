import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    this.key,
    this.text = '',
    this.image,
    this.width,
    this.height = 52.0,
    this.onPress,
    this.backgroundColor = Colors.white,
    this.margin = const EdgeInsets.only(left: 28.0, right: 28.0),
    this.borderWidth = 1.0,
    this.borderRadius = 0.0,
    this.borderColor = Colors.black54,
    this.textStyle = const TextStyle(
      color: Colors.black12,
    ),
  });

  final Key key;
  final String text;
  final Image image;
  final double width;
  final double height;
  final VoidCallback onPress;
  final Color backgroundColor;
  final EdgeInsets margin;
  final double borderWidth;
  final double borderRadius;
  final Color borderColor;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: this.key,
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              child: Container(child: image),
              left: 8.0,
            ),
            Container(
              child: Center(
                child: Text(
                  text,
                  style: textStyle,
                ),
              ),
            ),
          ],
        ),
        onPressed: onPress,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth, color: borderColor),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: backgroundColor,
      ),
      margin: margin,
      height: height,
      width:
          width != null ? width : MediaQuery.of(context).size.width,
    );
  }
}
