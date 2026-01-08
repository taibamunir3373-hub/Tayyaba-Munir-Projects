import 'package:flutter_test/flutter_test.dart';
import 'package:smart_pos/main.dart';

void main() {
  testWidgets('Verify Login UI', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Smart POS - Login'), findsOneWidget);
  });
}