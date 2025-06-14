import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/picture_names.dart';
import 'package:namer_app/ui/inventory_carousel/inventory_carousel_viewmodel.dart';

class InventoryCarousel extends StatefulWidget {
  const InventoryCarousel({
    super.key,
    required this.images,
    required this.width,
    required this.height,
    required this.flexWeights,
  });

  final List<InventoryItem> images;
  final double width;
  final double height;
  final List<int> flexWeights;

  @override
  State<InventoryCarousel> createState() => _InventoryCarouselState();
}

class _InventoryCarouselState extends State<InventoryCarousel> {
  @override
  Widget build(BuildContext context) {
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
            children: widget.images.map((image) {
              return HeroLayoutCard(model: image);
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({super.key, required this.model});

  final InventoryItem model;

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
              image: AssetImage(model.itemImageUrls.first),
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
                model.itemListingPrice.toString(),
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.black),
              ),
              Text(
                'Category: ${model.itemCategory}',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.black),
              ),
              Text(
                model.itemDescription,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.black),
              ),
              Text(
                model.itemCategory,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text(
                'Listed: ${DateFormat.yMEd().add_jms().format(model.itemListingDate)}',
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

List<Widget> buildModelList(BuildContext context) {
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
