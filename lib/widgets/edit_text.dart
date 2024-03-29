import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/utils/colors.dart';
import 'package:wecount/utils/styles.dart';

class EditText extends StatelessWidget {
  final FocusNode? focusNode;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String label;
  final int minLines;
  final int maxLines;
  final InputDecoration? inputDecoration;
  final TextStyle? labelStyle;
  final TextStyle textStyle;
  final String? textHint;
  final Color? cursorColor;
  final TextStyle hintStyle;
  final String errorText;
  final TextStyle errorStyle;
  final bool isSecret;
  final bool hasChecked;
  final bool showBorder;
  final TextInputType? keyboardType;
  final TextEditingController? textEditingController;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Widget? prefixIcon;
  final bool enabled;
  final bool readOnly;

  const EditText({
    Key? key,
    this.focusNode,
    this.margin,
    this.padding,
    this.label = '',
    this.textHint,
    this.cursorColor,
    this.errorText = '',
    this.textEditingController,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.textInputAction,
    this.validator,
    this.keyboardType,
    this.isSecret = false,
    this.hasChecked = false,
    this.showBorder = true,
    this.minLines = 1,
    this.maxLines = 1,
    this.inputDecoration,
    this.labelStyle,
    this.textStyle = const TextStyle(
      fontSize: 16.0,
    ),
    this.hintStyle = const TextStyle(
      fontSize: 16.0,
    ),
    this.errorStyle = const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ),
    this.onTap,
    this.prefixIcon,
    this.enabled = true,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder focusedOutlineBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: AppColors.text.defaultColor),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );

    OutlineInputBorder outlineBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.text.placeholder),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );

    OutlineInputBorder disableBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.bg.border),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );

    OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: AppColors.role.danger),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );

    OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.role.danger),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );

    return Container(
      margin: margin,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    label,
                    style: InputLabelTextStyle().merge(labelStyle),
                  ),
                )
              : const SizedBox(),
          Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              TextField(
                key: key,
                keyboardType: keyboardType,
                obscureText: isSecret,
                focusNode: focusNode,
                minLines: minLines,
                cursorColor: cursorColor,
                maxLines: maxLines,
                controller: textEditingController,
                onSubmitted: onSubmitted,
                enabled: enabled,
                readOnly: readOnly,

                /// Set default [InputDecoration] below instead of constructor
                /// because we need to apply optional parameters given in other props.
                ///
                /// You can pass [inputDecoration] to replace default [InputDecoration].
                decoration: inputDecoration ??
                    InputDecoration(
                      prefixIcon: prefixIcon,
                      focusColor: AppColors.text.defaultColor,
                      fillColor: !enabled
                          ? AppColors.text.disabled
                          : AppColors.text.primary,
                      filled: !enabled,
                      disabledBorder:
                          showBorder ? disableBorder : InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                      focusedBorder:
                          showBorder ? focusedOutlineBorder : InputBorder.none,
                      enabledBorder:
                          showBorder ? outlineBorder : InputBorder.none,
                      errorBorder: showBorder ? errorBorder : InputBorder.none,
                      focusedErrorBorder:
                          showBorder ? focusedErrorBorder : InputBorder.none,
                      hintText: textHint,
                      hintStyle: hintStyle,
                      errorText: errorText.isEmpty ? null : errorText,
                      errorStyle: errorStyle,
                    ),
                autofocus: true,
                style: textStyle,
                onChanged: onChanged,
                onEditingComplete: onEditingComplete,
                textInputAction: textInputAction,
                onTap: onTap,
                autocorrect: false,
              ),
              hasChecked
                  ? const Positioned(
                      right: 8.0,
                      top: 12.0,
                      child: Icon(
                        Icons.check,
                      ),
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }
}

class EditFormText extends StatelessWidget {
  final FocusNode? focusNode;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String label;
  final int minLines;
  final int maxLines;
  final InputDecoration? inputDecoration;
  final TextStyle? labelStyle;
  final TextStyle textStyle;
  final String? textHint;
  final Color? cursorColor;
  final TextStyle hintStyle;
  final String errorText;
  final TextStyle errorStyle;
  final bool isSecret;
  final bool hasChecked;
  final bool showBorder;
  final TextInputType? keyboardType;
  final TextEditingController? textEditingController;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Widget? prefixIcon;
  final bool enabled;
  final bool readOnly;

