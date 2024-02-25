import 'package:calculator/stack_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'calculator_screen.dart';
import 'operation_command.dart';


/// this class manages the state of the CalculatorScreen widget,
/// handles user input, updates the calculator's stack,
/// and builds the user interface for the calculator screen.


class CalculatorScreenState extends State<CalculatorScreen> {
  final StackCalculator _calculator = StackCalculator();
  String _input = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: _buildDisplayArea(),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 3,
              child: _buildButtonGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplayArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Input: $_input',
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 20.0),
        ),
        Text(
          'Stack: ${_calculator.stackToString()}',
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }

  Widget _buildButtonGrid() {
    return GridView.count(
      crossAxisCount: 4,
      childAspectRatio: 1.5,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      children: [
        ..._buildNumberButtons(),
        ..._buildOperatorButtons(),
        _buildEnterButton(),
        _buildClearButton(),
      ],
    );
  }

  List<Widget> _buildNumberButtons() {
    return List.generate(
      10,
          (index) => _buildButton(index.toString()),
    );
  }

  List<Widget> _buildOperatorButtons() {
    return ['+', '-', '*', '/'].map((op) => _buildButton(op)).toList();
  }

  Widget _buildEnterButton() {
    return _buildButton('Enter');
  }

  Widget _buildClearButton() {
    return _buildButton('C');
  }

  Widget _buildButton(String value) {
    return MaterialButton(
      onPressed: () => _handleButtonPress(value),
      color: Colors.grey[300],
      textColor: Colors.black,
      child: Text(
        value,
        style: const TextStyle(fontSize: 20.0),
      ),
    );
  }

  void _handleButtonPress(String value) {
    setState(() {
      if (_isOperator(value)) {
        _calculator.execute(OperationCommand(value));
      } else if (value == 'Enter') {
        if (_input.isNotEmpty) {
          _calculator.push(double.parse(_input));
          _input = '';
        }
      } else if (value == 'C') {
        _calculator.clear();
        _input = '';
      } else {
        _input += value;
      }
    });
  }

  bool _isOperator(String value) {
    return value == '+' || value == '-' || value == '*' || value == '/';
  }
}
