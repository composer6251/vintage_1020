import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';
import 'package:url_launcher/url_launcher.dart';

class ManageInventoryItemTile extends StatelessWidget {
  const ManageInventoryItemTile({
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
    final isListed = model.itemListingPrice != null && model.itemListingDate != null;
    final isSold = model.itemSoldPrice != null && model.itemSoldDate != null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Image.asset(
            height: height,
            width: width,
            model.primaryImageUrl!,
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
                model.itemCategory,
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                model.itemListingPrice != null
                    ? 'Listed: ${NumberFormat.currency(symbol: '\$').format(model.itemListingPrice)}'
                    : 'Not Listed',
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                model.itemSoldPrice != null
                    ? 'Sold: ${NumberFormat.currency(symbol: '\$').format(model.itemSoldPrice)}'
                    : 'Not Sold',
              ),
            ],
          ),
        ),
        if(isSold)
          Flexible(
            fit: FlexFit.tight,
            child: Banner(
              location: BannerLocation.bottomStart,
              color: const Color.fromARGB(255, 13, 94, 16),
              message: 'SOLD',
            ),
          ),
          if(isListed && !isSold)
            Flexible(
              fit: FlexFit.tight,
              child: Banner(
                location: BannerLocation.bottomStart,
                color: const Color.fromARGB(255, 243, 228, 95),
                message: 'Listed',
              ),
            ),
          if(!isListed && !isSold)
            Flexible(
              fit: FlexFit.tight,
              child: Banner(
                location: BannerLocation.bottomStart,
                color: const Color.fromARGB(255, 220, 15, 66),
                message: 'Not Listed',
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
    );
  }
}
