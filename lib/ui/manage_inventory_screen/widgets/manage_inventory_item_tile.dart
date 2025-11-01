import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/add_item_select_booth.dart';
import 'package:vintage_1020/util/snack_bar.dart';

class ManageInventoryItemTile extends ConsumerWidget {
  const ManageInventoryItemTile({super.key, required this.model});

  final InventoryItemLocal model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget getBanner() {
      if (model.isSold) {
        return Banner(
          location: BannerLocation.topStart,
          color: const Color.fromARGB(255, 13, 94, 16),
          message: 'SOLD',
        );
      }
      if (model.isListed) {
        return Banner(
          location: BannerLocation.topStart,
          color: const Color.fromARGB(255, 243, 228, 95),
          message: 'Listed',
        );
      }
      return Banner(
        location: BannerLocation.topStart,
        color: const Color.fromARGB(255, 220, 15, 66),
        message: 'Backstock',
      );
    }

    void deleteInventoryItem(String itemId) async {
      Navigator.pop(context);
      await ref
          .read(inventoryLocalProvider.notifier)
          .deleteInventoryItem(itemId);
    }

    void confirmDeleteItem(String itemId) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('DELETE ITEM?'),
          content: Text(
            'Are you sure you want to remove this item from your inventory?',
          ),
          icon: Icon(color: Colors.red, Icons.warning),
          actions: [
            TextButton(
              onPressed: () => deleteInventoryItem(itemId),
              child: Text('YES'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('NO'),
            ),
          ],
        ),
      );

      showSnackBar('Deleted 1 item with id $itemId', context);
    }

    Widget getItemImage(String? imageUrl) {
      String errorText = '';

      if (imageUrl == null) {
        return Text(
          style: TextStyle(fontSize: 20),
          'No primary image for item',
        );
      }

      File file = File(imageUrl);

      if (!file.existsSync()) {
        return Text(
          style: TextStyle(fontSize: 20),
          'No file found at primary image path',
        );
      }

      if (errorText.isNotEmpty) return Text(errorText);

      return Image.file(file);
    }

    // void addItemToBooth(String itemId) {
    //   showDialog(
    //     context: context,
    //     builder: (context) => AddItemSelectBooth(itemId: itemId),
    //   );
    // }
    // TODO: CREATE SIMPLE UPDATE LOGIC
    void removeItemFromBooth(InventoryItemLocal item) async {
      await ref.read(myBoothsProvider.notifier).removeItemFromBoothById(item);
      item.removeItemFromBooth();
    }

    return model == null
        ? Container()
        : Card(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: Colors.black),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 3,
                  //***** THE IMAGE, BANNER, AND ITEM INFO
                  child: Stack(
                    children: [
                      model.primaryImageUrl == null
                          ? Text('No Primary Image set for Item')
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: getItemImage(model.primaryImageUrl),
                            ),
                      getBanner(),
                    ],
                  ),
                ),
                /*****PURCHASED INFO**** */
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      'Purchased',
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                        model.itemPurchaseDate == null
                            ? 'No Purchase Date'
                            : DateFormat.yMd().format(model.itemPurchaseDate!),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                        model.itemListingPrice != null
                            ? NumberFormat.currency(
                                symbol: '\$',
                              ).format(model.itemPurchasePrice)
                            : 'No Purchase Price',
                      ),
                    ),
                    model.isBackstock
                        ? IconButton(
                            iconSize: 30,
                            padding: EdgeInsets.all(0),
                            tooltip: 'Add to booth',
                            onPressed: () {}, //=> addItemToBooth(model.id),
                            icon: FaIcon(FontAwesomeIcons.tentArrowDownToLine),
                          )
                        // TODO: IMPLEMENT UPDATE LOGIC
                        : IconButton(
                            iconSize: 30,
                            padding: EdgeInsets.all(0),
                            tooltip: 'Remove from booth',
                            onPressed: () {
                              removeItemFromBooth(model);
                            },
                            icon: FaIcon(FontAwesomeIcons.tentArrowTurnLeft),
                          ),
                  ],
                ),
                /****LISTING INFO**** */
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        'Listed',
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                          ),
                          model.itemListingDate == null
                              ? 'No Listing Date'
                              : DateFormat.yMd().format(model.itemListingDate!),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                          model.itemListingPrice != null
                              ? NumberFormat.currency(
                                  symbol: '\$',
                                ).format(model.itemListingPrice)
                              : 'Not Listed',
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        color: Colors.red[800],
                        iconSize: 30,
                        onPressed: () => confirmDeleteItem(model.id),
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
