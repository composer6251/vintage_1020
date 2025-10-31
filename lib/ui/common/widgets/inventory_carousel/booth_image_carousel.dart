import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/my_booth_filter/current_booth_provider.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';
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
    MyBooth currentBooth = ref.watch(currentBoothProvider);
    List<String> currentBoothImageUrls = currentBooth.currentBoothImageUrls;

    return CarouselView.weighted(
      itemSnapping: true,
      flexWeights: flexWeights,
      children: currentBoothImageUrls
          .map((boothImageUrl) => BoothImageWidget(url: boothImageUrl))
          .toList(),
    );
  }
}
