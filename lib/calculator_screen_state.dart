import 'package:calculator/stack_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'calculator_screen.dart';
import 'command.dart';
import 'operation_command.dart';

/// this class manages the state of the CalculatorScreen widget,
/// handles user input, updates the calculator's stack,
/// and builds the user interface for the calculator screen.

class CalculatorScreenState extends State<CalculatorScreen> {
  final StackCalculator _calculator = StackCalculator();
  String _input = ''; // Updated to mutable variable

  void _handleInput(String value) {
    setState(() {
      if (_isOperator(value)) {
        _calculator.execute(OperationCommand(value));
      } else {
        if (value == '.') {
          // If the input value is a decimal point
          // and the current input doesn't already contain a decimal point,
          // add the decimal point to the input.
          if (!_input.contains('.')) { // Updated to check _input
            _input += value; // Updated to append to _input
          }
        } else {
          // If the input value is a number, add it to the input.
          _input += value; // Updated to append to _input
        }
      }
    });
  }

  bool _isOperator(String value) {
    return value == '+' || value == '-' || value == '*' || value == '/';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  _calculator.stackToString() + _input, // Display stack and input
                  style: const TextStyle(fontSize: 24.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: <Widget>[
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('+'),
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('-'),
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('*'),
                _buildButton('0'),
                _buildButton('.'),
                _buildButton('='),
                _buildButton('/'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String value) {
    return MaterialButton(
      onPressed: () {
        _handleInput(value);
      },
      child: Text(
        value,
        style: const TextStyle(fontSize: 20.0),
      ),
      color: Colors.blue,
      textColor: Colors.white,
      minWidth: 80.0,
      height: 80.0,
    );
  }
}
