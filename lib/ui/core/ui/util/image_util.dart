import 'dart:io';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:path_provider/path_provider.dart' as sys_path;
import 'package:path/path.dart' as path;

/******* IMAGE CHEAT SHEET
 *      ImagePicker returns XFile types, which are abstractions so that they are platform independent. 
 *      XFiles can be cast to File types.
 *      
 *      *The path_provider package can be utilized to get the application documents directory to use a save location path
 *      
 *      Image Files can be saved via File.copy
 *      
 *      
 * 
 * 
 *      The UI layer can render File types
 * 
 * 
 * 
 * 
 */

///
///CONSTANTS *****************************

final String appNameForImages = 'Vintage_1020';

///
/// ************** IMAGE SELECTING *********
///

///
/// OPEN CAMERA AND RETURN PHOTO TAKEN
Future<File> takeCameraPhoto() async {
  // INSTANTIATE IMAGE PICKER
  final picker = ImagePicker();

  // OPEN CAMERA APP TO TAKE PICTURE
  XFile? image = await picker.pickImage(
    source: ImageSource.camera,
    imageQuality: 90,
  );
  File file = getFileFromXFile(image!);
  AlertDialog(content: Text('Picking photo with path ${file.path}'));

  return file;
}

/// CONVERT XFILE FROM SELECTED PHOTO/TAKEN PHOTO TO FILE TYPE
/// SO THAT IT CAN BE RENDERED
File getFileFromXFile(XFile xFile) {
  return File(xFile.path);
}

/// OPEN PHOTO APP FOR THE USER TO SELECT IMAGES AND RETURN SELECTED IMAGES
Future<List<XFile>> pickMultipleImagesFromGallery() async {
  // INSTANTIATE IMAGE PICKER
  final picker = ImagePicker();
  // OPEN PHOTO APP SO USER CAN SELECT PHOTOS
  final List<XFile> pickedFiles = await picker.pickMultiImage();

  return pickedFiles;
}

//**************** IMAGE SAVING ************

// SAVING WITH FILE.copy
Future<List<File>> saveXFileListAndReturnSavedPaths(List<XFile> xFiles) async {
  // GET FILES FROM XFILES
  List<File> files = xFiles.map((xFile) => getFileFromXFile(xFile)).toList();

  // COPY FILES
  List<File> pathsOfSavedFiles = await saveFiles(files);

  return pathsOfSavedFiles;
}

List<String> getPathsForSavedFiles(List<File> savedFiles) {
  List<String> paths = [];
  for (var savedFile in savedFiles) {
    paths.add(savedFile.path);
  }

  return paths;
}

Future<List<File>> saveFiles(List<File> imageFiles) async {
  List<File> copiedFiles = [];

  for (File imageFile in imageFiles) {
    final File copiedFile = await copySingleImageFile(imageFile);

    copiedFiles.add(copiedFile);
  }

  // ERROR OR NO FILES
  if (copiedFiles.isEmpty) {
    return [];
  }

  return copiedFiles;
}

/// COPIES A FILE TO LOCAL STORAGE AND RETURNS IT
Future<File> copySingleImageFile(File image) async {
  // GET DIRECTORY TO SAVE TO
  final Directory appDir = await sys_path.getApplicationDocumentsDirectory();
  // GET FILE NAME
  final String fileName = path.basename(image.path);
  // CREATE FILE PATH TO SAVE IMAGE
  final String filePathToSave = '${appDir.path}/$fileName';

  print('Saving File with path $filePathToSave');

  // COPY IMAGE
  final File copiedImage = await image.copy(filePathToSave);

  return copiedImage;
}

/// Saves XFiles to local and returns Files to be displayed
Future<List<File>> saveImagesAndReturnFile(List<XFile> images) async {
  int index = 0;

  List<File> savedImages = [];
  for (var x in images) {
    final appDir = await sys_path.getApplicationDocumentsDirectory();

    // Get filename of image
    String appDirPath = appDir.path;

    File file = File('$appDirPath/$index.jpg');
    File savedFile = await file.writeAsBytes(await x.readAsBytes());

    savedImages.add(savedFile);
  }

  return savedImages;
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

  AssetEntity savedImage = await saveImageWithPathViaPhotoManager(
    image.path,
    null,
  );
  final assetEntityFile = await savedImage.file;

  print(
    'IMAGE_UTIL.saveImageCurrent saved image path(assetEntityFile.path): ${assetEntityFile?.path}',
  );

  // Adds image reference to the album created above
  await PhotoManager.plugin.copyAssetToGallery(savedImage, pathEntity);

  String? photoUrl = await PhotoManager.plugin.getFullFile(
    savedImage.id,
    isOrigin: false,
  );
  print('IMAGE_UTIL.saveImageCurrent photoURL: $photoUrl');
  // Return imageUrl
  return [photoUrl!];
}

// Saving with PhotoManager
Future<AssetEntity> saveImageWithPathViaPhotoManager(
  String imagePath,
  String? category,
) async {
  AssetEntity savedImage = await PhotoManager.editor.saveImageWithPath(
    imagePath,
  );

  return savedImage;
}

Future<List<String>> saveSingleXFileImageController(
  XFile image,
  String index,
) async {
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

  AssetEntity savedImage = await saveImageWithPathViaPhotoManager(
    image.path,
    null,
  );
  final assetEntityFile = await savedImage.file;

  print(
    'IMAGE_UTIL.saveImageCurrent saved image path(assetEntityFile.path): ${assetEntityFile?.path}',
  );

  // Adds image reference to the album created above
  await PhotoManager.plugin.copyAssetToGallery(savedImage, pathEntity);

  String? photoUrl = await PhotoManager.plugin.getFullFile(
    savedImage.id,
    isOrigin: false,
  );
  print('IMAGE_UTIL.saveImageCurrent photoURL: $photoUrl');
  // Return imageUrl
  return [photoUrl!];
}

