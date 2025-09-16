import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:vintage_1020/ui/core/ui/util/image_util.dart';
  // Variable to hold the list of selected image files
  List<XFile> _selectedImages = [];
  List<XFile> _photo = [];

  // Function to pick multiple images from the gallery
  Future<void> pickMultipleImagesFromGallery() async {
    final picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      // TODO: verify images and save to Firestore
      // Images were successfully picked
    }
  }

  Future<void> takePhoto() async {
    // Obtain a list of the available cameras on the device.
    final picker = ImagePicker();
    XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 90,
    );
    if (image != null) {
      _photo = [image];
      print('Image taken');
    }
  }

    /****CREATE ALBUM IN PHOTOS LIBRARY ON IOS FOR VINTAGE_1020 IF IT DOESN'T ALREADY EXIST */
    Future<AssetPathEntity?> createInventoryPhotoAlbum(String albumName) async {

      List<AssetPathEntity> currentPhotoAlbums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        hasAll: false,
      );
      // Check if the album already exists
      for(AssetPathEntity album in currentPhotoAlbums) {
      
        if(album.name == appNameForImages) {
          return AssetPathEntity(id: album.id, name: album.name ?? '', isAll: false);
        }
      }
      
      AssetPathEntity? newAlbum = await PhotoManager.editor.darwin.createAlbum(albumName);
      
      return newAlbum;
    }
// }
