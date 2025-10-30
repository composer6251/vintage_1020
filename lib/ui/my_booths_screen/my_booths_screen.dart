import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

    // INITIAL VALUE OF SELECTED BOOTH
    final MyBooth selectedBooth = ref.watch(currentBoothProvider);

    // State to hold new user-selected booth
    final pickedBooth = useState<MyBooth>(selectedBooth);

    void takeBoothPhoto() async {
      String boothPhotoPath = await PhotoUtil.takePhotoAndReturnUrl();
      List<String>? selectedBoothImageUrlsCurrentState =
          pickedBooth.value.currentBoothImageUrls;

      selectedBoothImageUrlsCurrentState.add(boothPhotoPath);

      MyBooth booth = pickedBooth.value;
      booth.currentBoothImageUrls = selectedBoothImageUrlsCurrentState;

      await ref.read(myBoothsProvider.notifier).updateBooth(booth);
    }

    void selectImagesFromPhotos() async {
      List<String> boothPhotoPath = await PhotoUtil.selectPhotosFromGalleryAndReturnUrls();
      List<String>? selectedBoothImageUrlsCurrentState =
          pickedBooth.value.currentBoothImageUrls;

      selectedBoothImageUrlsCurrentState.addAll(boothPhotoPath);

      pickedBooth.value.currentBoothImageUrls = selectedBoothImageUrlsCurrentState;

      await ref.read(myBoothsProvider.notifier).updateBooth(pickedBooth.value);
    }

    if (snapshot.connectionState == ConnectionState.done) {
      return userBooths.isEmpty
          ? CreateBoothWidget()
          : Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      child:             
                      IconButton(
                        icon: const Icon(Icons.photo_library),
                        tooltip: 'Select Booth Images From Photos',
                        style: ButtonStyle(
                          elevation: WidgetStatePropertyAll<double>(8.0),
                        ),
                        onPressed: selectImagesFromPhotos,
                        iconSize: 32,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: IconButton(
                        onPressed: takeBoothPhoto,
                        icon: FaIcon(FontAwesomeIcons.camera),
                        iconSize: 32,
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: SelectBoothDropDown(
                        userBooths: userBooths,
                        onValueUpdated: (value) => pickedBooth.value = value,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                            'Cost: \$${pickedBooth.value.boothCost}',
                            style: TextStyle(fontSize: 16),
                          ), 
                          Text(
                            'Value: \$${pickedBooth.value.boothValue}',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                selectedBooth.currentBoothImageUrls.isEmpty
                ? 
                Expanded(
                  child: Center(
                    child: Text(
                        style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                        'You do not have any booth images. Press the camera or photos button to add one!'
                      ),
                  ),
                )
                :
                Expanded(
                  flex: 6,
                  child: BoothImageCarousel(
                    itemImageUrls: selectedBooth.currentBoothImageUrls,
                    flexWeights: [3],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: InventoryItemCarousel(
                    inventoryItems: selectedBooth.boothInventory ?? [],
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
