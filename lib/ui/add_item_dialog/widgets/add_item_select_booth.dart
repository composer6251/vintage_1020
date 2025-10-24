import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vintage_1020/constants/label_input_initial_values.dart';

class AddItemSelectBooth extends StatelessWidget {
  const AddItemSelectBooth({required this.boothNames, required this.onValueUpdated});

  final List<String> boothNames;
  final Function onValueUpdated;

  @override
  Widget build(BuildContext context) {
    boothNames.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: DropdownMenu(
            initialSelection: selectBoothInitialSelection,
            onSelected: (value) => onValueUpdated,
            dropdownMenuEntries: boothNames
                .map<DropdownMenuEntry<String>>(
                  (String boothName) => DropdownMenuEntry<String>(
                    value: boothName,
                    label: boothName,
                  ),
                )
                .toList(),
          ),
        ),
        Flexible(
          child: TextFormField(

            decoration: const InputDecoration(
              fillColor: Colors.blue,
              
              labelText: createBoothInputLabel,
            ),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Booth Name is required' : null,
          ),
        ),
      ],
    );
  }
}
