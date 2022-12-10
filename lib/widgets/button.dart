import 'package:flutter/material.dart';
import 'package:wecount/utils/localization.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
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
  final MaterialStatePropertyAll<OutlinedBorder>? shapeBorder;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth, color: borderColor!),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: backgroundColor,
      ),
      margin: margin,
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      child: TextButton(
        style: ButtonStyle(
          shape: shapeBorder,
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(0.0),
          ),
        ),
        onPressed: !isLoading ? onPress : null,
        child: isLoading
            ? CircularProgressIndicator(
                semanticsLabel: Localization.of(context)!.trans('LOADING'),
                backgroundColor: Theme.of(context).primaryColor,
                strokeWidth: 3,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    left: imageMarginLeft,
                    child: Container(child: image),
                  ),
                  Container(
                    margin:
                        image == null ? null : const EdgeInsets.only(left: 12),
                    child: Center(
                      child: Text(
                        text!,
                        style: textStyle,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
