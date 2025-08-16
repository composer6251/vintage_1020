

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';

abstract class InventoryRepository {

  AsyncValue<List<InventoryItem>> getInventoryByUserEmail(String email);

  Future<void> addInventoryItem(InventoryItem item);

  Future<void> updateInventoryItem(InventoryItem item);

  Future<void> deleteInventoryItem(num id);
}