import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useEffect, useState;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/data/providers/item_metadata/item_purchase_cost.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';
import 'package:vintage_1020/ui/image_widget_util/image_widget_util.dart';
import 'package:vintage_1020/util/photo_util.dart';
import 'package:vintage_1020/ui/common/widgets/inventory_carousel/edit_item_inventory_carousel.dart';

class MyBoothTab extends HookConsumerWidget {
 

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    List<MyBooth> initialBooths = [];
    
    useEffect(() {
      // Check if booths already exist
      initialBooths = ref.read(myBoothsProvider).toList();
      if(initialBooths.isEmpty) {
        ref.read(myBoothsProvider.notifier).fetchUserBooths();
      }
    }, []);

    // Watch booths provider
    final List<MyBooth> currentBooths = ref.watch(myBoothsProvider).toList();

    final selectedBooth = useState<MyBooth>(currentBooths.first);

    final selectedBoothImages = useState(selectedBooth.value.currentBoothImageUrls);

    // TODO:
    // - Add filter 
    // 

    // If only one booth
    // - display booth name, 
    // - boothImages. If none, option to take picture
    // - inventoryImage Carousel

    // If multiple booths
    // - Horizontal scrollview with boothNames w/number badges according to item count

    // If no booths
    // - Indicator message
    // - Input for booth name
    // - submit through provider

    // TODO: Add quick addToBooth checkbox listview
    // 
    
    // With current booths in scope,
    // - Provider should have updated ids
    // - update add item dialog to appropriately add itemId to myBooth


    List<InventoryItemLocal>? inventory = ref.watch(inventoryProvider);

    double inventoryCost = ref.watch(inventoryPurchaseCostProvider);
    double boothValue = ref.watch(inventoryPurchaseCostProvider);

    void takeBoothPhoto() async {
      String boothPhotoPath = await PhotoUtil.takePhotoAndReturnUrl();
      List<String>? selectedBoothImageUrlsCurrentState = selectedBoothImages.value;

      // boothImageUrls.add(boothPhotoPath);
    }

    Widget openQuickAddInventoryToBooth() {

      List<InventoryItemLocal> inventory = ref.read(inventoryProvider).toList();

      if(inventory.isEmpty) return Text('You do not have inventory items. Please add some');

      return 
        Column(
          children: [
            ListView.builder(
                itemExtent: 200,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    value: false,
                    secondary: ImageWidgetUtil.getItemImage(inventory[index].primaryImageUrl), 
                    onChanged: (value) => value);
                },
                itemCount: inventory.length,
              ),
          ],
        );
    }

    return Scaffold(
      body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.builder(
                  itemExtent: 150,
                  scrollDirection: Axis.horizontal,
                  itemCount: currentBooths.length,
                  itemBuilder: (context, index) {
                    return Flexible(
                      child: GestureDetector(
                        onTap: () {
                          selectedBooth.value == currentBooths[index];
                        },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Badge(
                            label: Text(currentBooths[index].boothInventoryIds?.length.toString() ?? '0'),
                            child: FaIcon(
                              FontAwesomeIcons.tent),
                          ),
                          Text(currentBooths[index].boothName),
                        ],
                      ),
                      ),
                    );
                  },
                ),
              ),
              
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
                        'Items: ${selectedBooth.value.boothInventoryIds?.length}',
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
              selectedBooth.value.currentBoothImageUrls?.length == 0
                  ? OutlinedButton(
                      onPressed: takeBoothPhoto,
                      child: Text('Take booth image'),
                    )
                  : Expanded(
                      flex: 4,
                      child: ListView.builder(
                        itemCount: selectedBooth.value?.currentBoothImageUrls?.length,
                        itemBuilder: (context, index) {
                          selectedBooth.value?.currentBoothImageUrls?.map(
                            (url) => Image.file(File(url)),
                          );
                        },
                      ),
                    ),
              selectedBooth.value.boothInventoryIds == null 
              ?
              OutlinedButton(
                onPressed: openQuickAddInventoryToBooth, 
                child: Text('Click to open quick add from inventory')
                )
              :
              Expanded(
                flex: 4,
                child: InventoryCarousel(
                  inventoryItems: inventory ?? [],
                  flexWeights: [3],
                ),
              ),
            ],
          ),
    );
  }
}
