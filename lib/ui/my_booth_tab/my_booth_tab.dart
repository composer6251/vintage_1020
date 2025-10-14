import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vintage_1020/data/providers/current_inventory_item/current_inventory_item.dart';
import 'package:vintage_1020/data/providers/filter_notifier.dart';
import 'package:vintage_1020/data/providers/inventory_filter_provider/inventory_filter_provider.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/data/providers/item_metadata/item_purchase_cost.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/data/local_db/local_db.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/edit_item_inventory_carousel.dart';
import 'package:vintage_1020/ui/my_booth_tab/widgets/booth_item.dart';

class MyBoothTab extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyBoothTab> createState() => _MyBoothTabState();
}

class _MyBoothTabState extends ConsumerState<MyBoothTab> {

  void redirectToEditInventoryItem(InventoryItemLocal item) {
    print('redirect from booth item: ${item.id}');
    ref
        .read(currentInventoryItemProvider.notifier)
        .updateCurrentInventoryItem(item);
    Navigator.pushNamed(context, '/edit-inventory-item');
  }

  @override
  Widget build(BuildContext context) {
    final List<InventoryItemLocal> boothItems = ref.watch(inventoryProvider);

    double inventoryCost = ref.watch(inventoryPurchaseCostProvider);
    double boothValue = ref.watch(inventoryPurchaseCostProvider);
    InventoryFilter currentFilter = ref.watch(filterProvider);

    return boothItems.isEmpty 
      ? 
      SizedBox(
        child: 
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          child: Text(
            style: 
            TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold 
              ), 
              'You do not have any Listed items. You can add a new item selecting the + button and add a listing date or add to booth!'),
        ),) 
      : 
      Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          flex: 2,
          child: Card(
            elevation: 3.0,
            shadowColor: Colors.blueAccent,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  style: TextStyle(
                    fontSize: 20, 
                    fontStyle: FontStyle.italic), 
                    'Items:${boothItems.length}'),
                Text(
                  style: 
                  TextStyle(
                    fontSize: 20, 
                    fontStyle: FontStyle.italic), 
                    'Cost: ${NumberFormat.currency(
                          symbol: '\$',
                        ).format(inventoryCost)}'),
                Text(
                  style: 
                  TextStyle(
                    fontSize: 20, 
                    fontStyle: FontStyle.italic), 
                    'Value: ${NumberFormat.currency(
                          symbol: '\$',
                        ).format(boothValue)}'),
              ],
            ),
          ),
        ),
        // TODO boothItems is filtered inventory by isCurrentBoothItem. Need to make boothImages to be 
        Expanded(
          flex: 4,
          child: InventoryCarousel(
            inventoryItems: boothItems,
            flexWeights: [3],
          ),
        ),
        
        Flexible(
          flex: 4,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemExtent: 200,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  redirectToEditInventoryItem(boothItems[index]);
                },
                child: BoothItem(model: boothItems[index]),
              );
            },
            itemCount: boothItems.length,
          ),
        ),
      ],
    );
  }
}

