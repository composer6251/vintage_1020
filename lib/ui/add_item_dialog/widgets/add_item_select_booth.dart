import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/constants/label_input_initial_values.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

class AddItemSelectBooth extends ConsumerWidget {
  const AddItemSelectBooth({
    required this.itemId,
    // required this.userBooths,
    // required this.onValueUpdated,
  });

  final String itemId;

  // final List<MyBooth> userBooths;
  // final Function onValueUpdated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userBooths = ref.watch(myBoothsProvider);

    void addItemToBooth(String? boothId) {
      if (boothId == null) {
        print('Failed Adding item to booth by booth name. boothName is null');
        return;
      }
      ref.read(myBoothsProvider.notifier).addItemToBoothById(itemId, boothId);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        userBooths.isEmpty
            ? Container()
            : DropdownMenu(
                // expandedInsets: EdgeInsets.all(4),
                initialSelection: userBooths.first.boothName,
                onSelected: (value) => addItemToBooth(value),
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
