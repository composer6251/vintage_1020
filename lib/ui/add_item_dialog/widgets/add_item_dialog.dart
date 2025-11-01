import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/constants/label_input_initial_values.dart';
import 'package:vintage_1020/data/providers/my_booth_filter/current_booth_provider.dart';
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
    final itemPurchasePrice = useState<String>('1234');
    final itemListingPrice = useState<String>('123212r');
    final itemHeight = useState<String>('');
    final itemWidth = useState<String>('');
    final itemDepth = useState<String>('');

    // UseStates for non text fields states
    final purchaseDate = useState<DateTime?>(null);
    final listingDate = useState<DateTime?>(null);

    final selectedXFiles = useState<List<XFile>>([]);
    final itemImageUrls = useState<List<String>>([]);

    final isChecked = useState<bool>(false);
    final boothNameOfBoothToCreate = useState<String>('');

    final currentBooth = ref.watch(currentBoothProvider);
    final boothSelectedFromDropdown = useState<MyBooth>(currentBooth);

    void fetchUserBooths() async {
      await ref.read(myBoothsProvider.notifier).fetchUserBooths();
    }

    void handleCheckboxOnChange(bool? value) {
      // Set checkbox value
      isChecked.value = (value == null || value == false) ? false : true;
      if (!isChecked.value) {
        boothNameOfBoothToCreate.value = '';
        return;
      }
      if(userBooths.isEmpty){
        fetchUserBooths();
      }
    }

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

    void saveNewBooth(String itemId) async {
      MyBooth boothToCreate = MyBooth(
        Uuid().v6(),
        boothNameOfBoothToCreate.value,
        userEmail ?? '',
        [itemId],
        [],
        null,
      );

      await ref
          .read(myBoothsProvider.notifier)
          .createBoothForUser(boothToCreate);
    }

    void updateExistingBooth(String itemId) async {
      currentBooth.boothInventoryIds.add(itemId);

      await ref.read(myBoothsProvider.notifier).updateBooth(currentBooth);
    }

    void submit() async {
      // Save the photos taken/selected and update the state with the urls to save
      List<String> imageUrlsToSave = await savePhotosAndGetUrls();

      // If the checkbox is checked, choose if it is a new booth or an existing booth.
      String boothNameToAddItem = '';

      if (isChecked.value) {
        boothNameToAddItem = boothNameOfBoothToCreate.value.isNotEmpty
            ? boothNameOfBoothToCreate.value
            : boothSelectedFromDropdown.value.boothName;
      }

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
        boothNameToAddItem.isEmpty ? null : boothNameToAddItem,
      );

      if (formKey.currentState?.validate() ?? false) {
        ref
            .watch(inventoryLocalProvider.notifier)
            .addUserInventoryItemLocal(itemToDB);
      }
      // If isChecked, add to selectedBooth, or create no booth and add to selected booth.
      if (isChecked.value) {
        if (boothNameOfBoothToCreate.value.isNotEmpty) {
          saveNewBooth(itemToDB.id);
        } else {
          updateExistingBooth(itemToDB.id);
        }
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
              label: addItemPurchasePriceLabel,
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
                  onChanged: (value) {
                    handleCheckboxOnChange(value);
                  },
                ),
                
              ],
            ),
            ConstrainedBox(
              constraints: BoxConstraints(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: isChecked.value,
                    child: Flexible(
                      fit: FlexFit.tight,
                      child: SizedBox(
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
                          onChanged: (value) =>
                              boothNameOfBoothToCreate.value = value,
                          validator: (value) =>
                              validateNewBoothName(value, userBooths),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Visibility(
                      visible:
                          isChecked.value &&
                          userBooths.isNotEmpty &&
                          boothNameOfBoothToCreate.value == '',
                      child: AddItemSelectBooth(
                        userBooths: userBooths,
                        onValueUpdated: (value) =>
                            boothSelectedFromDropdown.value = value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
