import 'package:flutter/material.dart';
import 'package:wecount/utils/localization.dart';

class Button extends StatelessWidget {
  const Button({
    this.key,
    this.text = '',
    this.image,
    this.width,
    this.imageMarginLeft = 12.0,
    this.height = 52.0,
    this.onPress,
    this.backgroundColor = Colors.white,
    this.margin = const EdgeInsets.only(left: 28.0, right: 28.0),
    this.borderWidth = 0.0,
    this.borderRadius = 0.0,
    this.borderColor = Colors.transparent,
    this.textStyle = const TextStyle(
      color: Colors.black12,
    ),
    this.shapeBorder,
    this.isLoading = false,
  });

  final Key? key;
  final String? text;
  final Image? image;
  final double? width;
  final double imageMarginLeft;
  final double height;
  final VoidCallback? onPress;
  final Color backgroundColor;
  final EdgeInsets margin;
  final double borderWidth;
  final double borderRadius;
  final Color? borderColor;
  final TextStyle textStyle;
  final ShapeBorder? shapeBorder;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: this.key,
      child: FlatButton(
        shape: shapeBorder,
        padding: EdgeInsets.all(0.0),
        child: isLoading
            ? CircularProgressIndicator(
                semanticsLabel: Localization.of(context)!.trans('LOADING'),
                backgroundColor: Theme.of(context).primaryColor,
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    child: Container(child: image),
                    left: this.imageMarginLeft,
                  ),
                  Container(
                    margin:
                        this.image == null ? null : EdgeInsets.only(left: 12),
                    child: Center(
                      child: Text(
                        text!,
                        style: textStyle,
                      ),
                    ),
                  ),
                ],
              ),
        onPressed: !isLoading ? onPress : null,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth, color: borderColor!),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: backgroundColor,
      ),
      margin: margin,
      height: height,
      width: width != null ? width : MediaQuery.of(context).size.width,
    );
  }
}
