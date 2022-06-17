import 'package:flutter/material.dart';
import 'package:wecount/utils/asset.dart' as Asset;

class EditTextBox extends StatefulWidget {
  const EditTextBox({
    this.key,
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
  final Key? key;
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
  _EditTextBoxState createState() => _EditTextBoxState();
}

class _EditTextBoxState extends State<EditTextBox> {
  FocusNode _focus = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        widget.iconData != null
            ? Positioned(
                left: 12,
                bottom: 0,
                top: widget.margin.top,
                child: Container(
                  child: Icon(
                    widget.iconData,
                    color: widget.enabledColor,
                    semanticLabel: widget.semanticLabel,
                    size: widget.iconSize,
                  ),
                ),
              )
            : Container(),
        Container(
          child: TextField(
            enabled: widget.enabled,
            controller: widget.controller,
            style: widget.textStyle ??
                TextStyle(color: Theme.of(context).textTheme.headline1!.color),
            cursorColor: widget.focusedColor,
            onChanged: widget.onChangeText as void Function(String)?,
            maxLength: widget.maxLength,
            focusNode: _focus,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: widget.labelText,
              labelStyle: widget.labelStyle,
              focusColor: widget.focusedColor,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  TextStyle(
                      color: Theme.of(context).textTheme.headline3!.color),
              errorText: widget.errorText,
              errorStyle: widget.errorStyle,
              contentPadding: EdgeInsets.only(
                left: widget.iconData != null ? 48 : 16,
                top: 22,
                bottom: 22,
                right: 16,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.zero),
                borderSide: BorderSide(
                  color: widget.focusedColor!,
                  width: widget.borderWidth,
                  style: widget.borderStyle,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.zero),
                borderSide: BorderSide(
                  color: widget.enabledColor!,
                  width: widget.borderWidth,
                  style: widget.borderStyle,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.zero),
                borderSide: BorderSide(
                  color: widget.disabledColor,
                  width: widget.borderWidth,
                  style: widget.borderStyle,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.zero),
                borderSide: BorderSide(
                  color: widget.errorStyle.color!,
                  width: widget.borderWidth,
                  style: widget.borderStyle,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.zero),
                borderSide: BorderSide(
                  color: widget.errorStyle.color!,
                  width: widget.borderWidth,
                  style: widget.borderStyle,
                ),
              ),
            ),
            autocorrect: false,
          ),
          margin: widget.margin,
        ),
      ],
    );
  }
}
