import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/current_inventory_item/current_inventory_item.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';

class ItemDatesPickerWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ItemDatesPickerWidgetState();
}

// TODO: FINISH ITEM PRICE DATE PICKER

class _ItemDatesPickerWidgetState extends ConsumerState<ItemDatesPickerWidget> {
  @override
  Widget build(BuildContext context) {

    final items = ref.watch(inventoryProvider);
    final currentItem = items.first;

    final purchaseDateController = TextEditingController(
      text: currentItem.itemPurchasePrice.toString(),
    );
    final listingDateController = TextEditingController(
      text: currentItem.itemListingPrice.toString(),
    );
    final sellingDateController = TextEditingController(
      text: currentItem.itemSoldPrice.toString(),
    );

    return Flex(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      direction: Axis.vertical,
      children: [
        OutlinedButton(
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll<double>(8.0),
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
          ),
          onPressed: () => {},//selectDate('Purchase'),
          child: Text(
            currentItem.itemPurchaseDate == null 
            ?
            'Select Date'
            :
            '${currentItem.itemPurchaseDate?.toLocal().month}/${currentItem.itemPurchaseDate?.toLocal().day}/${currentItem.itemPurchaseDate?.toLocal().year}',
          ),
        ),
        OutlinedButton(
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll<double>(8.0),
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
          ),
          onPressed: () => {},//selectDate('Purchase'),
          child: Text(
            currentItem.itemListingDate == null 
            ?
            'Select Date'
            :
            '${currentItem.itemListingDate?.toLocal().month}/${currentItem.itemListingDate?.toLocal().day}/${currentItem.itemListingDate?.toLocal().year}',
          ),
        ),
        OutlinedButton(
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll<double>(8.0),
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
          ),
          onPressed: () => {},//selectDate('Purchase'),
          child: Text(
            currentItem.itemSoldDate == null 
            ?
            'Select Date'
            :
            '${currentItem.itemSoldDate?.toLocal().month}/${currentItem.itemSoldDate?.toLocal().day}/${currentItem.itemSoldDate?.toLocal().year}',
          ),
        ),
      ],
    );
  }
}
