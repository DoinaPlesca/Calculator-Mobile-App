import 'package:calculator/stack_calculator.dart';

import 'command.dart';
///class encapsulates all operation +; -; *; / ;


class OperationCommand implements Command {
  final String operator;

  OperationCommand(this.operator);

  @override
  void execute(StackCalculator calculator) {
    calculator.calculate(operator);
  }
}
