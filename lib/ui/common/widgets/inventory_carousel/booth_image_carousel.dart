import 'package:flutter/foundation.dart';
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
  // TODO: Make final when no web demo
  List<String> itemImageUrls;
  final List<int> flexWeights;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MyBooth currentBooth = ref.watch(currentBoothProvider);
    List<String> currentBoothImageUrls = currentBooth.currentBoothImageUrls;

    if (kIsWeb) {

      itemImageUrls = [
        '/Users/david/Coding Projects/vintage_1020/resources/images-booth/booth-1.jpeg',
        'resources/images-booth/booth-2.jpeg',
      ];
    }

    return CarouselView.weighted(
      itemSnapping: true,
      flexWeights: flexWeights,
      children: currentBoothImageUrls
          .map((boothImageUrl) => BoothImageWidget(url: boothImageUrl))
          .toList(),
    );
  }
}
