import 'dart:io';
import 'dart:io' as io;

import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:path_provider/path_provider.dart' as sys_path;
import 'package:path/path.dart' as path;

// create method to create a photo album in the gallery
// to save images to a specific album in the gallery

final String appNameForImages = 'Vintage_1020';

loadFileFromLocal(String imageUrl) async {
  Directory directory = await sys_path.getApplicationDocumentsDirectory();

  AssetPathEntity album = await loadInventoryPhotoAlbum();

  // final mediaFiles = io.Directory('$directory/')
  //     .listSync()
  //     .whereType<File>()
  //     .where((file) => file.path.split('/').last.startsWith('media'));
  // Iterable<File> files = mediaFiles.whereType<File>();
  // files.where((file) => file.path == imageUrl);

  return album.getSubPathList();
}

/*****
 * TODO: 
 * 1. get album according to app name
 * 2. get assets in album
 * 3. add assetId and albumId to InventoryItem
 * 4. Get files from assets.
 */

Future<List<File?>> getAssetsFromInventoryAlbum() async {
  
  List<AssetPathEntity> currentPhotoAlbums =
      await PhotoManager.getAssetPathList(
        type: RequestType.image,
        hasAll: false,
      );
  
  AssetPathEntity album =
      currentPhotoAlbums.firstWhere((e) => e.name == appNameForImages);

  int assetCount = await album.assetCountAsync;
  List<AssetEntity> assets = await album.getAssetListRange(start: 0, end: assetCount);

  // List<File?> images = assets.map((a) =>  a.loadFile()).toList();
  
  return getAssets(assets);
}

Future<List<File?>> getAssets(List<AssetEntity> assets) async {

  List<File?> files = [];
  for(AssetEntity asset in assets) {
    files.add(await asset.loadFile());
  }
  return files;
}

Future<AssetPathEntity> loadInventoryPhotoAlbum() async {
  
  List<AssetPathEntity> currentPhotoAlbums =
      await PhotoManager.getAssetPathList(
        type: RequestType.image,
        hasAll: false,
      );

  AssetPathEntity album =
      currentPhotoAlbums.firstWhere((e) => e.name == appNameForImages);
  
  return album;
}

Future<String> handleImageSelection(XFile image, String? imageName) async {
  AssetPathEntity? pathEntity = await createInventoryPhotoAlbum(
    appNameForImages,
  );

  if (image.path.isEmpty) return '';
  // Save image to disk
  AssetEntity assetEntity = await saveImage(image.path, imageName!);

  // Save image to album
  saveImageToAlbum(assetEntity, pathEntity!);

  // TODO: SHOULD THIS BE IMAGE.PATH OR GET FULL FILE RETURNED PATH?
  String? url = await getFullFile(image.path, isOrigin: false);
  print('image.path: ${image.path}' + '\nurl: $url');

  return image.path;
}

/****CREATE ALBUM IN PHOTOS LIBRARY ON IOS FOR VINTAGE_1020 IF IT DOESN'T ALREADY EXIST */
Future<AssetPathEntity?> createInventoryPhotoAlbum(String albumName) async {
  List<AssetPathEntity> currentPhotoAlbums =
      await PhotoManager.getAssetPathList(
        type: RequestType.image,
        hasAll: false,
      );
  // Check if the album already exists
  for (AssetPathEntity album in currentPhotoAlbums) {
    if (album.name == appNameForImages) {
      return AssetPathEntity(
        id: album.id,
        name: album.name ?? '',
        isAll: false,
      );
    }
  }

  AssetPathEntity? newAlbum = await PhotoManager.editor.darwin.createAlbum(
    albumName,
  );

  return newAlbum;
}

Future<AssetEntity> saveImage(String imagePath, String? category) async {
  AssetEntity savedImage = await PhotoManager.editor.saveImageWithPath(
    imagePath,
  );

  return savedImage;
}

void saveImageToAlbum(AssetEntity entity, AssetPathEntity pathEntity) async {
  try {
    await PhotoManager.plugin.copyAssetToGallery(entity, pathEntity);
  } catch (e) {
    print('Error saving image to album: $e');
  }
}

// Take in List<XFile>

// get appDir

// File file = writeAsBytes from XFile read as bytes

// Add to list

Future<List<File>> saveImageAndReturnFile(List<XFile> images) async {
    int index = 0;

    List<File> savedImages = [];
    for(var x in images) {
      final appDir = await sys_path.getApplicationDocumentsDirectory();

      // Get filename of image
      String appDirPath = appDir.path;

      
      File file = File('$appDirPath/$index.jpg');
      File savedFile = await file.writeAsBytes(await x.readAsBytes());

      savedImages.add(savedFile);
    }

    return savedImages;
}

    Future<List<XFile>> pickMultipleImagesFromGallery() async {
      print('Picking multiple images from gallery...');
      final picker = ImagePicker();
      final List<XFile> pickedFiles = await picker.pickMultiImage();

      return pickedFiles;
    }

Future<List<String>> saveImageCurrent(XFile image, String index) async {
      if (image.path.isEmpty) return [];
      // Get directory on local device for storing images.
      final appDir = await sys_path.getApplicationDocumentsDirectory();
      
      // Get filename of image
      String appDirPath = appDir.path;
      print('appDir Path: $appDirPath');

        // Create album if it doesn't exist
        AssetPathEntity? pathEntity = await createInventoryPhotoAlbum(
          appNameForImages,
        );
        if (pathEntity == null) {
          print('Failed to create album: $appNameForImages');
          return [];
        }

        AssetEntity savedImage = await saveImage(image.path, null);
        final assetEntityFile = await savedImage.file;

        // Adds image reference to the album created above
        await PhotoManager.plugin.copyAssetToGallery(savedImage, pathEntity);

        String? photoUrl = await PhotoManager.plugin.getFullFile(
          savedImage.id,
          isOrigin: false,
        );
        // Return imageUrl
        return [photoUrl!];
    }

Future<String?> getFullFile(String id, {bool isOrigin = true}) async {
  String? photoUrl;
  try {
    photoUrl = await PhotoManager.plugin.getFullFile(id, isOrigin: isOrigin);
  } catch (e) {
    print('Error getting full file: $e');
    return null;
  }
  return photoUrl;
}
