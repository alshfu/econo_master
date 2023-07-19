import 'package:flutter/material.dart';
import 'vat_calculator.dart';

class AddButton extends StatelessWidget {
  final VATCalculatorState state;

  AddButton(this.state);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: FloatingActionButton(
        // onPressed: () => state.addCalculation() and state.addValues()
        onPressed: () {
      //    state.addCalculation();
      //    state.addValues();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

