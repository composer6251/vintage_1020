import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vintage_1020/domain/providers/firestore_provider/firestore_image_provider.dart';
import 'package:vintage_1020/domain/providers/firestore_provider/firestore_provider.dart';
import 'package:vintage_1020/ui/core/ui/util/image_util.dart';

class ImageTesting extends StatefulHookWidget {

  const ImageTesting({super.key});
  
  @override
  State<ImageTesting> createState() => _ImageTestingState();

}

class _ImageTestingState extends State<ImageTesting> {

  @override
  Widget build(BuildContext context) {
    final _selectedImages = useState<List<XFile?>?>(null);
    final _savedImages = useState<List<File>>([]);

    void pickImages() async {
      List<XFile> selectedImages = await pickMultipleImagesFromGallery();

      _selectedImages.value = selectedImages;

      List<File> savedImages = await saveImageAndReturnFile(selectedImages);
      _savedImages.value = savedImages;
      
    }

    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(onPressed: pickImages, child: Text('Select Images')),
        TextButton(onPressed: loadInventoryPhotoAlbum, child: Text('Select Album'))
      ],
      ),
      body: _savedImages.value.isNotEmpty ?
        Image.file(_savedImages.value.first) : 
        Text('Please select photos')
      ,);
  }
}
