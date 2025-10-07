import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_image_provider.g.dart';

@Riverpod(keepAlive: true)
class FirestoreImage extends _$FirestoreImage {
  @override
  List<File> build(Ref ref) {
    state = [];
    return state;
  }

  List<File> getImages(Ref ref) {
    return state;
  }

  void setImages(List<File> images) {
    state = [...state, ...images];
  }
}
