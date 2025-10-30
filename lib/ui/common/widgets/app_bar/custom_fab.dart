import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/data/local_db/inventory_db.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/data/services/b_t_api.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';
import 'package:vintage_1020/ui/common/dialog/confirmation_dialog.dart';
import 'package:vintage_1020/util/photo_util.dart';

class CustomFab extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void addInventoryItem(InventoryItemLocal itemToSave) async {
      await ref
          .read(inventoryLocalProvider.notifier)
          .quickAddInventoryItem(itemToSave);
    }

    void showQuickAddBoothSelectDialog() {
      showQuickAddToBoothDialog('Select a booth.', context);
    }

    void displayAddToBoothConfirmation(String photoUrl) async {
      // Update item.BoothName, ItemListedDate, booth.itemIds
      InventoryItemLocal itemToSave = InventoryItemLocal.empty(Uuid().v6());
      itemToSave.itemImageUrls = [photoUrl];
      itemToSave.primaryImageUrl = photoUrl;

      OkCancelResult result = await showConfirmDialog(
        'Add item to booth?',
        context,
      );

      if (result.name == 'no') {
        ref
            .read(inventoryLocalProvider.notifier)
            .quickAddInventoryItem(itemToSave);
        return;
      }
      if (result.name == 'yes') {
        List<MyBooth> booths = ref.read(myBoothsProvider);
      }

      showQuickAddBoothSelectDialog();
    }

    void quickAddItemWithPhoto() async {
      String photoTaken = await PhotoUtil.takePhotoAndReturnUrl();
      if (photoTaken == "") return;

      displayAddToBoothConfirmation(photoTaken);
    }

    return FloatingActionButton.extended(
      extendedIconLabelSpacing: 10,
      label: Text('Quick'),
      icon: FaIcon(FontAwesomeIcons.plus),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
      ),
      onPressed: quickAddItemWithPhoto,
      backgroundColor: Colors.blue,
    );
  }
}
