

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/model/inventory_item_local/inventory_item_local.dart';

part 'inventory_local_provider.g.dart';

@Riverpod(keepAlive: true)
class InventoryLocal extends _$InventoryLocal{

  @override 
  List<InventoryItemLocal> build() {
    return [];
  }

  List<InventoryItemLocal> getInventoryLocal() {


    return [];
  }
}