///
/// ************** IMAGE LOADING ***********

///
//**************PHOTO ALBUM******************

Future<AssetPathEntity> loadInventoryPhotoAlbum() async {
  List<AssetPathEntity> currentPhotoAlbums =
      await PhotoManager.getAssetPathList(
        type: RequestType.image,
        hasAll: false,
      );

  AssetPathEntity album = currentPhotoAlbums.firstWhere(
    (e) => e.name == appNameForImages,
  );

  return album;
}

Future<List<File?>> getAssetsFromInventoryAlbum() async {
  List<AssetPathEntity> currentPhotoAlbums =
      await PhotoManager.getAssetPathList(
        type: RequestType.image,
        hasAll: false,
      );

  AssetPathEntity album = currentPhotoAlbums.firstWhere(
    (e) => e.name == appNameForImages,
  );

  int assetCount = await album.assetCountAsync;
  List<AssetEntity> assets = await album.getAssetListRange(
    start: 0,
    end: assetCount,
  );

  return getAssetsFromAssetEntities(assets);
}

void saveImageToAlbum(AssetEntity entity, AssetPathEntity pathEntity) async {
  try {
    await PhotoManager.plugin.copyAssetToGallery(entity, pathEntity);
  } catch (e) {
    print('Error saving image to album: $e');
  }
}

Future<List<File?>> getAssetsFromAssetEntities(List<AssetEntity> assets) async {
  List<File?> files = [];
  for (AssetEntity asset in assets) {
    files.add(await asset.loadFile());
  }

  return files;
}

getFileFromAssetId() {
  String? verboseFilePath = PhotoManager.getVerboseFilePath();
}

Future<String> handleImageSelection(XFile image, String? imageName) async {
  // Create new album if it doesn't exist
  AssetPathEntity? pathEntity = await createInventoryPhotoAlbum(
    appNameForImages,
  );

  if (image.path.isEmpty) return '';
  print('image path: ${image.path}');

  // Save image to disk
  AssetEntity assetEntity = await saveImageWithPathViaPhotoManager(
    image.path,
    imageName!,
  );
  String? savedImagePath = await assetEntity.getMediaUrl();
  print('Saved Image Media URL: $savedImagePath');

  // Save image to album
  saveImageToAlbum(assetEntity, pathEntity!);

  String? url = await getFullFile(image.path, isOrigin: false);
  print(
    'image.path: ${image.path}'
    '\nurl: $url',
  );

  return image.path;
}

/// **CREATE ALBUM IN PHOTOS LIBRARY ON IOS FOR VINTAGE_1020 IF IT DOESN'T ALREADY EXIST
Future<AssetPathEntity?> createInventoryPhotoAlbum(String albumName) async {
  List<AssetPathEntity> currentPhotoAlbums =
      await PhotoManager.getAssetPathList(
        type: RequestType.image,
        hasAll: false,
      );
  // Check if the album already exists
  for (AssetPathEntity album in currentPhotoAlbums) {
    if (album.name == appNameForImages) {
      return AssetPathEntity(id: album.id, name: album.name, isAll: false);
    }
  }

  AssetPathEntity? newAlbum = await PhotoManager.editor.darwin.createAlbum(
    albumName,
  );

  return newAlbum;
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

Future<Future<List<AssetPathEntity>>> loadFileFromLocal(String imageUrl) async {
  Directory directory = await sys_path.getApplicationDocumentsDirectory();

  AssetPathEntity album = await loadInventoryPhotoAlbum();

  // final mediaFiles = io.Directory('$directory/')
  //     .listSync()
  //     .whereType<File>()
  //     .where((file) => file.path.split('/').last.startsWith('media'));
  // Iterable<File> files = mediaFiles.whereType<File>();
  // files.where((file) => file.path == imageUrl);

  // TODO: ONLY WORKS ON IOS
  return album.getSubPathList();
}

/// UNUSED METHODS
/// *******************************

    // saveFiles(List<XFile> imageFileList) async {
    //   int index = 0;
    //   List<String> savedImagesPaths = [];

    //   List<File> savedFiles = [];

    //   for (var x in imageFileList) {
    //     saveImageCurrent(x, "");
    //     final appDir = await sys_path.getApplicationDocumentsDirectory();
    //     // Get filename of image
    //     String appDirPath = appDir.path;
    //     File c = File(
    //       '$appDirPath/media$index.jpg',
    //     ); //File has to be created first
    //     c.writeAsBytesSync(await x.readAsBytes());
    //     index++;
    //     savedImagesPaths.add(appDirPath);
    //     savedFiles.add(c);
    //   }
    //   itemImageUrls.value = List.from(itemImageUrls.value)
    //     ..addAll(savedImagesPaths);
    // }

    // loadFiles() async {
    //   Directory directory = await sys_path.getApplicationDocumentsDirectory();
    //   final mediaFiles = io.Directory('$directory/')
    //       .listSync()
    //       .whereType<File>()
    //       .where((file) => file.path.split('/').last.startsWith('media'));
    //   Iterable<File> files = mediaFiles.whereType<File>();
    //   for (final file in files) {
    //     selectedImagesAsFiles.value.add(file);
    //   }
    // }
