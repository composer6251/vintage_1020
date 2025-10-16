import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/current_inventory_item/current_inventory_item.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/ui/core/ui/widgets/dialog/common/item_dates_picker_widget.dart';
import 'package:vintage_1020/ui/core/ui/widgets/dialog/common/item_prices_form_widget.dart';

class TestDialog extends ConsumerStatefulWidget {
  const TestDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestDialogState();
}

class _TestDialogState extends ConsumerState<TestDialog> {
  @override
  Widget build(BuildContext context) {
    print('Building test dialog');
    final items = ref.watch(inventoryProvider);
    final currentItem = items.first;

    final purchasePriceController = TextEditingController(
      text: currentItem.itemPurchasePrice.toString(),
    );
    final listingPriceController = TextEditingController(
      text: currentItem.itemListingPrice.toString(),
    );
    final sellingPriceController = TextEditingController(
      text: currentItem.itemSoldPrice.toString(),
    );

    return Dialog(
      surfaceTintColor: Colors.blue,
      semanticsRole: SemanticsRole.dialog,
      elevation: 30.0,
      insetPadding: EdgeInsets.all(32.0),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: ItemPricesFormWidget()),
                Flexible(child: ItemDatesPickerWidget()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
