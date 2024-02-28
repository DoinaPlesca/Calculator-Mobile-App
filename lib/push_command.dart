import 'package:calculator/stack_calculator.dart';

import 'command.dart';

class PushCommand implements Command {
  final double value;
  late int indexOfValue;

  PushCommand(this.value);

  @override
  void execute(StackCalculator calculator) {
    calculator.push(value);
    indexOfValue = calculator.stack.length - 1;
  }

  @override
  void undo(StackCalculator calculator) {
    calculator.stack.removeAt(indexOfValue); // Remove the pushed value at the stored index
  }
}
