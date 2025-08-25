import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vintage_1020/domain/models/model/inventory_item/inventory_item.dart';

class HeroLayoutCard extends StatelessWidget {
  HeroLayoutCard({super.key, required this.item, required this.height, required this.width});

  final InventoryItem item;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    // If no height/width are passed, size yourself according to defaults.
    // height ??= MediaQuery.sizeOf(context).height;
    // width ??= MediaQuery.sizeOf(context).height;
      
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        OverflowBox(
          maxWidth: width * 8 / 8,
          minWidth: width * 6 / 8,
          child: SingleChildScrollView(
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage(
                item.itemImageUrls.first,
              ), // TODO: make the actual defaultImageUrl
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(36.0, 18, 18, 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                '\$${item.itemListingPrice}',
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24),
                // style: Theme.of(
                //   context,
                // ).textTheme.headlineLarge?.copyWith(color: Colors.white),
              ),
              // Text(
              //   item.itemCategory.name,
              //   overflow: TextOverflow.clip,
              //   softWrap: false,
              //   style: Theme.of(
              //     context,
              //   ).textTheme.headlineLarge?.copyWith(color: Colors.black),
              // ),
              // Text(
              //   item.itemDescription ?? '',
              //   overflow: TextOverflow.clip,
              //   softWrap: false,
              //   style: Theme.of(
              //     context,
              //   ).textTheme.headlineLarge?.copyWith(color: Colors.black),
              // ),
              const SizedBox(height: 10),
              Text(
                'Listed: ${item.itemListingDate != null ? DateFormat.yMMMEd().format(item.itemListingDate!) : 'Unknown'}',
                overflow: TextOverflow.clip,
                softWrap: true,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24),
                // style: Theme.of(
                //   context,
                // ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}