import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/ui/image_widget_util/image_widget_util.dart';
import 'package:vintage_1020/util/photo_util.dart';

class BoothCarouselImage extends HookConsumerWidget {
  const BoothCarouselImage({super.key, required this.boothImageUrl, required this.boothId});

  final String boothImageUrl;
  final String boothId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

      // void addBoothImages() async {
      //   String photo = await PhotoUtil.takePhotoAndReturnUrl();

      //   ref.read(myBoothsProvider.notifier).addBoothPhoto(photo, boothId);
      // }

      return Stack(
        children: [
          // IconButton(onPressed: addBoothImages, icon: Icon(Icons.camera)),
          Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.black),
          ),
          child: ImageWidgetUtil.getItemImage(boothImageUrl)
        ),
      ]);
  }
}
