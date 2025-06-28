import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';
import 'package:url_launcher/url_launcher.dart';

class ManageInventoryScreen extends StatelessWidget {
  const ManageInventoryScreen({
    super.key,
    required this.model,
    required this.width,
    required this.height,
  });

  final InventoryItem model;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    Future<void> launchWebApp() async {
      // TODO:
      Uri uri = Uri(scheme: 'web', host: 'localhost', port: 60219);
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
    }

    return GestureDetector(
      onLongPressStart: (details) => {print('long press start')},
      onLongPress: () => {print('long press')},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Image.asset(
              height: height,
              width: width,
              model.itemImageUrls.first,
            ),
          ),
          SizedBox(
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  model.itemCategory.toString(),
                ),
                // Text(
                //   overflow: TextOverflow.ellipsis,
                //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                //   model.itemListingDate == null ?
                //   'No Listing date'
                //   : 
                //   'Listed ${DateFormat.y().add_jms().format(model.itemListingDate)}'

                // ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  'Listed: ${model.itemListingPrice}',
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  'Purchased: ${model.itemPurchasePrice}',
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Banner(
              location: BannerLocation.bottomStart,
              color: const Color.fromARGB(255, 13, 94, 16),
              message: 'SOLD',
            ),
          ),
          Flexible(
            child: IconButton(
              color: Colors.red[800],
              iconSize: 50,
              onPressed: () {},
              icon: Icon(Icons.delete),
            ),
          ),
        ],
      ),
    );
  }
}
