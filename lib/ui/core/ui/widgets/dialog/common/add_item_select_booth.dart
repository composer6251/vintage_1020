

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booth_notifier.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

class AddItemSelectBooth extends HookConsumerWidget{
  
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<MyBooth> userBooths = ref.read(myBoothsProvider).toList();

    final List<MyBooth> alphabeticalUserBooths = userBooths.sort((a, b) => a.boothName.toLowerCase().compareTo(b.boothName.toLowerCase())) as List<MyBooth>;

    final boothsState = useState(alphabeticalUserBooths);

    final selectedBooth = useState(alphabeticalUserBooths.first);

    return 
      Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              prefixText: '\$',
              fillColor: Colors.blue,
              labelText: 'Booth Name(required)',
            ),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Booth Name is required' : null,
          ),

          DropdownMenu(
            onSelected: (value) => selectedBooth.value.boothName,
            dropdownMenuEntries: userBooths.map<DropdownMenuEntry<String>>((MyBooth booth) => 
              DropdownMenuEntry<String>(
                value: booth.boothName,
                label: booth.boothName,
              )
            ).toList(),
          ),
      ],
    );
  }
}