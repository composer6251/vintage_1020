import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/my_booth_filter/current_booth_provider.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';
import 'package:vintage_1020/ui/common/select_booth_dropdown_widget.dart';
import 'package:vintage_1020/ui/common/widgets/inventory_carousel/booth_image_carousel.dart';
import 'package:vintage_1020/ui/my_booths_screen/widgets/booth_metrics_widget.dart';
import 'package:vintage_1020/ui/my_booths_screen/widgets/create_booth_widget.dart';
import 'package:vintage_1020/util/photo_util.dart';
import 'package:vintage_1020/ui/common/widgets/inventory_carousel/inventory_carousel.dart';

class MyBoothsScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initiate fetch for inventory
    final result = useMemoized(
      () => ref.read(myBoothsProvider.notifier).fetchUserBooths(),
    );

    final snapshot = useFuture(result);

    // Watch booths provider
    final userBooths = ref.watch(myBoothsProvider);
    print('currentBooths in myBooths ${userBooths.length}');

    // INITIAL VALUE OF SELECTED BOOTH
    final selectedBooth = ref.watch(currentBoothProvider);

    final pickedBooth = useState<MyBooth>(selectedBooth);
    print('pickedBooth images: ${pickedBooth.value.currentBoothImageUrls}');

    void takeBoothPhoto() async {
      String boothPhotoPath = await PhotoUtil.takePhotoAndReturnUrl();
      List<String>? selectedBoothImageUrlsCurrentState =
          pickedBooth.value.currentBoothImageUrls;

      selectedBoothImageUrlsCurrentState?.add(boothPhotoPath);

      MyBooth booth = pickedBooth.value;
      booth.currentBoothImageUrls = selectedBoothImageUrlsCurrentState;

      await ref.read(myBoothsProvider.notifier).updateBooth(booth);
    }

    if (snapshot.connectionState == ConnectionState.done) {
      return userBooths.isEmpty
          ? CreateBoothWidget()
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SelectBoothDropDown(
                  userBooths: userBooths,
                  onValueUpdated: (value) => pickedBooth.value = value,
                ),
                // SelectBoothWidget(key: key, currentBooths: currentBooths),
                BoothMetricsWidget(
                  key: key,
                  boothItemCount: pickedBooth.value.boothItemsCount,
                  boothCost: pickedBooth.value.boothCost,
                  boothValue: pickedBooth.value.boothValue,
                ),
                // pickedBooth.value.currentBoothImageUrls.isEmpty
                //     ? OutlinedButton(
                //         onPressed: takeBoothPhoto,
                //         child: Text('Take booth image'),
                //       )
                //     : Expanded(
                //         flex: 4,
                //         child: ListView.builder(
                //           itemCount:
                //               pickedBooth.value.currentBoothImageUrls.length,
                //           itemBuilder: (context, index) {
                //             pickedBooth.value.currentBoothImageUrls.map(
                //               (url) => Image.file(File(url)),
                //             );
                //           },
                //         ),
                //       ),
                Expanded(
                  flex: 4,
                  child: BoothImageCarousel(
                    itemImageUrls: pickedBooth.value.currentBoothImageUrls,
                    flexWeights: [3],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: InventoryItemCarousel(
                    inventoryItems: pickedBooth.value.boothInventory ?? [],
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
