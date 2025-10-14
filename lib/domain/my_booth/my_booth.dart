import 'dart:core';
import 'dart:io';
import 'dart:convert';

import 'package:uuid/uuid.dart';

final Uuid uuid = Uuid();

/// DATA CLASS FOR MY_BOOTH_TAB
class MyBooth {
  String id = '';
  String? userEmail;
  List<String>? currentBoothImageUrls;
  DateTime? boothDeleteDate;

  MyBooth.empty();

  MyBooth(
    this.id,
    this.userEmail,
    this.currentBoothImageUrls,
    this.boothDeleteDate,
  );

  MyBooth.fromLocalDB(Map<String, dynamic> data)
    : id = data['id'],
      userEmail = data?['email'],
      currentBoothImageUrls = data?['currentBoothImageUrls'] != null 
          ? List<String>.from(jsonDecode(data['currentBoothImageUrls'])) : [],
      boothDeleteDate = data['boothDeleteDate'] != null 
          ? DateTime.parse(data['boothDeleteDate']) as DateTime? : null;


  Map<String, dynamic> toMapForLocalDB() {
    return <String, dynamic>{
      "id": id,
      "email": userEmail,
      "currentBoothImageUrls": jsonEncode(currentBoothImageUrls),
    };
  }


  MyBooth.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      currentBoothImageUrls = json['currentBoothImageUrls'],
      userEmail = json['email'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': userEmail,
    'currentBoothImageUrls': currentBoothImageUrls,
  };
}
