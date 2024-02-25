import 'package:calculator/stack_calculator.dart';

import 'command.dart';

class PushCommand implements Command {
  final double value;

  PushCommand(this.value);

  ///Push the value onto the stack
  @override
  void execute(StackCalculator calculator) {

    calculator.push(value);
  }

  ///Undo the push operation
  @override
  void undo(StackCalculator calculator) {

    calculator.stack.removeLast(); /// Remove the pushed value
  }
}