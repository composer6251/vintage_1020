import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/constants/api_urls.dart';
import 'package:vintage_1020/data/api/b_t_api/b_t_api.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';
import 'package:http/http.dart' as http;
import 'package:vintage_1020/data/repositories/inventory_repository.dart';
import 'package:vintage_1020/data/repositories/inventory_repository_impl.dart';

part "future_inventory_provider.g.dart";

@riverpod
class FutureInventoryProvider extends _$FutureInventoryProvider {
  late final InventoryRepository inventoryRepository;
  List<FutureInventoryProvider> _items = [];

  @override
  FutureOr<List<FutureInventoryProvider>> build() async {
    // inventoryRepository = r

    return _items;
  }

  // InventoryRepository inventoryRepository(Ref ref) => InventoryRepositoryImpl();
}
