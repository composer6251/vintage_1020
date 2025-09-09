import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

// create method to create a photo album in the gallery
// to save images to a specific album in the gallery

final String appNameForImages = 'Vintage_1020';

Future<String> handleImageSelection(XFile image, String? imageName) async {
  AssetPathEntity? pathEntity = await createInventoryPhotoAlbum(appNameForImages);

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

Future<String?> getFullFile(String id, {bool isOrigin = true}) async {
  String? photoUrl;
  try {
    photoUrl = 
      await PhotoManager.plugin.getFullFile(
          id,
          isOrigin: isOrigin,
        );
  } catch (e) {
      print('Error getting full file: $e');
      return null;
  }
  return photoUrl;
}



