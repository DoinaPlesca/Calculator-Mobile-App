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
  String _input = '';

  double _firstNumber = 0.0;
  double _secondNumber = 0.0;
  double _result = 0.0;

 void _handleButtonPress(String value) {
    setState(() {
      if (_isOperator(value)) {
        // Execute operator command
        _calculator.execute(OperationCommand(value));
        // Update display with result
        _firstNumber = _calculator.stack.isNotEmpty ? _calculator.stack.last : 0.0;
        _secondNumber = 0.0; // Reset second number for next input
      } else if (value == 'C') {
        // Clear button: Reset calculator and display
        _calculator.clear();
        _firstNumber = 0.0;
        _secondNumber = 0.0;
        _result = 0.0;
      } else if (value == '=') {
        // Calculate result
        _result = _calculator.stack.isNotEmpty ? _calculator.stack.last : 0.0;
        // Clear stack
        _calculator.clear();
        // Update display with result
        _firstNumber = _result;
        _secondNumber = 0.0;
      } else {
        // If the input is empty or if the last input is an operator, start a new input
        if (_input.isEmpty || _isOperator(_input[_input.length - 1])) {
          _input = value;
          _firstNumber = double.parse(_input); // Update first number with pressed number
        } else {
          _input += value; // Accumulate input digits
          _secondNumber = double.parse(_input); // Update second number with pressed number
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
            _buildDisplayArea(),

            const SizedBox(height: 20),
            _buildButtonRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplayArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Text(
            'First Number: $_firstNumber',
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 20.0),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Text(
            'Second Number: $_secondNumber',
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 20.0),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Text(
            'Result: $_result',
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }



  Widget _buildButtonRow() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: <Widget>[
        for (var value in [
          '7',
          '8',
          '9',
          '+',
          '4',
          '5',
          '6',
          '-',
          '1',
          '2',
          '3',
          '*',
          '0',
          '.',
          'Enter',
          'C',
          'X',
          '='
        ])
          _buildButton(value),
      ],
    );
  }

  Widget _buildButton(String value) {
    return MaterialButton(
      onPressed: () => _handleButtonPress(value),
      color: value == 'C' || value == 'X' ? Colors.red : Colors.blue,
      textColor: Colors.white,
      minWidth: 80.0,
      height: 80.0,
      child: Text(
        value,
        style: const TextStyle(fontSize: 20.0),
      ),
    );
  }
}
