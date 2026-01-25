import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/my_booth_filter/current_booth_provider.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/add_item_booth_screen.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/quick_add_item_button_widget.dart';
import 'package:vintage_1020/ui/common/select_booth_dropdown_widget.dart';
import 'package:vintage_1020/ui/common/widgets/app_bar/custom_app_bar.dart';
import 'package:vintage_1020/ui/common/widgets/inventory_carousel/booth_image_carousel.dart';
import 'package:vintage_1020/ui/common/widgets/inventory_carousel/inventory_carousel.dart';
import 'package:vintage_1020/ui/my_booths_screen/widgets/booth_metadata_card_widget.dart';
import 'package:vintage_1020/ui/my_booths_screen/widgets/create_booth_widget.dart';
import 'package:vintage_1020/util/photo_util.dart';

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
    final selectedBooth = ref.watch(currentBoothProvider);
    print('selectedBooth in mybooths screen: ${selectedBooth.id}');

    void takeBoothPhoto() async {
      String boothPhotoPath = await PhotoUtil.takePhotoAndReturnUrl();
      List<String>? selectedBoothImageUrlsCurrentState =
          selectedBooth.currentBoothImageUrls;

      selectedBoothImageUrlsCurrentState.add(boothPhotoPath);

      MyBooth booth = selectedBooth;
      booth.currentBoothImageUrls = selectedBoothImageUrlsCurrentState;

      await ref.read(myBoothsProvider.notifier).updateBooth(booth);
    }

    void selectImagesFromPhotos() async {
      List<String> boothPhotoPath =
          await PhotoUtil.selectPhotosFromGalleryAndReturnUrls();
      List<String>? selectedBoothImageUrlsCurrentState =
          selectedBooth.currentBoothImageUrls;

      selectedBoothImageUrlsCurrentState.addAll(boothPhotoPath);

      selectedBooth.currentBoothImageUrls = selectedBoothImageUrlsCurrentState;

      await ref.read(myBoothsProvider.notifier).updateBooth(selectedBooth);
    }

    void openAddItemToSelectedBoothDialog() {
      showDialog(
        context: context,
        builder: (context) => const AddItemToBoothDialog(),
      );
    }

    Widget buildBodyContent() {
      if (snapshot.connectionState == ConnectionState.done) {
        return userBooths.isEmpty
            ? CreateBoothWidget()
            : Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        child: IconButton(
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
                        flex: 2,
                        child: SelectBoothDropDown(
                          userBooths: userBooths,
                          // onValueUpdated: (value) => selectedBooth = value,
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
                ]),
                  BoothMetadataWidget(boothCost: selectedBooth.boothCost, boothValue: selectedBooth.boothValue, boothRentRemaining: selectedBooth.boothRentRemaining, boothProfitMonthToDate: selectedBooth.boothMonthProfitToDate),
                  selectedBooth.currentBoothImageUrls.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Text(
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                              'You do not have any booth images. Press the camera or photos button to add one!',
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

    return Scaffold(
      body: buildBodyContent(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 1,
              child: IconButton(
                iconSize: 36,
                onPressed: () =>
                    Navigator.pushNamed(context, '/manage-inventory'),
                //Navigator.of(context).pushNamed('/manage-inventory'),
                icon: FaIcon(FontAwesomeIcons.couch),
              ),
            ),
            // Flexible(
            //   flex: 1,
            //   child: IconButton(
            //     iconSize: 36,
            //     onPressed: () =>
            //         Navigator.pushNamed(context, '/inventory-analytics'),
            //     // Navigator.of(context).pushNamed('/inventory-analytics'),
            //     icon: FaIcon(FontAwesomeIcons.chartBar),
            //   ),
            // ),
            Flexible(
              flex: 2,
              child: OutlinedButton(
                onPressed: openAddItemToSelectedBoothDialog,
                child: Text(
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  'New Item',
                ),
              ),
            ),
            Flexible(flex: 2, child: QuickAddItemButtonWidget()),
          ],
        ),
      ),
    );
  }
}
