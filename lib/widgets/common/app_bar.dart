import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wecount/utils/colors.dart';
import 'package:wecount/widgets/common/edit_text.dart';

class AppBarBack extends StatelessWidget with PreferredSizeWidget {
  const AppBarBack({
    Key? key,
    this.title,
    this.actions,
    this.systemOverlayStyle,
    this.centerTitle = false,
    this.bottomWidget,
    this.backgroundColor,
    this.onPressBack,
  }) : super(key: key);

  final Widget? title;
  final List<Widget>? actions;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Color? color = null;
  final bool? centerTitle;
  final Widget? bottomWidget;
  final Color? backgroundColor;
  final Function()? onPressBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? AppColors.bg.basic,
      systemOverlayStyle: systemOverlayStyle,
      leading: RawMaterialButton(
        padding: const EdgeInsets.all(0.0),
        shape: const CircleBorder(),
        onPressed: onPressBack ?? () => Navigator.of(context).pop(),
        child: Icon(
          Icons.arrow_back,
          color: color,
          semanticLabel: '뒤로가기',
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.3),
        child: bottomWidget != null
            ? Column(
                children: [
                  bottomWidget!,
                  Container(
                    color: AppColors.bg.basic,
                    height: 0.3,
                  ),
                ],
              )
            : Container(
                color: AppColors.role.secondary,
                height: 0.3,
              ),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      actions: actions,
      title: title,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppBarClose extends StatelessWidget with PreferredSizeWidget {
  const AppBarClose({
    Key? key,
    this.title,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.systemOverlayStyle,
    this.centerTitle,
    this.isDarkMode = true,
    this.onClose,
    this.backgroundColor,
  }) : super(key: key);

  final Widget? title;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Color? iconColor = null;
  final bool? centerTitle;
  final bool? isDarkMode;
  final VoidCallback? onClose;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? Colors.transparent,
      systemOverlayStyle: systemOverlayStyle,
      elevation: 0.0,
      actions: [
        onClose != null
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  color: iconColor,
                ),
                color: isDarkMode == true
                    ? AppColors.text.contrast
                    : AppColors.text.basic,
                onPressed: onClose,
              )
            : const SizedBox(),
      ],
      titleSpacing: 0.0,
      title: Padding(padding: const EdgeInsets.only(left: 20), child: title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppBarSearch extends HookWidget with PreferredSizeWidget {
  AppBarSearch({
    Key? key,
    this.title,
    this.backgroundColor,
    this.searchBackgroundColor,
    this.color,
    this.textHint = '',
    this.textHintStyle,
    this.systemOverlayStyle,
    this.textEditingController,
    this.onPressSearch,
    this.onChanged,
    this.actions,
  }) : super(key: key);

  final Widget? title;
  final Color? backgroundColor;
  final Color? searchBackgroundColor;
  final Color? color;
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// Props for [EditTextSearch]
  final String textHint;
  final TextStyle? textHintStyle;
  final TextEditingController? textEditingController;
  final Function(String)? onPressSearch;
  final dynamic Function(String)? onChanged;
  final List<Widget>? actions;

  final FocusNode focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final text = useState('');
    final hasFocus = useState(false);
    Color focusColor =
        hasFocus.value ? AppColors.text.accent : AppColors.text.placeholder;

    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      systemOverlayStyle: systemOverlayStyle,
      // leading: RawMaterialButton(
      //   padding: const EdgeInsets.all(0.0),
      //   shape: const CircleBorder(),
      //   onPressed: () => Navigator.of(context).pop(),
      //   child: Icon(
      //     Icons.arrow_back,
      //     color: iconColor,
      //     semanticLabel: '뒤로가기',
      //   ),
      // ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.3),
        child: Container(
          color: AppColors.text.secondary,
          height: 0.3,
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      title: EditTextSearch(
        margin: const EdgeInsets.only(left: 20),
        backgroundColor: searchBackgroundColor,
        color: color,
        onChanged: onChanged,
        onPressSearch: onPressSearch,
        textEditingController: textEditingController,
        textHint: textHint,
        textHintStyle: textHintStyle,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
