import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

enum ColorType {
  red,
  orange,
  yellow,
  green,
  blue,
  dusk,
  purple,
}

enum ColorSchemeType { bg, role, text, button }

class _BgColor {
  final Color defaultColor;
  final Color paper;
  final Color disabled;
  final Color border;

  _BgColor({
    required this.defaultColor,
    required this.paper,
    required this.disabled,
    required this.border,
  });

  static _BgColor get lightTheme => _BgColor(
        defaultColor: const Color(0xFFFFFFFF),
        paper: const Color(0xFFF2F3F5),
        disabled: const Color(0xFFC4C4C4),
        border: const Color.fromRGBO(0, 0, 0, 0.2),
      );

  static _BgColor get darkTheme => _BgColor(
        defaultColor: const Color(0xFF000000),
        paper: const Color(0xFF414141),
        disabled: const Color(0xFFC4C4C4),
        border: const Color.fromRGBO(255, 255, 255, 0.2),
      );
}

class _RoleColor {
  final Color primary;
  final Color secondary;
  final Color danger;
  final Color warning;
  final Color info;
  final Color success;
  final Color light;

  _RoleColor({
    required this.primary,
    required this.secondary,
    required this.danger,
    required this.warning,
    required this.info,
    required this.success,
    required this.light,
  });

  static _RoleColor get lightTheme => _RoleColor(
        primary: const Color(0xFF01886F),
        secondary: const Color(0xFF00D9D5),
        danger: const Color(0xFFFF3B30),
        warning: const Color(0xFFFF9500),
        info: const Color(0xFF5AC8FA),
        success: const Color(0xFF4CD964),
        light: const Color(0xFFE5E5EA),
      );

  static _RoleColor get darkTheme => _RoleColor(
        primary: const Color(0xFF17B87C),
        secondary: const Color(0xFF8E8E93),
        danger: const Color(0xFFFF3B30),
        warning: const Color(0xFFFF9500),
        info: const Color(0xFF5AC8FA),
        success: const Color(0xFF4CD964),
        light: const Color(0xFF6D6D6D),
      );
}

class _TextColor {
  final Color defaultColor;
  final Color primary;
  final Color placeholder;
  final Color disabled;
  final Color contrast;
  final Color validation;
  final Color secondary;
  final Color link;
  final Color accent;

  _TextColor({
    required this.defaultColor,
    required this.primary,
    required this.placeholder,
    required this.disabled,
    required this.contrast,
    required this.validation,
    required this.secondary,
    required this.link,
    required this.accent,
  });

  static _TextColor get lightTheme => _TextColor(
        defaultColor: const Color(0xFF262626),
        primary: const Color(0xFF000000),
        placeholder: const Color(0xFF8E8E93),
        disabled: const Color(0xFFC4C4C4),
        contrast: const Color(0xFFFFFFFF),
        validation: const Color(0xFFFF3B30),
        secondary: const Color(0xFF8E8E93),
        link: const Color(0xFF007AFF),
        accent: const Color(0xFF5AC8FA),
      );

  static _TextColor get darkTheme => _TextColor(
        defaultColor: const Color(0xFFB3B3B3),
        primary: const Color(0xFFFFFFFF),
        placeholder: const Color(0xFF8E8E93),
        disabled: const Color(0xFFC4C4C4),
        contrast: const Color(0xFF000000),
        validation: const Color(0xFFFF3B30),
        secondary: const Color(0xFF8E8E93),
        link: const Color(0xFF007AFF),
        accent: const Color(0xFF5AC8FA),
      );
}

class _ButtonColorType {
  final Color text;
  final Color bg;

  const _ButtonColorType(this.text, this.bg);
}

class _ButtonColor {
  final _ButtonColorType primary;
  final _ButtonColorType secondary;
  final _ButtonColorType success;
  final _ButtonColorType danger;
  final _ButtonColorType warning;
  final _ButtonColorType info;
  final _ButtonColorType light;

  _ButtonColor({
    required this.primary,
    required this.secondary,
    required this.success,
    required this.danger,
    required this.warning,
    required this.info,
    required this.light,
  });

  static _ButtonColor get lightTheme => _ButtonColor(
        primary: const _ButtonColorType(
          Color(0xFFFFFFFF),
          Color(0xFF01886F),
        ),
        secondary: const _ButtonColorType(
          Color(0xFF000000),
          Color(0xFFE5E5EA),
        ),
        success: const _ButtonColorType(
          Color(0xFFFFFFFF),
          Color(0xFF4CD964),
        ),
        danger: const _ButtonColorType(
          Color(0xFFFFFFFF),
          Color(0xFFFF3B30),
        ),
        warning: const _ButtonColorType(
          Color(0xFFFFFFFF),
          Color(0xFFFF9500),
        ),
        info: const _ButtonColorType(
          Color(0xFFFFFFFF),
          Color(0xFF5AC8FA),
        ),
        light: const _ButtonColorType(
          Colors.transparent,
          Color(0xFF6D6D6D),
        ),
      );

  static _ButtonColor get darkTheme => _ButtonColor(
        primary: const _ButtonColorType(
          Color(0xFFFFFFFF),
          Color(0xFF17B87C),
        ),
        secondary: const _ButtonColorType(
          Color(0xFF000000),
          Color(0xFF8E8E93),
        ),
        success: const _ButtonColorType(
          Color(0xFFFFFFFF),
          Color(0xFF4CD964),
        ),
        danger: const _ButtonColorType(
          Color(0xFFFFFFFF),
          Color(0xFFFF3B30),
        ),
        warning: const _ButtonColorType(
          Color(0xFFFFFFFF),
          Color(0xFFFF9500),
        ),
        info: const _ButtonColorType(
          Color(0xFFFFFFFF),
          Color(0xFF5AC8FA),
        ),
        light: const _ButtonColorType(
          Color(0xFF000000),
          Color(0xFF8E8E93),
        ),
      );
}

// https://stackoverflow.com/a/56307575/8841562
var brightness =
    SchedulerBinding.instance.platformDispatcher.platformBrightness;
bool isLightMode = brightness != Brightness.dark;

class AppColors {
  static var bg = isLightMode ? _BgColor.lightTheme : _BgColor.darkTheme;
  static var role = isLightMode ? _RoleColor.lightTheme : _RoleColor.darkTheme;
  static var text = isLightMode ? _TextColor.lightTheme : _TextColor.darkTheme;
  static var button =
      isLightMode ? _ButtonColor.lightTheme : _ButtonColor.darkTheme;
}
