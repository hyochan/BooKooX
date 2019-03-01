import 'package:flutter/material.dart';
import '../utils/theme.dart' as Theme;

class EditText extends StatelessWidget {
  const EditText({
    this.key,
    this.focusNode,
    this.maxLines = 1,
    this.margin,
    this.padding,
    this.textLabel,
    this.labelStyle = const TextStyle(
      color: Theme.Colors.dusk,
      fontSize: 16.0,
      height: 0.7,
    ),
    this.textStyle = const TextStyle(
      fontSize: 16.0,
      color: Theme.Colors.dusk,
    ),
    this.textHint,
    this.hintStyle = const TextStyle(
      fontSize: 16.0,
      color: Theme.Colors.cloudyBlue,
    ),
    this.isSecret = false,
    this.hasChecked = false,
    this.showUnderline = true,
    this.textEditingController,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.textInputAction,
    this.obscureText = false,
  });

  final Key key;
  final FocusNode focusNode;
  final int maxLines;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final String textLabel;
  final TextStyle labelStyle;
  final TextStyle textStyle;
  final String textHint;
  final TextStyle hintStyle;
  final bool isSecret;
  final bool hasChecked;
  final bool showUnderline;
  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final VoidCallback onEditingComplete;
  final TextInputAction textInputAction;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    InputBorder _underlineBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.Colors.paleGray,
        width: 1.0,
      ),
    );

    return Container(
      margin: margin,
      padding: padding,
      child: Stack(
        children: <Widget>[
          TextField(
            key: this.key,
            obscureText: obscureText,
            focusNode: focusNode,
            maxLines: maxLines,
            controller: textEditingController,
            autofocus: true,
            style: textStyle,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            onEditingComplete: onEditingComplete,
            decoration: InputDecoration(
              focusedBorder: showUnderline
                  ? _underlineBorder
                  : InputBorder.none,
              labelText: textLabel,
              labelStyle: labelStyle,
              border: showUnderline
                  ? _underlineBorder
                  : InputBorder.none,
              hintText: textHint,
              hintStyle: hintStyle,
            ),
            textInputAction: textInputAction,
            autocorrect: false,
          ),
          hasChecked ? Positioned(
            right: 0.0,
            top: 16.0,
            child: Icon(
              Icons.check,
              color: Theme.Colors.dusk,
            ),
          ) : Container(),
        ],
      ),
    );
  }
}
