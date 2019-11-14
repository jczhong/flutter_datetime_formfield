import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import '../example/lib/main.dart';

void main() {
  testWidgets('test DateTimFormField', (WidgetTester tester) async {
    DateTime dateTime = DateTime.now();
    String textField = DateFormat("EE, MMM d, yyyy h:mma").format(dateTime);

    await tester.pumpWidget(MyApp(
      title: "Home Page",
      initialDateTime: dateTime,
    ));

    final labelFinder = find.text("Date Time");
    final textFieldFinder = find.text(textField);

    expect(labelFinder, findsOneWidget);
    expect(textFieldFinder, findsOneWidget);
  });
}
