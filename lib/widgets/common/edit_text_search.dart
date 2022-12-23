import 'package:flutter/material.dart';

class EditTextSearch extends StatelessWidget {
  const EditTextSearch({
    super.key,
    this.controller,
    this.txtLabel,
    this.txtHint,
    this.txtHintStyle,
    this.onChanged,
    this.onSubmit,
    this.secure = false,
    this.txtStyle = const TextStyle(
      color: Color.fromRGBO(74, 74, 74, 1.0),
      fontSize: 14.0,
    ),
    this.decoration,
    this.borderRadius = 4.0,
    this.margin = const EdgeInsets.only(top: 0.0),
    this.padding = const EdgeInsets.all(0.0),
    this.underline = true,
    this.background = Colors.white,
    this.enabled = true,
    this.height,
    this.width = double.infinity,
    // this.textInputAction,
    this.keyboardType = TextInputType.text,
    this.maxLength,
  });

  final TextEditingController? controller;
  final String? txtLabel;
  final String? txtHint;
  final TextStyle? txtHintStyle;
  final Decoration? decoration;
  final ValueChanged<String>? onChanged;
  final Function(String)? onSubmit;
  final bool secure;
  final TextStyle? txtStyle;
  final double borderRadius;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool underline;
  final Color background;
  final bool? enabled;
  final double? height;
  final double width;
  // final textInputAction;
  final TextInputType? keyboardType;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration;
    if (underline) {
      inputDecoration = InputDecoration(
        hintText: txtHint,
        labelText: txtLabel,
        hintStyle: txtHintStyle,
      );
    } else {
      inputDecoration = InputDecoration(
        hintText: txtHint,
        labelText: txtLabel,
        hintStyle: txtHintStyle,
        border: InputBorder.none,
      );
    }
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: margin,
          height: height,
          width: width,
          decoration: decoration,
        ),
        Container(
          margin: padding,
          child: TextField(
            maxLength: maxLength,
            onSubmitted: onSubmit,
            keyboardType: keyboardType,
//            textInputAction: this.textInputAction != null ? this.textInputAction : TextInputAction.done,
            enabled: enabled,
            controller: controller,
            style: txtStyle,
            onChanged: onChanged,
            decoration: inputDecoration,
            autocorrect: false,
          ),
        ),
      ],
    );
  }
}
