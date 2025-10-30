import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/constants/label_input_initial_values.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

class AddItemSelectBooth extends ConsumerWidget {
  const AddItemSelectBooth({
    required this.userBooths,
    required this.onValueUpdated,
  });

  final List<MyBooth> userBooths;
  final Function onValueUpdated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userBooths = ref.watch(myBoothsProvider);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        userBooths.isEmpty
            ? Container()
            : DropdownMenu(
                initialSelection: userBooths.first.boothName,
                onSelected: (value) {
                  onValueUpdated(value);
                },
                dropdownMenuEntries: userBooths
                    .map<DropdownMenuEntry<String>>(
                      (MyBooth booth) => DropdownMenuEntry<String>(
                        leadingIcon: Icon(Icons.storefront),
                        value: booth.id,
                        label: booth.boothName,
                      ),
                    )
                    .toList(),
              ),
      ],
    );
  }
}
