import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
          child: TextFormField(
            decoration: const InputDecoration(
              prefixText: '\$',
              fillColor: Colors.blue,
              labelText: 'Booth Name(required)',
            ),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Booth Name is required' : null,
          ),
        ),

        Flexible(
          child: DropdownMenu(
            initialSelection: boothNames.first,
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
      ],
    );
  }
}
