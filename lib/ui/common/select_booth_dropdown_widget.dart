import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/constants/label_input_initial_values.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

// ignore: must_be_immutable
class SelectBoothDropDown extends ConsumerWidget {
  SelectBoothDropDown({
    this.itemId,
    required this.userBooths,
    required this.onValueUpdated,
  });

  String? itemId;
  final List<MyBooth> userBooths;
  final Function onValueUpdated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userBooths = ref.watch(myBoothsProvider);

    return Center(
      child: DropdownMenu(
              initialSelection: userBooths.first,
              onSelected: (value) {
                onValueUpdated(value);
              },
              dropdownMenuEntries: userBooths
                  .map<DropdownMenuEntry<MyBooth>>(
                    (MyBooth booth) => DropdownMenuEntry<MyBooth>(
                      leadingIcon: Icon(Icons.storefront),
                      value: booth,
                      label: '${booth.boothName}: ${booth.boothItemsCount}',
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
