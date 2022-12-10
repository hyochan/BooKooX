import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wecount/screens/tutorial.dart' show Tutorial;
import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets("Button", (WidgetTester tester) async {
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: const Tutorial()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);

    expect(find.text('TUTORIAL_1_DETAIL'), findsOneWidget);
    expect(find.text('RECORD_IT'), findsOneWidget);

    expect(find.text('TUTORIAL_2_DETAIL'), findsNothing);
    expect(find.text('SHARE_IT'), findsNothing);

    expect(find.text('TUTORIAL_3_DETAIL'), findsNothing);
    expect(find.text('TAKE_CARE'), findsNothing);
  });
  testWidgets("Change pages when [Next] clicked", (WidgetTester tester) async {
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: const Tutorial()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();

    expect(find.text('SHARE_IT'), findsOneWidget);
    expect(find.text('TUTORIAL_2_DETAIL'), findsOneWidget);

    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();
    // verify(TestUtils.observer.didPush(any, any));

    expect(find.text('TAKE_CARE'), findsOneWidget);
    expect(find.text('TUTORIAL_3_DETAIL'), findsOneWidget);
  });
}
