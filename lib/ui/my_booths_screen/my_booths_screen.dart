import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';
import 'package:vintage_1020/ui/image_widget_util/image_widget_util.dart';
import 'package:vintage_1020/util/photo_util.dart';
import 'package:vintage_1020/ui/common/widgets/inventory_carousel/edit_item_inventory_carousel.dart';

class MyBoothsScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initiate fetch for inventory
    final result = useMemoized(
      () => ref.read(myBoothsProvider.notifier).fetchUserBooths(),
    );

    final snapshot = useFuture(result);

    // Watch booths provider
    final currentBooths = ref.watch(myBoothsProvider);
    print('currentBooths in myBooths ${currentBooths.length}');
    // INITIAL VALUE OF SELECTED BOOTH

    final selectedBooth = useState<MyBooth>(currentBooths.first);
    // print('selectedBooth in myBooths ${selectedBooth.value}');
    final boothNames = currentBooths.map((booth) => booth.boothName).toList();
    print('boothNames in myBooths ${boothNames.length}');

    // Watch inventory
    final inventory = ref.watch(inventoryLocalProvider);

    // On my booth selected
    final selectedBoothInventory = useState<List<InventoryItemLocal>>([]);
    final selectedBoothCost = useState<double?>(0.0);
    final selectedBoothValue = useState<double?>(0.0);

    MyBooth setInventoryForBooth() {
      MyBooth booth = selectedBooth.value;
      List<InventoryItemLocal> boothInventoryItems =
          selectedBooth.value.boothInventory = inventory
              .where(
                (item) =>
                    selectedBooth.value.boothInventoryIds.contains(item.id),
              )
              .toList();
      booth.boothInventory = boothInventoryItems;

      return booth;
    }

    final selectedBoothImages = useState(
      selectedBooth.value?.currentBoothImageUrls,
    );

    void takeBoothPhoto() async {
      String boothPhotoPath = await PhotoUtil.takePhotoAndReturnUrl();
      List<String>? selectedBoothImageUrlsCurrentState =
          selectedBoothImages.value;

      selectedBoothImageUrlsCurrentState?.add(boothPhotoPath);

      MyBooth booth = selectedBooth.value;
      booth.currentBoothImageUrls = selectedBoothImageUrlsCurrentState;

      await ref.read(myBoothsProvider.notifier).updateBooth(booth);
    }

    Widget openQuickAddInventoryToBooth() {
      return Column(
        children: [
          ListView.builder(
            itemExtent: 200,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                value: false,
                secondary: ImageWidgetUtil.getItemImage(
                  inventory[index].primaryImageUrl,
                ),
                onChanged: (value) => value,
              );
            },
            itemCount: inventory.length,
          ),
        ],
      );
    }

    if (snapshot.connectionState == ConnectionState.done) {
      return Column(
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
                          label: Text(
                            currentBooths[index].boothItemsCount
                                    .toString() ??
                                '0',
                          ),
                          child: FaIcon(FontAwesomeIcons.tent),
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
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    'Items: ${selectedBoothInventory.value.length}',
                  ),
                  Text(
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    'Cost: ${NumberFormat.currency(symbol: '\$').format(selectedBoothCost.value)}',
                  ),
                  Text(
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    'Value: ${NumberFormat.currency(symbol: '\$').format(selectedBoothValue.value)}',
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
                    itemCount:
                        selectedBooth.value.currentBoothImageUrls?.length,
                    itemBuilder: (context, index) {
                      selectedBooth.value.currentBoothImageUrls?.map(
                        (url) => Image.file(File(url)),
                      );
                    },
                  ),
                ),
               Expanded(
                  flex: 4,
                  child: InventoryCarousel(
                    inventoryItems: inventory ?? [],
                    flexWeights: [3],
                  ),
                ),
        ],
      );
    } else if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.connectionState == ConnectionState.none) {
      return Center(child: Text('Snapshot has no connection'));
    }
    return Center(child: CircularProgressIndicator());
  }
}
