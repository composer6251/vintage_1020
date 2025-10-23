import 'package:flutter/material.dart';
import 'package:vintage_1020/constants/inventory_categories.dart';

class ItemDimensionWidget extends StatelessWidget {

  const ItemDimensionWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onValueChanged,
  });

  final String label;
  final String value;
  final Function onValueChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: TextFormField(
        onChanged: (value) => onValueChanged,
        decoration: InputDecoration(
          fillColor: Colors.blue,
          labelText: label,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          labelStyle: const TextStyle(fontSize: 12),
        ),
        keyboardType: TextInputType.numberWithOptions(
          decimal: true,
        ),
      ),
    );
  }
}