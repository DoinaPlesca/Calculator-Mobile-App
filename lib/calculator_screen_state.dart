import 'package:calculator/push_command.dart';
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
        title: const Text('Calculator'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
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
    );
  }


  Widget _buildDisplayArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildDisplayText('Input: $_input'),
        _buildDisplayText('Stack: ${_calculator.stackToString()}'),
      ],
    );
  }

  Widget _buildDisplayText(String text) {
    return Text(
      text,
      textAlign: TextAlign.right,
      style: const TextStyle(
        fontSize: 23.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }



  Widget _buildButtonGrid() {
    return GridView.count(
      crossAxisCount: 4,
      childAspectRatio: 1.5,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      children: [
        _buildButton('C'),
        _buildButton('x²'),
        _buildButton('%'),
        _buildButton('/'),
        _buildButton('7'),
        _buildButton('8'),
        _buildButton('9'),
        _buildButton('*'),
        _buildButton('4'),
        _buildButton('5'),
        _buildButton('6'),
        _buildButton('-'),
        _buildButton('1'),
        _buildButton('2'),
        _buildButton('3'),
        _buildButton('+'),
        _buildUndoButton(),
        _buildButton('0'),
        _buildButton('.'),
        _buildEnterButton(),
      ],
    );
  }

  Widget _buildEnterButton() {
    return _buildButton('Enter');
  }


  Widget _buildUndoButton() {
    return _buildButton('Undo');
  }


  Widget _buildButton(String value) {
    Color? buttonColor;
    buttonColor = _getButtonColor(value);

    Color textColor = _getTextColor(value);

    return MaterialButton(
      onPressed: () {
        if (value == 'Undo') {
          _handleUndo();
        } else {
          _handleButtonPress(value);
        }
      },
      color: buttonColor,
      textColor: textColor,
      child: Text(
        value,
        style: const TextStyle(fontSize: 21.0),
      ),
    );
  }


  Color? _getButtonColor(String value) {
    if (value == 'Enter') {
      return Colors.orange;
    } else if (value == 'C' ||
        value == '%' ||
        value == 'x²' ||
        value == '/' ||
        value == '+' ||
        value == '-' ||
        value == '*' ||
        value == '.' ||
        value == 'Undo') {
      return Colors.grey[700];
    }
    return Colors.grey[300];
  }


  Color _getTextColor(String value) {
    if (value == 'C') {
      return Colors.red;
    }
    return Colors.black;
  }


  void _handleButtonPress(String value) {
    setState(() {
      if (_isOperator(value)) {
        _calculator.execute(OperationCommand(value));
      } else if (value == 'Enter') {
        _handleEnter();
      } else if (value == 'C') {
        _handleClear();
      } else if (value == '%') {
        _handlePercentage();
      } else {
        _handleNumber(value);
      }
    });
  }


  void _handleEnter() {
    if (_input.isNotEmpty) {
      double inputValue = double.parse(_input);
      _calculator.execute(PushCommand(inputValue));
      _input = '';
    }
  }


  void _handleClear() {
    _calculator.clear();
    _input = '';
  }


  void _handlePercentage() {
    if (_calculator.stack.isNotEmpty) {
      double percentage = _calculator.stack.last / 100;
      _calculator.stack[_calculator.stack.length - 1] = percentage;
    }
  }


  void _handleNumber(String value) {
    _input += value;
  }


  bool _isOperator(String value) {
    return value == '+' || value == '-' || value == '*' || value == '/';
  }

  void _handleUndo() {
    setState(() {
      _calculator.undo();
    });
  }
}
