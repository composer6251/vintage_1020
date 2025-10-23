import 'package:flutter/material.dart';
import 'package:vintage_1020/constants/label_input_initial_values.dart';

class AddToBoothCheckboxWidget extends StatelessWidget {
  const AddToBoothCheckboxWidget({
    super.key,
    required this.value,
    required this.onValueChanged,
    required this.userBooths,
  });

  final bool value;
  final Function onValueChanged;
  final List<String> userBooths;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          style: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
          addToBoothLabel,
        ),
        Checkbox(
          value: value,
          onChanged: (value) {
            onValueChanged();
          },
        ),
      ],
    );
  }
}
