import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:bookoo2/screens/intro.dart' show Intro;
import './test_utils.dart' show TestUtils;
import '../lib/utils/localization.dart' show Localization;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';

void main() {
  testWidgets("Widget", (WidgetTester tester) async{
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: Intro()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    print(findByText.evaluate());
    expect(findByText.evaluate().isEmpty, false);
    expect(find.text('LOGIN'), findsOneWidget);
  });
}
