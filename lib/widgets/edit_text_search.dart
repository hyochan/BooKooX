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
    this.textInputAction,
    this.keyboardType = TextInputType.text,
    this.maxLength,
  });

  final TextEditingController? controller;
  final txtLabel;
  final txtHint;
  final txtHintStyle;
  final decoration;
  final ValueChanged<String>? onChanged;
  final onSubmit;
  final secure;
  final txtStyle;
  final borderRadius;
  final margin;
  final padding;
  final underline;
  final background;
  final enabled;
  final height;
  final width;
  final textInputAction;
  final keyboardType;
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
          margin: this.margin,
          height: this.height,
          width: this.width,
          decoration: this.decoration,
        ),
        Container(
          margin: this.padding,
          child: TextField(
            maxLength: this.maxLength,
            onSubmitted: this.onSubmit,
            keyboardType: this.keyboardType,
//            textInputAction: this.textInputAction != null ? this.textInputAction : TextInputAction.done,
            enabled: this.enabled,
            controller: this.controller,
            style: this.txtStyle,
            onChanged: this.onChanged,
            decoration: inputDecoration,
            autocorrect: false,
          ),
        ),
      ],
    );
  }
}
