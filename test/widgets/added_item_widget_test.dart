import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scrapwala_dev/widgets/added_item_widget.dart';

void main() {
  testWidgets('AddedItemCartWidget renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AddedItemCartWidget(itemAdded: 2),
      ),
    );

    // Verify if the text '2 item's added' is present
    expect(find.text('2 item\'s added'), findsOneWidget);

    // Verify if the 'View Request' button is present
    expect(find.text('View Request >'), findsOneWidget);
  });
}
