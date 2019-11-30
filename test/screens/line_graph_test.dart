import 'package:bookoo2/screens/line_graph.dart' show LineGraph;
import 'package:bookoo2/shared/line_graph_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets('Show [LineGraphChart] properly and show total consume/income',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(TestUtils.makeTestableWidget(child: LineGraph()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);

    expect(find.byType(LineGraphChart), findsOneWidget);

    /// show current year's total consume/income by default
    expect(find.text('\$360,000.00'), findsOneWidget);
  });
}
