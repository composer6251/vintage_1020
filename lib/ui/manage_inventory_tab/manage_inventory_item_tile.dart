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
           location: BannerLocation.bottomStart,
           color: const Color.fromARGB(255, 13, 94, 16),
           message: 'SOLD',
         );
        }
        
          if(isListed && !isSold) {
            return Banner(
              location: BannerLocation.bottomStart,
              color: const Color.fromARGB(255, 243, 228, 95),
              message: 'Listed',
            );
          }


          if(!isListed && !isSold) {
            Banner(
              location: BannerLocation.bottomStart,
              color: const Color.fromARGB(255, 220, 15, 66),
              message: 'Not Listed',
            );
          }
            
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: Stack(
            children: [ 
              Image.asset(
                model.primaryImageUrl!,
              ),
            Center(
              child: Banner(
                location: BannerLocation.topStart,
                color: const Color.fromARGB(255, 13, 94, 16),
                message: 'SOLD',
              ),
            ),
                ]),
        ),
        Flexible(
          flex: 1,
          child: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FaIcon(FontAwesomeIcons.deskpro),
                Text(
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  model.itemListingPrice != null
                      ? NumberFormat.currency(symbol: '\$').format(model.itemListingPrice)
                      : 'N/A',
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  model.itemSoldPrice != null
                      ? NumberFormat.currency(symbol: '\$').format(model.itemSoldPrice)
                      : 'N/A',
                ),
              ],
            ),
          ),
        ),
          // Flexible(
          //   fit: FlexFit.tight,
          //   child: Checkbox(
          //     onChanged: (value) => {},
          //     value: false,
          //   ),
          // ),
        IconButton(
          padding: EdgeInsets.all(0),
          tooltip: 'Add to current booth',
          onPressed: (){} ,
          icon: FaIcon(FontAwesomeIcons.tentArrowDownToLine),
        ),
        IconButton(
          padding: EdgeInsets.all(0),
          tooltip: 'Archive(will not show up automatically in inventory)',
          onPressed: (){} ,
          icon: Icon(Icons.archive_outlined),
        ),
        IconButton(
          padding: EdgeInsets.all(0),
          color: Colors.red[800],
          iconSize: 40,
          onPressed: () {},
          icon: Icon(Icons.delete),
        ),
      ],
    );
  }
}
