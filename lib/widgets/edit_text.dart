import 'package:flutter/material.dart';

class EditText extends StatelessWidget {
  const EditText({
    super.key,
    this.focusNode,
    this.maxLines = 1,
    this.margin,
    this.padding,
    this.textLabel,
    this.labelStyle = const TextStyle(
      fontSize: 16.0,
      height: 0.7,
    ),
    this.textStyle = const TextStyle(
      fontSize: 16.0,
    ),
    this.textHint,
    this.hintStyle = const TextStyle(
      fontSize: 16.0,
    ),
    this.errorText,
    this.errorStyle = const TextStyle(
      fontSize: 12.0,
      color: Colors.red,
    ),
    this.isSecret = false,
    this.hasChecked = false,
    this.showUnderline = true,
    this.textEditingController,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.textInputAction,
  });

  @override
  final FocusNode? focusNode;
  final int maxLines;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String? textLabel;
  final TextStyle labelStyle;
  final TextStyle textStyle;
  final String? textHint;
  final TextStyle hintStyle;
  final String? errorText;
  final TextStyle errorStyle;
  final bool isSecret;
  final bool hasChecked;
  final bool showUnderline;
  final TextEditingController? textEditingController;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    InputBorder underlineBorderFocused = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).textTheme.displayLarge!.color!,
        width: 1.0,
      ),
    );

    InputBorder underlineBorderUnfocused = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).disabledColor,
        width: 0.7,
      ),
    );

    return Container(
      margin: margin,
      padding: padding,
      child: Stack(
        children: <Widget>[
          TextField(
            key: key,
            obscureText: isSecret,
            focusNode: focusNode,
            maxLines: maxLines,
            controller: textEditingController,
            autofocus: true,
            style: textStyle,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            onEditingComplete: onEditingComplete,
            decoration: InputDecoration(
              focusedBorder:
                  showUnderline ? underlineBorderFocused : InputBorder.none,
              labelText: textLabel,
              labelStyle: labelStyle,
              enabledBorder:
                  showUnderline ? underlineBorderUnfocused : InputBorder.none,
              hintText: textHint,
              hintStyle: hintStyle,
              errorText: errorText,
              errorStyle: errorStyle,
            ),
            textInputAction: textInputAction,
            autocorrect: false,
          ),
          hasChecked
              ? const Positioned(
                  right: 0.0,
                  top: 16.0,
                  child: Icon(
                    Icons.check,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
