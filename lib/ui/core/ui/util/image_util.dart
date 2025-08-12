import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_gallery_saver/flutter_image_gallery_saver.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:vintage_1020/ui/core/ui/util/url_util.dart';
import 'package:flutter_image_gallery_saver/flutter_image_gallery_saver.dart';

// create method to create a photo album in the gallery
// to save images to a specific album in the gallery

final String appNameForImages = 'Vintage_1020';

Future<AssetPathEntity?> createInventoryPhotoAlbum(String albumName) async {

  List<Album> currentPhotoAlbums = await PhotoGallery.listAlbums();
  for(Album album in currentPhotoAlbums) {
    if(album.name == appNameForImages) {

      return AssetPathEntity(id: album.id, name: album.name ?? '', isAll: false);
    }
  }
  AssetPathEntity? newAlbum = await PhotoManager.editor.darwin.createAlbum(albumName);
  return newAlbum;
}

//   final List<Album> imageAlbums = await PhotoGallery.listAlbums();
//   final List<Album> videoAlbums = await PhotoGallery.listAlbums(
//     mediumType: MediumType.video,
//     newest: false,
//     hideIfEmpty: false,
// );

void saveImagesToAlbum(String imagePath) async {
  await FlutterImageGallerySaver.saveFile(
    imagePath
  );
}

void getAssetCount() async {
  await PhotoManager.getAssetCount().then((a) => print('COUNT: $a'));
}

// void saveFiles(List<String> imagePaths) async {
//       if(imagePaths.isEmpty) return;
//
//
//       List<String> savedFilePaths = [];
//       try {
//         final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
//         String newAlbumName = "Vintage_1020";
//         createInventoryPhotoAlbum(newAlbumName);
//         for (var path in imagePaths) {
//             String? uniquePath = extractDistinctUrl(path, null);
//             final String filePath = '${appDocumentsDir.path}/$uniquePath';
//             final File file = File(filePath);
//             // await FlutterImageGallerySaver.saveFile(filePath);
//
//           // print('File saved to: $filePath');
//           // savedFilePaths.add(filePath);
//           // itemImageUrls.value = List.from(itemImageUrls.value)..add(filePath);
//           // Create new list with the existing itemImageUrls and add selected images urls
//           // final updatedImageUrls = List<String>.from(itemImageUrls.value)..addAll(savedImagePaths);
//         };
//
//       } catch (e) {
//         print('Error saving file: $e');
//       }
//     }



