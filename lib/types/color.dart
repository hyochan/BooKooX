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

// https://stackoverflow.com/a/56307575/8841562
var _brightness =
    SchedulerBinding.instance.platformDispatcher.platformBrightness;
bool isLightMode = _brightness != Brightness.dark;

enum ColorSchemeType { bg, role, text, button }

class _BgColor {
  final defaultColor = const Color(0xFFFFFFFF);
  final paper = const Color(0xFFF2F3F5);
  final disabled = const Color(0xFFC4C4C4);
  final border = const Color.fromRGBO(0, 0, 0, 0.2);

  const _BgColor.light();
  const _BgColor.dark({
    defaultColor = const Color(0xFF000000),
    paper = const Color(0xFF414141),
    disabled = const Color(0xFFC4C4C4),
    border = const Color.fromRGBO(255, 255, 255, 0.2),
  });
}

class _RoleColor {
  final Color primary = const Color(0xFF01886F);
  final Color secondary = const Color(0xFF00D9D5);
  final Color danger = const Color(0xFFFF3B30);
  final Color warning = const Color(0xFFFF9500);
  final Color info = const Color(0xFF5AC8FA);
  final Color success = const Color(0xFF4CD964);
  final Color light = const Color(0xFFE5E5EA);

  const _RoleColor.light();
  const _RoleColor.dark({
    primary = const Color(0xFF17B87C),
    secondary = const Color(0xFF8E8E93),
    danger = const Color(0xFFFF3B30),
    warning = const Color(0xFFFF9500),
    info = const Color(0xFF5AC8FA),
    success = const Color(0xFF4CD964),
    light = const Color(0xFF6D6D6D),
  });
}

class _TextColor {
  final Color defaultColor = const Color(0xFF262626);
  final Color primary = const Color(0xFF000000);
  final Color placeholder = const Color(0xFF8E8E93);
  final Color disabled = const Color(0xFFC4C4C4);
  final Color contrast = const Color(0xFFFFFFFF);
  final Color validation = const Color(0xFFFF3B30);
  final Color secondary = const Color(0xFF8E8E93);
  final Color link = const Color(0xFF007AFF);
  final Color accent = const Color(0xFF5AC8FA);

  const _TextColor.light();
  const _TextColor.dark({
    defaultColor = const Color(0xFFB3B3B3),
    primary = const Color(0xFFFFFFFF),
    placeholder = const Color(0xFF8E8E93),
    disabled = const Color(0xFFC4C4C4),
    contrast = const Color(0xFF000000),
    validation = const Color(0xFFFF3B30),
    secondary = const Color(0xFF8E8E93),
    link = const Color(0xFF007AFF),
    accent = const Color(0xFF5AC8FA),
  });
}

class _ButtonColorType {
  final Color text;
  final Color bg;

  const _ButtonColorType(this.text, this.bg);
}

class _ButtonColor {
  final primary = const _ButtonColorType(
    Color(0xFFFFFFFF),
    Color(0xFF01886F),
  );
  final secondary = const _ButtonColorType(
    Color(0xFF000000),
    Color(0xFFE5E5EA),
  );
  final success = const _ButtonColorType(
    Color(0xFFFFFFFF),
    Color(0xFF4CD964),
  );
  final danger = const _ButtonColorType(
    Color(0xFFFFFFFF),
    Color(0xFFFF3B30),
  );
  final warning = const _ButtonColorType(
    Color(0xFFFFFFFF),
    Color(0xFFFF9500),
  );
  final info = const _ButtonColorType(
    Color(0xFFFFFFFF),
    Color(0xFF5AC8FA),
  );
  final light = const _ButtonColorType(
    Colors.transparent,
    Color(0xFF6D6D6D),
  );

  const _ButtonColor.light();
  const _ButtonColor.dark({
    primary = const _ButtonColorType(
      Color(0xFFFFFFFF),
      Color(0xFF17B87C),
    ),
    secondary = const _ButtonColorType(
      Color(0xFF000000),
      Color(0xFF8E8E93),
    ),
    success = const _ButtonColorType(
      Color(0xFFFFFFFF),
      Color(0xFF4CD964),
    ),
    danger = const _ButtonColorType(
      Color(0xFFFFFFFF),
      Color(0xFFFF3B30),
    ),
    warning = const _ButtonColorType(
      Color(0xFFFFFFFF),
      Color(0xFFFF9500),
    ),
    info = const _ButtonColorType(
      Color(0xFFFFFFFF),
      Color(0xFF5AC8FA),
    ),
    light = const _ButtonColorType(
      Color(0xFF000000),
      Color(0xFF8E8E93),
    ),
  });
}

class AppColors {
  static const bg = _BgColor.light();
  static const role = _RoleColor.light();
  static const text = _TextColor.light();
  static const button = _ButtonColor.light();

  AppColors() {
    if (isLightMode) {
      const AppColors.light();
    } else {
      const AppColors.dark();
    }
  }

  const AppColors.light();
  const AppColors.dark({
    bg = const _BgColor.dark(),
    role = const _RoleColor.dark(),
    text = const _TextColor.dark(),
    button = const _ButtonColor.dark(),
  });
}
