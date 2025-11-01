import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/constants/booth_discounts.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

class DropDownFromMap extends ConsumerWidget {
  const DropDownFromMap({
    required super.key,
    required this.keyValueMap,
    required this.onValueUpdated,
  });

  final Map<String, int> keyValueMap;
  final Function onValueUpdated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownMenu<String>(
      initialSelection: 'Discount booth',
      onSelected: (value) {
        onValueUpdated(value);
      },
      dropdownMenuEntries: boothDiscounts.entries
          .map<DropdownMenuEntry<String>>((MapEntry<String, int> entry) {
            return DropdownMenuEntry<String>(
              value: entry.value.toString(), 
              label: entry.key);
          })
          .toList(),
    );
  }
}
