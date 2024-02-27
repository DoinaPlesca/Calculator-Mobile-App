// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:calculator/calculator_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';



void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // Change name of test to something that makes sense for your app
  testWidgets('Test MyApp', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorScreen());

    // TODO write your test code here
  });
}