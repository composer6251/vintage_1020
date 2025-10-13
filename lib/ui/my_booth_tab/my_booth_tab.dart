import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/data/providers/current_inventory_item/current_inventory_item.dart';
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
  late Future<List<InventoryItemLocal>> inventoryFuture;
  late List<InventoryItemLocal> inventory;

  @override
  void initState() {
    super.initState();
    print('my booth initState');
    inventoryFuture = ref
        .read(inventoryLocalProvider.notifier)
        .fetchInitialUserInventory();
  }

  void redirectToEditInventoryItem(InventoryItemLocal item) {
    print('redirect from booth item: ${item.id}');
    ref
        .read(currentInventoryItemProvider.notifier)
        .updateCurrentInventoryItem(item);
    Navigator.pushNamed(context, '/edit-inventory-item');
  }

  @override
  Widget build(BuildContext context) {

    double inventoryCost = ref.watch(inventoryPurchaseCostProvider);
    double boothValue = ref.watch(inventoryPurchaseCostProvider);
    // variable to store inventory once async call completes
    final List<InventoryItemLocal> inventory = ref.watch(inventoryProvider);
    return Scaffold(
      body: FutureBuilder<List<InventoryItemLocal>>(
        /*FUTURE FUNCTION TO RETRIEVE DATA AND UPDATE PROVIDER*/
        future: inventoryFuture,
        builder: (context, asyncSnapshot) {
          // AFTER THE ASYNC CALL FINISHES, HANDLE THE RETURN
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasError) {
            return Center(
              child: Text('Error loading data: ${asyncSnapshot.error}'),
            );
          } else if (asyncSnapshot.hasData) {
            
            return inventory.isEmpty ? Center(
              child: 
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                child: Text(
                  style: 
                  TextStyle(
                    fontSize: 32, 
                    fontWeight: FontWeight.bold 
                    ), 
                    'You do not have any inventory items yet. Press the + to add an item!'),
              ),) 
                  : 
              Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 4,
                  fit: FlexFit.loose,
                  child: InventoryCarousel(
                    inventoryItems: inventory,
                    flexWeights: [3],
                  ),
                ),
                Card(
                  elevation: 3.0,
                  shadowColor: Colors.blueAccent,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Total items: ${inventory.length}'),
                      Text('Total cost: \$$inventoryCost'),
                      Text('Total value: \$$boothValue'),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemExtent: 200,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          redirectToEditInventoryItem(inventory[index]);
                        },
                        child: Card(
                          elevation: 4,
                          child: BoothItem(model: inventory[index]),
                        ),
                      );
                    },
                    itemCount: inventory.length,
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Text('No inventory Items. Click the PLUS sign to add'),
          );
        },
      ),
    );
  }
}
