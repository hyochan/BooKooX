import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bookoox/screens/setting_currency.dart' show SettingCurrency;

import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets("Widget", (WidgetTester tester) async{
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: SettingCurrency()));
    await tester.pumpAndSettle();
    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);
    expect(find.text('CURRENCY'), findsOneWidget);
  });
}
