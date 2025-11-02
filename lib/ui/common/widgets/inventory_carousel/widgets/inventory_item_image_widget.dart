import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/ui/image_widget_util/image_widget_util.dart';

class InventoryItemImage extends ConsumerWidget {
  const InventoryItemImage({
    super.key,
    required this.item
  });

  final InventoryItemLocal item;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final height = MediaQuery.sizeOf(context).width;
   final width = MediaQuery.sizeOf(context).height;
   return  Stack(
     children: [
      SizedBox(
        width: width,
        height: height,
        child: ImageWidgetUtil.getItemImage(item.primaryImageUrl),
     ),
     Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                ),
                '\$${item.itemPurchasePrice.toString()}',
              ),
              Text(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                ),
                '\$${item.itemListingPrice.toString()}',
              ),
            ],
          ),
        ),
      ),
     Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  InventoryItemLocal newItem = item;
                  newItem.itemSoldPrice = item.itemListingPrice;
                  newItem.itemSoldDate = item.itemListingDate ?? DateTime.now();
                  newItem.boothId = null;
                  newItem.boothName = null;
                  
                  ref.read(inventoryLocalProvider.notifier).updateCurrentInventoryItemById(newItem, item);
                },
                child: Text('Sold?'),
              ),
            ],
          ),
        ),
      ),
   ]);
  }
}