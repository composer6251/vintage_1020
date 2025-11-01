import 'dart:core';
import 'dart:convert';

import 'package:uuid/uuid.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';

final Uuid uuid = Uuid();

/// DATA CLASS FOR MY_BOOTH_TAB
class MyBooth {
  late String id;
  late String boothName;
  late String userEmail;
  List<String> boothInventoryIds = [];
  List<InventoryItemLocal>? boothInventory = [];

  List<String> currentBoothImageUrls = [];
  DateTime? boothDeleteDate;

  int get boothItemsCount {
    return boothInventoryIds.length;
  }

  double get boothCost {
    double boothCost =
        boothInventory?.fold<double>(
          0.0,
          (double sum, item) => sum + (item.itemPurchasePrice ?? 0.0),
        ) ??
        0.0;

    return boothCost;
  }

  double get boothValue {
    double boothValue =
        boothInventory?.fold<double>(
          0.0,
          (double sum, item) => sum + (item.itemListingPrice ?? 0.0),
        ) ??
        0.0;

    return boothValue;
  }

  double get boothMonthProfitToDate {
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;

    List<InventoryItemLocal> soldItems =
        boothInventory
            ?.where(
              (item) =>
                  item.itemSoldDate?.year == currentYear &&
                  item.itemSoldDate?.month == currentMonth,
            )
            .toList() ??
        [];

    double boothProfit = soldItems.fold<double>(
      0.0,
      (double sum, item) => sum + (item.itemSoldPrice ?? 0.0),
    );

    return boothProfit;
    ;
  }

  double get boothRentRemaining {
    double boothRentRemaining = boothMonthProfitToDate - 150;

    return boothRentRemaining;
  }

  MyBooth(
    this.id,
    this.boothName,
    this.userEmail,
    this.boothInventoryIds,
    this.currentBoothImageUrls,
    this.boothDeleteDate,
  );

  MyBooth.initial(this.boothName, this.currentBoothImageUrls);

  MyBooth.fromLocalDB(Map<String, dynamic> data)
    : id = data['id'],
      boothName = data['boothName'] ?? 'My Booth',
      userEmail = data['email'],
      boothInventoryIds = data['boothInventoryIds'] != null
          ? List<String>.from(jsonDecode(data['boothInventoryIds']))
          : [],
      currentBoothImageUrls = data['currentBoothImageUrls'] != null
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
      "boothInventoryIds": jsonEncode(boothInventoryIds),
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
