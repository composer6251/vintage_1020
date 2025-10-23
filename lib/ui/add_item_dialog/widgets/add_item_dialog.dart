import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/constants/enums.dart';
import 'package:vintage_1020/constants/label_input_initial_values.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart'
    hide userEmail;
import 'package:vintage_1020/data/local_db/local_db.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/add_to_booth_checkbox_widget.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/dialog_camera_picker_buttons_widget.dart';
import 'package:vintage_1020/ui/core/util/photo_util.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/add_item_select_booth.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/item_dimension_widget.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/price_date_input_widget.dart';

/// TODO:
/// 1. Use hooks to create state
/// 2. Use hooks to pass into children widgets as call back to update values in parents
/// 3. Pull children widgets out into widgets subfolder
/// 4. Pull business logic in view-model
/// 5. useEffect to initialze controllers
///
///
///

class AddInventoryFormDialog extends HookConsumerWidget {
  const AddInventoryFormDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // useMemoized to prevent new instances of formKey
    final formKey = useMemoized(() => GlobalKey<FormState>());

    // Controllers for TextFields/TextFormFields states
    final itemPurchasePriceController = useTextEditingController(text: '');
    final itemListingPriceController = useTextEditingController(text: '');
    final itemHeightController = useTextEditingController(text: '');
    final itemWidthController = useTextEditingController(text: '');
    final itemDepthController = useTextEditingController(text: '');

    // UseStates for non text fields states
    final purchaseDate = useState<DateTime?>(null);
    final listingDate = useState<DateTime?>(null);

    final selectedXFiles = useState<List<XFile>>([]);
    final selectedImagesAsFiles = useState<List<File>>([]);
    final itemImageUrls = useState<List<String>>([]);
    final defaultItemImageUrl = useState<String>('');

    final isChecked = useState<bool>(false);
    final boothNames = useState<List<String>>([]);
    final selectedBoothName = useState<String>('');

    /// AFTER USER SELECTS PHOTOS OR TAKES A PHOTO, UPDATE THE EPHEMERAL STATE
    void addPhotos(String photoSource) async {

      List<XFile?> photosToAdd = [];

      if(photoSource == 'Camera') {
        photosToAdd.first = await PhotoUtil.takeCameraPhoto();
      }
      else {
        photosToAdd == await PhotoUtil.pickMultipleImagesFromGallery();
      }
      
       List<XFile?> updatedSelectedXFiles = [...selectedXFiles.value, ...photosToAdd];

      //  selectedXFiles.value = updatedSelectedXFiles;

      final List<XFile> newImagesState = List.from(selectedXFiles.value);
        (photosToAdd);
      selectedXFiles.value = newImagesState;
    }

    void closeDialog() {
      Navigator.of(context).pop();
    }

    void getBooths(bool? value) async {
      if (value == false) {
        isChecked.value = false;
        return;
      }

      List<MyBooth> userBooths = await ref
          .read(myBoothsProvider.notifier)
          .fetchUserBoothsReturn();

      boothNames.value = userBooths.map((e) => e.boothName).toList();

      isChecked.value = true;
    }

    void submit() async {
      // save files
      List<File> savedImages = await PhotoUtil.saveXFileListAndReturnSavedFiles(
        selectedXFiles.value,
      );
      // get savedImages paths
      List<String> savedImagesPaths = savedImages.map((i) => i.path).toList();
      // update itemImageUrls with savedImages paths
      List<String> updatedItemImageUrls = List.from(itemImageUrls.value)
        ..addAll(savedImagesPaths);

      itemImageUrls.value = updatedItemImageUrls;

      final InventoryItemLocal itemToDB = InventoryItemLocal.toLocalDb(
        Uuid().v6(),
        userEmail,
        defaultItemImageUrl.value,
        '',
        itemImageUrls.value,
        '',
        double.tryParse(itemPurchasePriceController.text),
        double.tryParse(itemListingPriceController.text),
        null,
        purchaseDate.value,
        listingDate.value,
        null,
        double.tryParse(itemHeightController.text),
        double.tryParse(itemWidthController.text),
        double.tryParse(itemDepthController.text),
        null,
        isChecked.value ? 1.0 : 0.0,
      );

      if (formKey.currentState?.validate() ?? false) {
        ref
            .watch(inventoryLocalProvider.notifier)
            .addUserInventoryItemLocal(itemToDB);
        closeDialog();
      }
    }

    return AlertDialog(
      title: Center(
        child: const Text(
          'Add to Inventory',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PriceDateInputWidget(
              price: itemPurchasePriceController.text,
              date: purchaseDate.value,
              onPriceChanged: (value) => itemPurchasePriceController.value,
              onDateChanged: (value) => purchaseDate.value = value,
              label: purchasePriceRequiredLabel,
            ),
            PriceDateInputWidget(
              price: itemListingPriceController.text,
              date: listingDate.value,
              onPriceChanged: (value) => itemListingPriceController.value,
              onDateChanged: (value) => listingDate.value = value,
              label: listingPriceLabel,
            ),
            Flex(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: [
                ItemDimensionWidget(
                  label: ItemDimension.height.name,
                  value: itemHeightController.text,
                  onValueChanged: (value) => itemHeightController.value,
                ),
                ItemDimensionWidget(
                  label: ItemDimension.width.name,
                  value: itemWidthController.text,
                  onValueChanged: (value) => itemWidthController.value,
                ),
                ItemDimensionWidget(
                  label: ItemDimension.depth.name,
                  value: itemDepthController.text,
                  onValueChanged: (value) => itemHeightController.value,
                ),
              ],
            ),
            AddToBoothCheckboxWidget(
              value: isChecked.value,
              onValueChanged: getBooths,
              userBooths: boothNames.value,
            ),
            Visibility(
              visible: false,
              child: AddItemSelectBooth(
                boothNames: boothNames.value,
                onValueUpdated: (value) => selectedBoothName.value = value,
              ),
            ),
          ],
        ),
      ),
      actions: [
        // DialogCameraPickerButtonsWidget(
        //   cameraLabel: takePhotoToolTip,
        //   photosLabel: selectPhotosToolTip,
        //   value: [],
        //   onValueChanged: (value) => selectedImages.value = value,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.cancel),
              tooltip: 'Cancel',
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(8.0),
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.red),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            IconButton(
              icon: const Icon(Icons.photo_camera),
              tooltip: 'Take Photo',
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(8.0),
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
              ),
              onPressed: PhotoUtil.takeCameraPhoto,
            ),
            IconButton(
              icon: const Icon(Icons.photo_library),
              tooltip: 'Pick Images from Gallery',
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(8.0),
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
              ),
              onPressed: () => addPhotos(''),
            ),
            IconButton(
              icon: const Icon(Icons.check),
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(8.0),
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.green),
              ),
              onPressed: submit,
            ),
          ],
        ),
      ],
    );
  }
}
