

import 'package:flutter/material.dart';
import 'package:namer_app/ui/inventory_carousel/inventory_carousel_viewmodel.dart';
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
    Future<void> _launchWebApp() async {
      // TODO:
      Uri uri = Uri(scheme: 'web', host: 'localhost', port: 60219);
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Image.asset(
            // fit: BoxFit.,
            //  alignment: AlignmentGeometry.xy(0, 0),
            height: height / 1.25,
            width: width,
            model.itemImageUrls.first,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              'Item: ${model.itemDescription}',
            ),
            Text(
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              'Category: ${model.itemCategory}',
            ),
            Text(
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              'Listed Date: ${model.itemListingDate}',
            ),
            Text(
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              'Listing price: ${model.itemListingPrice}',
            ),
            Text(
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              'Purchase price: ${model.itemPurchasePrice}',
            ),
          ],
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Banner(
            location: BannerLocation.bottomStart,
            // layoutDirection: textDirectionToAxisDirection(TextDirection.LTR),
            color: const Color.fromARGB(255, 13, 94, 16),
            message: 'SOLD',
          ),
        ),
        IconButton(onPressed: _launchWebApp, icon: Icon(Icons.lens)),
        Flexible(
          // flex: 5,
          // fit: FlexFit.loose,
          child: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
        ),
      ],
    );
  }
}