import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vintage_1020/ui/core/ui/util/image_util.dart';

class ImageTesting extends StatefulHookWidget {

  const ImageTesting({super.key});
  
  @override
  State<ImageTesting> createState() => _ImageTestingState();

}

class _ImageTestingState extends State<ImageTesting> {

  @override
  Widget build(BuildContext context) {
    final selectedImages0 = useState<List<XFile?>?>(null);
    final savedImages0 = useState<List<File>>([]);

    void pickImages() async {
      List<XFile> selectedImages = await pickMultipleImagesFromGallery();

      selectedImages0.value = selectedImages;

      List<File> savedImages = await saveImagesAndReturnFile(selectedImages);
      savedImages0.value = savedImages;
      
    }

    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(onPressed: pickImages, child: Text('Select Images')),
        TextButton(onPressed: getAssetsFromInventoryAlbum, child: Text('Select Album'))
        ],
      ),
      body: savedImages0.value.isNotEmpty ?
        Image.file(savedImages0.value.first) : 
        Text('Please select photos')
      ,);
  }
}
