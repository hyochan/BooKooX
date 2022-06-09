import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wecount/screens/setting_excel.dart' show SettingExcel;

import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets("Widget", (WidgetTester tester) async {
    await tester
        .pumpWidget(TestUtils.makeTestableWidget(child: SettingExcel()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);

    expect(find.text('SEND'), findsOneWidget);
    expect(find.text('EMAIL_HINT'), findsOneWidget);
  });
}