  const EditFormText({
    Key? key,
    this.focusNode,
    this.margin,
    this.padding,
    this.label = '',
    this.textHint,
    this.cursorColor,
    this.errorText = '',
    this.textEditingController,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.textInputAction,
    this.validator,
    this.keyboardType,
    this.isSecret = false,
    this.hasChecked = false,
    this.showBorder = true,
    this.minLines = 1,
    this.maxLines = 1,
    this.inputDecoration,
    this.labelStyle,
    this.textStyle = const TextStyle(
      fontSize: 16.0,
    ),
    this.hintStyle = const TextStyle(
      fontSize: 16.0,
    ),
    this.errorStyle = const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ),
    this.onTap,
    this.prefixIcon,
    this.enabled = true,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder focusedOutlineBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: AppColors.text.defaultColor),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );

    OutlineInputBorder outlineBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.text.placeholder),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );

    OutlineInputBorder disableBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.bg.border),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );

    OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: AppColors.role.danger),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );

    OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.role.danger),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );

    return Container(
      margin: margin,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    label,
                    style: InputLabelTextStyle().merge(labelStyle),
                  ),
                )
              : const SizedBox(),
          Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              TextFormField(
                key: key,
                validator: validator,
                keyboardType: keyboardType,
                obscureText: isSecret,
                focusNode: focusNode,
                minLines: minLines,
                cursorColor: cursorColor,
                maxLines: maxLines,
                controller: textEditingController,
                enabled: enabled,
                readOnly: readOnly,

                /// Set default [InputDecoration] below instead of constructor
                /// because we need to apply optional parameters given in other props.
                ///
                /// You can pass [inputDecoration] to replace default [InputDecoration].
                decoration: inputDecoration ??
                    InputDecoration(
                      prefixIcon: prefixIcon,
                      focusColor: AppColors.text.defaultColor,
                      fillColor: !enabled
                          ? AppColors.bg.paper
                          : AppColors.bg.defaultColor,
                      filled: !enabled,
                      // disabledBorder:
                      //     showBorder ? AppColors.bg.disabled : InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                      focusedBorder:
                          showBorder ? focusedOutlineBorder : InputBorder.none,
                      enabledBorder:
                          showBorder ? outlineBorder : InputBorder.none,
                      errorBorder: showBorder ? errorBorder : InputBorder.none,
                      focusedErrorBorder:
                          showBorder ? focusedErrorBorder : InputBorder.none,
                      hintText: textHint,
                      hintStyle: hintStyle,
                      errorText: errorText.isEmpty ? null : errorText,
                      errorStyle: errorStyle,
                    ),
                autofocus: true,
                style: textStyle,
                onChanged: onChanged,
                onFieldSubmitted: onSubmitted,
                onEditingComplete: onEditingComplete,
                textInputAction: textInputAction,
                onTap: onTap,
                autocorrect: false,
              ),
              hasChecked
                  ? const Positioned(
                      right: 8.0,
                      top: 12.0,
                      child: Icon(
                        Icons.check,
                      ),
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }
}

class EditTextSearch extends HookWidget {
  final String? textHint;
  final TextStyle? hintStyle;
  final TextEditingController? textEditingController;
  final Function(String)? onPressSearch;
  final dynamic Function(String)? onChanged;
  final FocusNode focus = FocusNode();
  final EdgeInsets? margin;
  final bool enabled;
  final bool readOnly;

  EditTextSearch({
    Key? key,
    this.textHint,
    this.hintStyle,
    this.textEditingController,
    this.onPressSearch,
    this.onChanged,
    this.margin,
    required BuildContext context,
    this.enabled = true,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = useState('');
    final hasFocus = useState<bool>(false);
    Color focusColor =
        hasFocus.value ? AppColors.text.defaultColor : AppColors.text.secondary;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.bg.paper,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      margin: margin,
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: focusColor,
          ),
          Flexible(
            child: Focus(
              onFocusChange: (focus) => hasFocus.value = focus,
              child: EditFormText(
                focusNode: focus,
                onSubmitted: onPressSearch,
                textEditingController: textEditingController,
                enabled: enabled,
                readOnly: readOnly,
                onChanged: (val) {
                  text.value = val;
                  if (onChanged != null) {
                    onChanged!(val);
                  }
                },
                textHint: textHint,
                hintStyle: TextStyle(
                  color: AppColors.text.defaultColor,
                ).merge(hintStyle),
                showBorder: false,
              ),
            ),
          ),
          textEditingController != null &&
                  textEditingController!.text.isNotEmpty
              ? TextButton(
                  onPressed: () {
                    if (onPressSearch != null) {
                      onPressSearch!(text.value);
                    }
                  },
                  child: Text(
                    '검색',
                    style: InputLabelTextStyle().merge(
                      TextStyle(color: focusColor),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
