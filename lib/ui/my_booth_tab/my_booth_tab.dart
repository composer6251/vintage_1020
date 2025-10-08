import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/data/model/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/providers/firestore_provider/firestore_provider.dart';
import 'package:vintage_1020/domain/providers/inventory_local_provider/inventory_local_provider.dart';
import 'package:vintage_1020/domain/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/domain/providers/my_booth/my_booth_provider.dart';
import 'package:vintage_1020/domain/sqflite/local_db.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/inventory_carousel.dart';
import 'package:vintage_1020/utils/scaffold_state_provider.dart';

class MyBoothTab extends ConsumerStatefulWidget {
  // late final Future<void> _itemsFuture;

  @override
  ConsumerState<MyBoothTab> createState() => _MyBoothTabState();
}

class _MyBoothTabState extends ConsumerState<MyBoothTab> {
  late Future<void> _itemsFuture;
  late List<InventoryItemLocal> inventory;

  @override
  void initState() {
    super.initState();
    /***ASYNC CALL TO GET USER INVENTORY WHILE FUTURE BUILDER AWAITS */
    _itemsFuture = ref.read(inventoryLocalProvider.notifier).getUserInventory();
  }

  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    // variable to store inventory once async call completes
    final List<InventoryItemLocal> inventory = ref.watch(inventoryLocalProvider);
    return Scaffold(
      body: FutureBuilder(
        /*FUTURE FUNCTION TO RETRIEVE DATA AND UPDATE PROVIDER*/
        future: _itemsFuture,
        builder: (context, asyncSnapshot) {
          // AFTER THE ASYNC CALL FINISHES, HANDLE THE RETURN
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasError) {
            return Center(
              child: Text('Error loading data: ${asyncSnapshot.error}'),
            );
          } else if (asyncSnapshot.hasData) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              Container(child: Text('Inventory items is ${inventory.length}'),),
                Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
                  child: Container(
                    child: Image.file(File(inventory.first.primaryImageUrl!)),),
                ),
                // InventoryCarousel(
                //   inventoryItems: inventory,
                //   width: width,
                //   height: height,
                //   flexWeights: [6],
                // ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
                  child: InventoryCarousel(
                    inventoryItems: inventory,
                    // width: width,
                    // height: height * .20,
                    flexWeights: [5],
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
