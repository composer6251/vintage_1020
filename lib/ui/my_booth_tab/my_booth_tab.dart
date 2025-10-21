import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vintage_1020/data/providers/filter_notifier.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/data/providers/item_metadata/item_purchase_cost.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booth_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';
import 'package:vintage_1020/ui/core/ui/util/image_util.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/edit_item_inventory_carousel.dart';
import 'package:vintage_1020/ui/my_booth_tab/widgets/booth_item.dart';
import 'package:vintage_1020/ui/my_booth_tab/widgets/create_booth_widget.dart';
import 'package:vintage_1020/utils/picture_util.dart';

class MyBoothTab extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyBoothTab> createState() => _MyBoothTabState();
}

class _MyBoothTabState extends ConsumerState<MyBoothTab> {
  late Future<MyBooth> myBoothFuture;

  @override
  void initState() {
    super.initState();

    myBoothFuture = ref.read(myBoothProvider.notifier).fetchUserBooth();
  }

  @override
  Widget build(BuildContext context) {


    // final List<InventoryItemLocal> boothItems = ref.watch(inventoryProvider);
    final MyBooth? currentBooth = ref.watch(myBoothProvider);
    List<String>? boothImageUrls = currentBooth?.currentBoothImageUrls ?? [];

    List<InventoryItemLocal>? inventory = ref.watch(inventoryProvider);

    void showAddBoothDialog() {
      showDialog(context: context, builder: (context) => CreateBoothWidget());
    }

    double inventoryCost = ref.watch(inventoryPurchaseCostProvider);
    double boothValue = ref.watch(inventoryPurchaseCostProvider);


    void takeBoothPhoto() async {
      String boothPhotoPath = await takePhotoAndReturnUrl();

      boothImageUrls.add(boothPhotoPath);
    }

    return Scaffold(
        body: FutureBuilder<MyBooth>(
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
