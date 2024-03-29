
import 'command.dart';

/// class provides a calculator functionality with stack-based operations.

class StackCalculator {
  List<double> stack = [];
  List<Command> commandHistory = [];

  /// Executes the given command on the calculator.
  void execute(Command command) {
    command.execute(this);
    commandHistory.add(command);
  }

  /// Pushes the given value onto the stack.
  void push(double value) {
    stack.add(value);
  }

  /// Clears the stack.
  void clear() {
    stack.clear();
  }

  /// Calculates the result of the operation using the given operator and operands.
  double calculateResult(String operator) {
    if (stack.length >= 2) {
      double operand2 = stack.removeLast();
      double operand1 = stack.removeLast();
      if (operand2 == 0 && operator == '/') {
        throw ArgumentError('Division by zero');
      }
      double result = _calculate(operator, operand1, operand2);
      stack.add(result);
      return result;
    }
    return 0;
  }

  /// Performs the calculation based on the given operator and operands.
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
        throw ArgumentError('Invalid operator: $operator');
    }
  }

  /// calculate decimal number
  int countDecimalPlaces(double value) {
    String valueStr = value.toString();
    int decimalIndex = valueStr.indexOf('.');

    if (decimalIndex == -1) {
      return 0;
    } else {
      return valueStr.length - decimalIndex - 1;
    }
  }

  ///calculate %
  double calculatePercentage(double value) {
    return value / 100;
  }

  /// Returns a string representation of the stack.
  String stackToString() {
    return stack.join(' ');
  }

  /// Remove the last command from the command history
  void undo() {
    if (commandHistory.isNotEmpty) {
      Command lastCommand = commandHistory.removeLast();
      lastCommand.undo(this);
    }
  }
  /// Get the last number in the stack
  /// Calculate the square of the number
  /// Replace the last number in the stack with its square
  void square() {
    if (stack.isNotEmpty) {
      double number = stack.last;
      double squared = number * number;
      stack[stack.length - 1] = squared;
    }
  }
}
