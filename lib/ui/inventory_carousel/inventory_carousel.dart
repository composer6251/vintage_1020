import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/picture_names.dart';
import 'package:namer_app/ui/inventory_carousel/inventory_carousel_viewmodel.dart';

class InventoryCarousel extends StatefulWidget {
  const InventoryCarousel({
    super.key,
    required this.width,
    required this.height,
    required this.flexWeights,
  });

  final double width;
  final double height;
  final List<int> flexWeights;

  @override
  State<InventoryCarousel> createState() => _InventoryCarouselState();
}

// List<InventoryItem> buildInventoryCarouselViewModels() {
//   List<String> imageList = PictureNames.picListFurniture;
//   List<InventoryItem> models = [];
//   for (var image in imageList) {
//     InventoryItem model = InventoryItem(
//       itemImageUrl: image,
//       itemDescription: "itemDescription",
//       itemListingDate: DateTime.now(),
//       itemListingPrice: 100.00,
//       itemPurchaseDate: DateTime.now(),
//       itemPurchasePrice: 20.00
//     );

//     models.add(model);
//   }

//   return models;
// }

class _InventoryCarouselState extends State<InventoryCarousel> {
  @override
  Widget build(BuildContext context) {
    List<String> imageList = PictureNames.picListFurniture;
    List<InventoryItem> models = [];
    bool flag = true;

    for (var image in imageList) {
      if (flag) {
        flag = false;
      }
      InventoryItem model = InventoryItem(
        itemImageUrl: image,
        itemDescription: "itemDescription",
        itemListingDate: DateTime.now(),
        itemListingPrice: 100.00,
        itemPurchaseDate: DateTime.now(),
        itemPurchasePrice: 20.00,
        itemCategory: 'Category',
      );

      models.add(model);
    }
    return Column(
      children: [
        // ConstrainedAppBarTabs(height: height / 6, width: width, models: []),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ],
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: widget.height),
          child: CarouselView.weighted(
            // controller: controller,
            itemSnapping: true,
            flexWeights: widget.flexWeights,
            children: models.map((image) {
              return HeroLayoutCard(image: image);
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({super.key, required this.image});

  final InventoryItem image;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        ClipRect(
          child: OverflowBox(
            maxWidth: width * 7 / 8,
            minWidth: width * 7 / 8,
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage(image.itemImageUrl),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                image.itemListingPrice.toString(),
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.black),
              ),
              Text(
                'Category: ${image.itemCategory}',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.black),
              ),
              Text(
                image.itemDescription,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.black),
              ),
              Text(
                image.itemCategory,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text(
                'Listed: ${DateFormat.yMEd().add_jms().format(image.itemListingDate)}',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.black),
              ),

            ],
          ),
        ),
      ],
    );
  }
}

List<Widget> buildImageList(BuildContext context) {
  List<String> imageList = PictureNames.picListFurniture;
  List<Widget> widgets = [];
  for (var image in imageList) {
    widgets.add(
      Image(
        fit: BoxFit.cover,
        image: AssetImage(image),
        semanticLabel: "Semantic label",
      ),
    );
  }

  return widgets;
}
