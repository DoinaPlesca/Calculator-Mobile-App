
import 'package:calculator/calculator_screen.dart';
import 'package:calculator/operation_command.dart';
import 'package:calculator/stack_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('StackCalculator', () {
    late StackCalculator calculator;

    setUp(() {
      calculator = StackCalculator();
    });

    test('Push should add value to the stack', () {
      calculator.push(9);
      expect(calculator.stack, equals([9]));
    });

    test('Clear should empty the stack', () {
      calculator.push(7);
      calculator.push(32);
      calculator.clear();
      expect(calculator.stack, isEmpty);
    });

    test('CalculateResult should perform add operation correctly', () {
      calculator.push(5);
      calculator.push(7);
      calculator.execute(OperationCommand('+'));
      expect(calculator.stack, equals([12]));
    });

    test('Square should replace the last number in the stack with its square', () {
      calculator.push(3);
      calculator.square();
      expect(calculator.stack, equals([9]));
    });

    test('CalculateResult should perform - operations correctly', () {
      calculator.push(30);
      calculator.push(3);
      calculator.execute(OperationCommand('-'));
      expect(calculator.stack, equals([27]));
    });

    test('CalculateResult should perform multiply operations correctly', () {
      calculator.push(4);
      calculator.push(5);
      calculator.execute(OperationCommand('*'));
      expect(calculator.stack, equals([20]));
    });

    test('CalculateResult should perform division operations correctly', () {
      calculator.push(40);
      calculator.push(10);
      calculator.execute(OperationCommand('/'));
      expect(calculator.stack, equals([4]));
    });
  });


  group('Calculator Screen UI Test', () {

    testWidgets('Test for Entering a Number and Checking the Display', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CalculatorScreen()));

      await tester.tap(find.widgetWithText(MaterialButton, '5'));
      await tester.pump();
      expect(find.text('Input: 5'), findsOneWidget);
    });

    testWidgets('Test for Performing a Calculation and Checking the Stack', (WidgetTester tester) async {

      await tester.pumpWidget(const MaterialApp(home: CalculatorScreen()));

      await tester.tap(find.widgetWithText(MaterialButton, '5'));
      await tester.pump();

      await tester.tap(find.widgetWithText(MaterialButton, 'Enter'));
      await tester.pump();

      await tester.pumpAndSettle();

      expect(find.text('Stack: 5.0'), findsOneWidget);
    });



    testWidgets('Test for Clearing the Calculator', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CalculatorScreen()));

      await tester.tap(find.widgetWithText(MaterialButton, '2'));
      await tester.pump();

      await tester.tap(find.widgetWithText(MaterialButton, 'Enter'));
      await tester.pump();

      await tester.tap(find.widgetWithText(MaterialButton, 'C'));
      await tester.pump();

      expect(find.text('Input:'' '), findsOneWidget);
      expect(find.text('Stack:'' '), findsOneWidget);

    });

    testWidgets('Test for Entering a Decimal Number', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CalculatorScreen()));

      await tester.tap(find.widgetWithText(MaterialButton, '.'));
      await tester.pump();

      await tester.tap(find.widgetWithText(MaterialButton, '5'));
      await tester.pump();
      expect(find.text('Input: .5'), findsOneWidget);

      await tester.tap(find.widgetWithText(MaterialButton, 'Enter'));
      await tester.pump();
      expect(find.text('Stack: 0.5'), findsOneWidget);

    });

    testWidgets('Test for Performing Undo Operation', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CalculatorScreen()));

      await tester.tap(find.widgetWithText(MaterialButton, '5'));
      await tester.pump();
      await tester.tap(find.widgetWithText(MaterialButton, 'Enter'));
      await tester.pump();

      await tester.tap(find.widgetWithText(MaterialButton, '2'));
      await tester.pump();
      await tester.tap(find.widgetWithText(MaterialButton, 'Enter'));
      await tester.pump();

      await tester.tap(find.widgetWithText(MaterialButton, 'Undo'));
      await tester.pump();
      expect(find.text('Stack: 5.0'), findsOneWidget);

    });

    testWidgets('Test for Performing multiple Operation', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CalculatorScreen()));

      await tester.tap(find.widgetWithText(MaterialButton, '3'));
      await tester.pump();
      await tester.tap(find.widgetWithText(MaterialButton, 'Enter'));
      await tester.pump();

      await tester.tap(find.widgetWithText(MaterialButton, '6'));
      await tester.pump();
      await tester.tap(find.widgetWithText(MaterialButton, 'Enter'));
      await tester.pump();

      await tester.tap(find.widgetWithText(MaterialButton, '*'));
      await tester.pump();
      expect(find.text('Stack: 18.0'), findsOneWidget);

      await tester.tap(find.widgetWithText(MaterialButton, 'x²'));
      await tester.pump();
      expect(find.text('Stack: 324.0'), findsOneWidget);

      await tester.tap(find.widgetWithText(MaterialButton, '6'));
      await tester.pump();
      expect(find.text('Stack: 324.0'), findsOneWidget);

      await tester.tap(find.widgetWithText(MaterialButton, '%'));
      await tester.pump();
      expect(find.text('Stack: 3.24'), findsOneWidget);

    });
  });
}
