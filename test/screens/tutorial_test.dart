import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wecount/screens/tutorial.dart' show Tutorial;
import 'package:wecount/utils/localization.dart';
import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets('Button', (WidgetTester tester) async {
    await tester
        .pumpWidget(TestUtils.makeTestableWidget(child: const Tutorial()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);

    expect(find.text(t('tutorial1Detail')), findsOneWidget);
    expect(find.text(t('recordIt')), findsOneWidget);

    expect(find.text(t('tutorial2Detail')), findsNothing);
    expect(find.text(t('shareIt')), findsNothing);

    expect(find.text(t('tutorial3Detail')), findsNothing);
    expect(find.text(t('takeCare')), findsNothing);
  });
  testWidgets('Change pages when [Next] clicked', (WidgetTester tester) async {
    await tester
        .pumpWidget(TestUtils.makeTestableWidget(child: const Tutorial()));
    await tester.pumpAndSettle();

    await tester.tap(find.text(t('next')));
    await tester.pumpAndSettle();

    expect(find.text(t('shareIt')), findsOneWidget);
    expect(find.text(t('tutorial2Detail')), findsOneWidget);

    await tester.tap(find.text(t('next')));
    await tester.pumpAndSettle();
    // verify(TestUtils.observer.didPush(any, any));

    expect(find.text(t('takeCare')), findsOneWidget);
    expect(find.text(t('tutorial3Detail')), findsOneWidget);
  });
}
