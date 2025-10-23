import 'package:flutter/material.dart';
import 'package:vintage_1020/ui/core/ui/util/date_picker_util.dart';

class PriceDateInputWidget extends StatelessWidget{
  const PriceDateInputWidget({required this.price, required this.date, required this.onPriceChanged, required this.onDateChanged});

  final String price;
  final DateTime? date;
  final Function onPriceChanged;
  final Function onDateChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          onChanged: (value) => onPriceChanged,
          decoration: const InputDecoration(
            prefixText: '\$',
            fillColor: Colors.blue,
            labelText: 'Purchase Price(required)',
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          validator: (value) =>
              value?.isEmpty ?? true ? 'Purchase Price is required' : null,
        ),
        OutlinedButton(
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll<double>(8.0),
          ),
          onPressed: () => onDateChanged(selectDate(context)),
          child: Text(
            date == null 
            ? 
            'Select Date'
            :
            '${date?.toLocal().month}/${date?.toLocal().day}/${date?.toLocal().year}',
          ),
        ),
      ],
    );
  }
}