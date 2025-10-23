import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/data/providers/item_metadata/item_purchase_cost.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';
import 'package:vintage_1020/util/photo_util.dart';
import 'package:vintage_1020/ui/common/widgets/inventory_carousel/edit_item_inventory_carousel.dart';

class MyBoothTab extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyBoothTab> createState() => _MyBoothTabState();
}

class _MyBoothTabState extends ConsumerState<MyBoothTab> {
  late Future<List<MyBooth>> myBoothFuture;

  @override
  void initState() {
    super.initState();

    myBoothFuture = ref.read(myBoothsProvider.notifier).fetchUserBoothsReturn();
  }

  @override
  Widget build(BuildContext context) {

    final List<MyBooth>? currentBooths = ref.watch(myBoothsProvider).toList();
    final List<InventoryItemLocal>? allInventory = ref.watch(inventoryProvider);
    final MyBooth currentBooth = currentBooths!.first;
    List<String>? boothImageUrls = currentBooth?.currentBoothImageUrls ?? [];

    List<InventoryItemLocal>? inventory = ref.watch(inventoryProvider);

    double inventoryCost = ref.watch(inventoryPurchaseCostProvider);
    double boothValue = ref.watch(inventoryPurchaseCostProvider);


    void takeBoothPhoto() async {
      String boothPhotoPath = await PhotoUtil.takePhotoAndReturnUrl();

      boothImageUrls.add(boothPhotoPath);
    }

    return Scaffold(
        body: FutureBuilder<List<MyBooth>>(
        future: myBoothFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            Center(child: Text('Error Fetching booth: ${snapshot.error.toString()}'));
          } 
            return 
                Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28), currentBooth?.boothName ?? 'waiting'),
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
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                                'Items:${currentBooth?.boothName}',
                              ),
                              Text(
                                style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                                'Cost: ${NumberFormat.currency(symbol: '\$').format(inventoryCost)}',
                              ),
                              Text(
                                style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                                'Value: ${NumberFormat.currency(symbol: '\$').format(boothValue)}',
                              ),
                            ],
                          ),
                        ),
                      ),
                      boothImageUrls.isEmpty ?
                      TextButton(onPressed: takeBoothPhoto, child: Text('You do not have booth images.'))
                      :
                      Expanded(
                        flex: 4,
                        child: ListView.builder(
                          itemCount: currentBooth?.currentBoothImageUrls?.length,
                          itemBuilder: (context, index) {
                            currentBooth?.currentBoothImageUrls?.map((url) => Image.file(File(url)));
                          }
                        ,),
                      ),
                      Expanded(
                        flex: 4,
                        child: InventoryCarousel(
                          inventoryItems: inventory ?? [],
                          flexWeights: [3],
                        ),
                      ),
                      // Expanded(
                      //   child: ListView.builder(
                      //     itemExtent: 200,
                      //     itemBuilder: (context, index) {
                      //       inventory.map((item) => item.getPrimaryImage((item) => Image.file(item.))
                      //     },
                      //     itemCount: inventory?.length,
                      //   ),
                      // ),
                    ],
                  );
        
        },
      ),
    );
  }
}
