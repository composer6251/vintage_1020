import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/constants/label_input_initial_values.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart'
    hide userEmail;
import 'package:vintage_1020/data/local_db/inventory_db.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/add_to_booth_checkbox_widget.dart';
import 'package:vintage_1020/ui/validators/form_field_validators.dart';
import 'package:vintage_1020/util/photo_util.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/add_item_select_booth.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/item_dimension_widget.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/price_date_input_widget.dart';

/// TODO:
/// 5. useEffect to initialze controllers
class AddItemDialog extends HookConsumerWidget {
  const AddItemDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // useMemoized to prevent new instances of formKey
    final formKey = useMemoized(() => GlobalKey<FormState>());

    List<MyBooth> userBooths = ref.watch(myBoothsProvider);

    // UseStates for text fields
    final itemPurchasePrice = useState<String>('');
    final itemListingPrice = useState<String>('');
    final itemHeight = useState<String>('');
    final itemWidth = useState<String>('');
    final itemDepth = useState<String>('');

    // UseStates for non text fields states
    final purchaseDate = useState<DateTime?>(null);
    final listingDate = useState<DateTime?>(null);

    final selectedXFiles = useState<List<XFile>>([]);
    final itemImageUrls = useState<List<String>>([]);

    final isChecked = useState<bool>(false);
    final createdBoothName = useState<String>('');

    /// AFTER USER SELECTS PHOTOS OR TAKES A PHOTO, UPDATE THE EPHEMERAL STATE
    void selectPhotos() async {
      List<XFile> photosToAdd = await PhotoUtil.selectPhotosFromGallery();

      if (photosToAdd.isEmpty) return;

      // Update state of selected photos
      List<XFile> updatedSelectedXFiles = [
        ...selectedXFiles.value,
        ...photosToAdd,
      ];

      selectedXFiles.value = updatedSelectedXFiles;
    }

    void takePhoto() async {
      XFile? photoTaken = await PhotoUtil.takeCameraPhoto();

      if (photoTaken == null) return;

      selectedXFiles.value = [...selectedXFiles.value, photoTaken];
    }

    void closeDialog() {
      Navigator.of(context).pop();
    }

    Future<List<String>> savePhotosAndGetUrls() async {
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

      return updatedItemImageUrls;
    }

    void submit() async {

      // Save the photos taken/selected and update the state with the urls to save
      List<String> imageUrlsToSave = await savePhotosAndGetUrls();

      final InventoryItemLocal itemToDB = InventoryItemLocal.toLocalDb(
        Uuid().v6(),
        userEmail,
        imageUrlsToSave.isNotEmpty ? imageUrlsToSave.first : null,
        '',
        imageUrlsToSave,
        '',
        double.tryParse(itemPurchasePrice.value),
        double.tryParse(itemListingPrice.value),
        null,
        purchaseDate.value,
        listingDate.value,
        null,
        double.tryParse(itemHeight.value),
        double.tryParse(itemWidth.value),
        double.tryParse(itemDepth.value),
        null,
        createdBoothName.value,
      );

      if (formKey.currentState?.validate() ?? false) {
        ref
            .watch(inventoryLocalProvider.notifier)
            .addUserInventoryItemLocal(itemToDB);
      }

      if (createdBoothName.value != '' && isChecked.value) {

        MyBooth boothToCreate = MyBooth(
          createdBoothName.value,
          userEmail ?? '',
          [itemToDB.id],
          [],
          null,
        );

        ref.read(myBoothsProvider.notifier).createBoothForUser(boothToCreate);
      }
      closeDialog();
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
              price: itemPurchasePrice.value,
              date: purchaseDate.value,
              onPriceChanged: (value) => itemPurchasePrice.value = value,
              onDateChanged: (value) => purchaseDate.value = value,
              label: purchasePriceRequiredLabel,
            ),
            PriceDateInputWidget(
              price: itemListingPrice.value,
              date: listingDate.value,
              onPriceChanged: (value) => itemListingPrice.value = value,
              onDateChanged: (value) => listingDate.value = value,
              label: listingPriceLabel,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                    addToBoothLabel,
                  ),
                ),
                Checkbox(
                  value: isChecked.value,
                  onChanged: (value) => {
                    isChecked.value = (value == null || value == false)
                        ? false
                        : true,
                  },
                ),
                 Visibility(
                  visible: isChecked.value,
                   child: Flexible(
                    flex: 2,
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.blue,
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                          labelText: createBoothInputLabel,
                        ),
                        onChanged: (value) => createdBoothName.value = value,
                        validator: (value) =>
                            validateNewBoothName(value, userBooths)
                      ),
                    ),
                                   ),
                 ),
              ],
            ), 
            // TODO: Implement way to update booth item from add item, manage inv tile, select booth
            // Visibility(
            //   visible: isChecked.value,
            //   child: AddItemSelectBooth(
            //     // itemId: ,
            //     // userBooths: userBooths,
            //     // onValueUpdated: (value) => selectedBoothName.value = value,
            //   ),
            // ),
          ],
        ),
      ),
      actions: [
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
              onPressed: takePhoto,
            ),
            IconButton(
              icon: const Icon(Icons.photo_library),
              tooltip: 'Pick Images from Gallery',
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(8.0),
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
              ),
              onPressed: selectPhotos,
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
