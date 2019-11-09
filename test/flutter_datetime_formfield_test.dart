import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import '../example/main.dart';

void main() {
  testWidgets('test DateTimFormField', (WidgetTester tester) async {
    DateTime dateTime = DateTime.now();
    String textField = DateFormat("EE, MMM d, yyyy h:mma").format(dateTime);

    await tester.pumpWidget(MyWidget(
      initialValue: dateTime,
      label: "Date Time",
    ));

    final labelFinder = find.text("Date Time");
    final textFieldFinder = find.text(textField);

    expect(labelFinder, findsOneWidget);
    expect(textFieldFinder, findsOneWidget);
  });
}
