import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/data/providers/my_booth_filter/current_booth_provider.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

// ignore: must_be_immutable
class SelectBoothDropDown extends ConsumerWidget {
  SelectBoothDropDown({
    this.itemId,
    required this.userBooths,
    // required this.onValueUpdated,
  });

  String? itemId;
  final List<MyBooth> userBooths;
  // final Function onValueUpdated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    void updateCurrentBoothProvider(MyBooth? selectedBooth) {
      if (selectedBooth == null) {
        print(
          'Booth selected on My Booths Screen value is null. Cannot update currentBoothProvider',
        );
        return;
      }

      print('Updating current booth to be ${selectedBooth?.boothName}');

      ref.read(currentBoothProvider.notifier).setCurrentBooth(selectedBooth);
    }

    return Center(
      child: DropdownMenu(
        initialSelection: userBooths.first,
        onSelected: (value) {
          updateCurrentBoothProvider(value);
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
