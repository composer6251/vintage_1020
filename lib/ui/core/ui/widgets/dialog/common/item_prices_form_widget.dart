import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/current_inventory_item/current_inventory_item.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';

class ItemPricesFormWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ItemPricesFormWidgetState();
}

class _ItemPricesFormWidgetState extends ConsumerState<ItemPricesFormWidget> {

  @override
  Widget build(BuildContext context) {
    
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

    return Flex(
      mainAxisAlignment: MainAxisAlignment.end,
      direction: Axis.vertical,
      children: [
        TextFormField(
          controller: purchasePriceController,
          decoration: const InputDecoration(
            fillColor: Colors.blue,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            labelText: 'Purchase Price*',
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          validator: (value) =>
              value?.isEmpty ?? true ? 'Purchase Price is required' : null,
        ),
        TextFormField(
          controller: listingPriceController,
          decoration: const InputDecoration(
            fillColor: Colors.blue,
            labelText: 'Listing Price',
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        TextFormField(
          controller: sellingPriceController,
          decoration: const InputDecoration(
            fillColor: Colors.blue,
            labelText: 'Selling Price',
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
      ],
    );
  }
}
