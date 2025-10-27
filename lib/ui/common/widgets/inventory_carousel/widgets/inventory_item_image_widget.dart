import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
   final height = MediaQuery.sizeOf(context).height;
   return  Stack(
     children: [
      SizedBox(
        height: height,
        child: ImageWidgetUtil.getItemImage(item.primaryImageUrl),
     ),
     Text(item.itemPurchasePrice.toString()),
   ]);
  }
}