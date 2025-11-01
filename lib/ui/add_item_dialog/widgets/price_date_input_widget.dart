import 'package:flutter/material.dart';
import 'package:vintage_1020/constants/label_input_initial_values.dart';
import 'package:vintage_1020/util/date_picker_util.dart';

class PriceDateInputWidget extends StatelessWidget {
  const PriceDateInputWidget({
    required this.price,
    required this.date,
    required this.onPriceChanged,
    required this.onDateChanged,
    required this.label,
  });

  final String price;
  final DateTime? date;
  final Function onPriceChanged;
  final Function onDateChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          initialValue: '123',
          onChanged: (value) { 
            onPriceChanged(value); 
          },
          decoration: InputDecoration(
            prefixText: '\$',
            fillColor: Colors.blue,
            labelText: label,
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        OutlinedButton(
          style: ButtonStyle(elevation: WidgetStatePropertyAll<double>(4.0)),
          onPressed: () async {
            onDateChanged(await selectDate(context));
          },
          child: Text(
            date == null
                ? selectDateLabel
                : '${date?.toLocal().month}/${date?.toLocal().day}/${date?.toLocal().year}',
          ),
        ),
      ],
    );
  }
}
