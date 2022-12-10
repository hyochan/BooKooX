import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/utils/asset.dart' as Asset;

class EditTextBox extends HookWidget {
  const EditTextBox({
    super.key,
    this.enabled = true,
    this.focusedColor = const Color.fromARGB(255, 66, 77, 107),
    this.enabledColor = const Color.fromARGB(255, 220, 226, 235),
    this.disabledColor = const Color.fromARGB(255, 211, 211, 211),
    this.leftImage,
    this.semanticLabel,
    this.margin = const EdgeInsets.only(top: 24.0),
    this.iconData,
    this.iconSize = 22.0,
    this.onChangeText,
    this.maxLength,
    this.maxLines = 1,
    this.textStyle,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    this.errorText,
    this.errorStyle = const TextStyle(
      color: Asset.Colors.carnation,
    ),
    this.controller,
    this.borderWidth = 0.7,
    this.borderStyle = BorderStyle.solid,
  });
  @override
  final bool enabled;
  final TextEditingController? controller;
  final Color? focusedColor;
  final Color? enabledColor;
  final Color disabledColor;
  final Image? leftImage;
  final String? semanticLabel;
  final EdgeInsets margin;
  final IconData? iconData;
  final double iconSize;
  final Function? onChangeText;
  final int? maxLength;
  final int maxLines;
  final TextStyle? textStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? errorText;
  final TextStyle errorStyle;
  final double borderWidth;
  final BorderStyle borderStyle;

  @override
  Widget build(BuildContext context) {
    FocusNode focus = FocusNode();

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        iconData != null
            ? Positioned(
                left: 12,
                bottom: 0,
                top: margin.top,
                child: Container(
                  child: Icon(
                    iconData,
                    color: enabledColor,
                    semanticLabel: semanticLabel,
                    size: iconSize,
                  ),
                ),
              )
            : Container(),
        Container(
          margin: margin,
          child: TextField(
            enabled: enabled,
            controller: controller,
            style: textStyle ??
                TextStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color),
            cursorColor: focusedColor,
            onChanged: onChangeText as void Function(String)?,
            maxLength: maxLength,
            focusNode: focus,
            maxLines: maxLines,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: labelText,
              labelStyle: labelStyle,
              focusColor: focusedColor,
              hintText: hintText,
              hintStyle: hintStyle ??
                  TextStyle(
                      color: Theme.of(context).textTheme.displaySmall!.color),
              errorText: errorText,
              errorStyle: errorStyle,
              contentPadding: EdgeInsets.only(
                left: iconData != null ? 48 : 16,
                top: 22,
                bottom: 22,
                right: 16,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.zero),
                borderSide: BorderSide(
                  color: focusedColor!,
                  width: borderWidth,
                  style: borderStyle,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.zero),
                borderSide: BorderSide(
                  color: enabledColor!,
                  width: borderWidth,
                  style: borderStyle,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.zero),
                borderSide: BorderSide(
                  color: disabledColor,
                  width: borderWidth,
                  style: borderStyle,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.zero),
                borderSide: BorderSide(
                  color: errorStyle.color!,
                  width: borderWidth,
                  style: borderStyle,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.zero),
                borderSide: BorderSide(
                  color: errorStyle.color!,
                  width: borderWidth,
                  style: borderStyle,
                ),
              ),
            ),
            autocorrect: false,
          ),
        ),
      ],
    );
  }
}
