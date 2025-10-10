import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/data/model/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/providers/inventory_local_provider/inventory_local_provider.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/inventory_carousel.dart';

class MyBoothTab extends ConsumerStatefulWidget {
  // late final Future<void> _itemsFuture;

  @override
  ConsumerState<MyBoothTab> createState() => _MyBoothTabState();
}

class _MyBoothTabState extends ConsumerState<MyBoothTab> {
  late Future<void> _itemsFuture;
  late List<InventoryItemLocal> inventory = [];

  @override
  void initState() {
    super.initState();
    if(inventory.isEmpty) {
    _itemsFuture = ref.read(inventoryLocalProvider.notifier).fetchInitialUserInventory();
    }
  }

  @override
  Widget build(BuildContext context) {

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
              // TODO: FIX 
                // Flexible(
                //   flex: 2,
                //   fit: FlexFit.loose,
                //   child: Container(
                //     child: Image.file(File(inventory.first.primaryImageUrl)),),
                // ),
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
