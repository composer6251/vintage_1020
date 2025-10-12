import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';

class BoothItem extends HookConsumerWidget {
  const BoothItem({super.key, required this.model});

  final InventoryItemLocal model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return model == null
    ? Container()
    : Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.black),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              children: [
                model.primaryImageUrl == null
                ? Container(
                    child: Text('No Primary Image set for Item'),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(model.primaryImageUrl!),
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                        ),
                      'Listed: ${DateFormat.yMd().format(model.itemPurchaseDate!)}',
                    ),
                    Text(
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                        ),
                      'Purchased: ${DateFormat.yMd().format(model.itemPurchaseDate!)}',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
  }
}
