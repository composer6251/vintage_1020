

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/domain/models/model/inventory_item/inventory_item.dart';

abstract class InventoryRepository {

  Future<List<InventoryItem>> getInventoryByUserEmail(String email);

  Future<void> addInventoryItem(InventoryItem item);

  Future<void> updateInventoryItem(InventoryItem item);

  Future<void> deleteInventoryItem(num id);
}