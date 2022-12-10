### How to add localization
1. Add `flutter_localizations` dependency in `pubspec.yaml` below `flutter: sdk: flutter`.
  ```
  flutter_localizations:
    sdk: flutter
  ```
2. Add languages to localize inside resource folder. Here, we created `lib/l10n` directory and created two json files which are `intl_en.arb` and `intl_ko.arb`.
3. Put your Strings in each file like below.
  ```dart
  /// intl_en.arb
  {
    "LOADING": "Loading...",
    "intro": "Create App!"
  }
  /// intl_ko.arb
  {
    "LOADING": "로딩중...",
    "intro": "앱을 만들어봐요!"
  }
  ```
4. Create `localization.dart` in `utils` and add below codes.
  ```dart
  import 'package:intl/intl.dart';

  String t(String messageText) => Intl.message(messageText);
  ```
  * Note that if you want to change the `supportedLocales`, you can pass parameters to `LocalizationDelegate`. You should also change the `supportedLocales` field in `MaterialApp`.
