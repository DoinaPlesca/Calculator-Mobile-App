import 'package:calculator/stack_calculator.dart';

/// class provides a common interface for different types of commands that can be executed on a StackCalculator.
/// It enforces a contract that any class implementing the Command interface must define an execute method that takes a StackCalculator

abstract class Command {
  void execute(StackCalculator calculator);
}
