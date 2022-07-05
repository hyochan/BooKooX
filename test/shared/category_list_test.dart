import 'package:wecount/models/category_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wecount/shared/category_list.dart' show CategoryList;
import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets("Button", (WidgetTester tester) async {
    List<Category> categories = [];
    await tester.pumpWidget(TestUtils.makeTestableWidget(
        child: CategoryList(
      categories: categories,
    )));
    await tester.pumpAndSettle();

    // var findByText = find.byType(Text);
    // expect(findByText.evaluate().isEmpty, false);

    // expect(find.text('TextTest'), findsOneWidget);
  });
}
