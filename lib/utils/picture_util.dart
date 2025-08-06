import 'dart:io';

import 'package:image_picker/image_picker.dart';
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
// }
