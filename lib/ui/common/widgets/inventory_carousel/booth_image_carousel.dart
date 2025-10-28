import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/ui/common/widgets/inventory_carousel/widgets/booth_image_widget.dart';

class BoothImageCarousel extends HookConsumerWidget {
  BoothImageCarousel({
    super.key,
    required this.itemImageUrls,
    required this.flexWeights,
  });
  final List<String> itemImageUrls;
  final List<int> flexWeights;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return CarouselView.weighted(
      itemSnapping: true,
      flexWeights: flexWeights,
      children: itemImageUrls
          .map(
            (boothImageUrl) => BoothImageWidget(
              url: boothImageUrl,
            ),
          )
          .toList(),
    );
  }
}
