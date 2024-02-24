import 'package:flutter/cupertino.dart';
import 'calculator_screen_state.dart';

///class represents a stateful widget that can hold mutable state
///Keys are used to uniquely identify widgets in the widget tree,
///allowing Flutter to efficiently update the UI when changes occur.

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}
