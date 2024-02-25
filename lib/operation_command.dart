import 'package:calculator/stack_calculator.dart';

import 'command.dart';
///class encapsulates all operation +; -; *; / ;


class OperationCommand implements Command {
  final String operator;
  double? previousValue;

  OperationCommand(this.operator);

  @override
  void execute(StackCalculator calculator) {
    calculator.calculateResult(operator);
  }

  @override
  void undo(StackCalculator calculator) {
    // Undo the operation
    if (previousValue != null) {
      calculator.stack.removeLast(); // Remove the result
      calculator.stack.add(previousValue!); // Restore the previous value
    }
  }
}

