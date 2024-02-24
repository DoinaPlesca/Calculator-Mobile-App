import 'package:flutter/foundation.dart';
import 'command.dart';

/// class provides a calculator functionality with stack-based operations.


class StackCalculator {
  List<double> stack = [];


  void execute(Command command) {
    command.execute(this);
  }

  void push(double value) {
    stack.add(value);
  }

  void clear() {
    stack.clear();
  }


  double calculateResult(String operator) {
    if (stack.length >= 2) {
      double operand2 = stack.removeLast();
      double operand1 = stack.removeLast();
      double result = _calculate(operator, operand1, operand2);
      stack.add(result);
      return result; // Return the calculated result
    }
    return 0; // Default return value if calculation is not possible
  }




  double _calculate(String operator, double operand1, double operand2) {
    switch (operator) {
      case '+':
        return operand1 + operand2;
      case '-':
        return operand1 - operand2;
      case '*':
        return operand1 * operand2;
      case '/':
        return operand1 / operand2;
      default:
        return 0;
    }
  }

  String stackToString() {
    return stack.join(' ');
  }


}





