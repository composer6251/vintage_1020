import 'dart:core';
import 'dart:io';
import 'dart:convert';

import 'package:uuid/uuid.dart';

final Uuid uuid = Uuid();

/// DATA CLASS FOR MY_BOOTH_TAB
class MyBooth {
  String id = uuid.v6();
  String? boothName;
  String? userEmail;
  List<String>? currentBoothImageUrls;
  DateTime? boothDeleteDate;

  MyBooth.empty();

  MyBooth(
    this.id,
    this.boothName,
    this.userEmail,
    this.currentBoothImageUrls,
    this.boothDeleteDate,
  );

  MyBooth.fromLocalDB(Map<String, dynamic> data)
    : id = data['id'],
      boothName = data?['boothName'],
      userEmail = data?['email'],
      currentBoothImageUrls = data?['currentBoothImageUrls'] != null
          ? List<String>.from(jsonDecode(data['currentBoothImageUrls']))
          : [],
      boothDeleteDate = data['boothDeleteDate'] != null
          ? DateTime.parse(data['boothDeleteDate']) as DateTime?
          : null;

  Map<String, dynamic> toMapForLocalDB() {
    return <String, dynamic>{
      "id": id,
      "boothName": boothName,
      "email": userEmail,
      "currentBoothImageUrls": jsonEncode(currentBoothImageUrls),
      "boothDeleteDate": boothDeleteDate,
    };
  }

  MyBooth.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      boothName = json['boothName'],
      userEmail = json['email'],
      currentBoothImageUrls = json['currentBoothImageUrls'],
      boothDeleteDate = json['boothDeleteDate'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'boothName': boothName,
    'email': userEmail,
    'currentBoothImageUrls': currentBoothImageUrls,
    'boothDeleteDate': boothDeleteDate,
  };
}
