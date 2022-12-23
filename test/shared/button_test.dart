import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wecount/widgets/common/button.dart' show Button;
import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets('Button', (WidgetTester tester) async {
    await tester.pumpWidget(TestUtils.makeTestableWidget(
        child: const Button(
      text: 'TextTest',
    )));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);

    expect(find.text('TextTest'), findsOneWidget);
  });
}
