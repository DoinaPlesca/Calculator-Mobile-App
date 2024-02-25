import 'package:flutter/material.dart';
import 'calculator_screen.dart';


void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.black, // Set background color to black
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white), // Set text color to white
        ),
      ),
      home: const CalculatorScreen(),
    );
  }
}