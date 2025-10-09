import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vintage_1020/data/model/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/providers/inventory_local_provider/inventory_local_provider.dart';

class ManageInventoryItemTile extends HookConsumerWidget {
  const ManageInventoryItemTile({
    super.key,
    required this.model,
  });

  final InventoryItemLocal model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> launchWebApp() async {
      // TODO:
      Uri uri = Uri(scheme: 'web', host: 'localhost', port: 60219);
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
    }


    final isListed = model.itemListingPrice != null && model.itemListingDate != null;
    final isSold = model.itemSoldPrice != null && model.itemSoldDate != null;

    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    Widget? getBanner() {
    
        if(isSold) {
         return Banner(
           location: BannerLocation.topStart,
           color: const Color.fromARGB(255, 13, 94, 16),
           message: 'SOLD',
         );
        }
        if(isListed && !isSold) {
          return Banner(
            location: BannerLocation.topStart,
            color: const Color.fromARGB(255, 243, 228, 95),
            message: 'Listed',
          );
        }
        if(!isListed && !isSold) {
          Banner(
            location: BannerLocation.topStart,
            color: const Color.fromARGB(255, 220, 15, 66),
            message: 'Not Listed',
          );
        }       
    }

    void showMutationIcons() {

    }
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.black)
      ),
      child: Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 3,
              //***** THE IMAGE, BANNER, AND ITEM INFO
              child: Stack(
                children: [
                  model.primaryImageUrl == null ?
                  Container(child: Text('No Primary Image set for Item'))
                  :
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      model.primaryImageUrl!,
                    ),
                  ),
                  Banner(
                    location: BannerLocation.topStart,
                    color: const Color.fromARGB(255, 13, 94, 16),
                    message: 'SOLD',
                  ),
                ]),
            ),
            /*****PURCHASED INFO**** */
            Flexible(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    'Purchased'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
                    child: Flexible(
                      flex: 2,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                        model.itemPurchaseDate == null ?
                        'No Purchase Date'
                        :
                        DateFormat.yMd().format(model.itemPurchaseDate!)
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                      model.itemListingPrice != null
                          ? NumberFormat.currency(symbol: '\$').format(model.itemPurchasePrice)
                          : 'No Purchase Price',
                    ),
                  ),
                  IconButton(
                    iconSize: 30,
                    padding: EdgeInsets.all(0),
                    tooltip: 'Add to current booth',
                    onPressed: (){} ,
                    icon: FaIcon(FontAwesomeIcons.tentArrowDownToLine),
                  ),
                ],
              ),
            ),
            /****LISTING INFO**** */
            Flexible(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    'Listed'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Flexible(
                      flex: 2,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
                        model.itemListingDate == null ?
                        'No Listing Date'
                        :
                        DateFormat.yMd().format(model.itemListingDate!)
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                      model.itemListingPrice != null
                          ? NumberFormat.currency(symbol: '\$').format(model.itemListingPrice)
                          : 'Not Listed',
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.all(0),
                    color: Colors.red[800],
                    iconSize: 30,
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            ),              
          ]
        ),
      ),
    );
  }
}
