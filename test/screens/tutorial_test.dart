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

    expect(find.text(t('TUTORIAL_1_DETAIL')), findsOneWidget);
    expect(find.text(t('RECORD_IT')), findsOneWidget);

    expect(find.text(t('TUTORIAL_2_DETAIL')), findsNothing);
    expect(find.text(t('SHARE_IT')), findsNothing);

    expect(find.text(t('TUTORIAL_3_DETAIL')), findsNothing);
    expect(find.text(t('TAKE_CARE')), findsNothing);
  });
  testWidgets('Change pages when [Next] clicked', (WidgetTester tester) async {
    await tester
        .pumpWidget(TestUtils.makeTestableWidget(child: const Tutorial()));
    await tester.pumpAndSettle();

    await tester.tap(find.text(t('NEXT')));
    await tester.pumpAndSettle();

    expect(find.text(t('SHARE_IT')), findsOneWidget);
    expect(find.text(t('TUTORIAL_2_DETAIL')), findsOneWidget);

    await tester.tap(find.text(t('NEXT')));
    await tester.pumpAndSettle();
    // verify(TestUtils.observer.didPush(any, any));

    expect(find.text(t('TAKE_CARE')), findsOneWidget);
    expect(find.text(t('TUTORIAL_3_DETAIL')), findsOneWidget);
  });
}
