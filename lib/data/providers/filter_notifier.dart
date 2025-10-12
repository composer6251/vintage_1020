

// Create class with annotation
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/providers/inventory_filter_provider/inventory_filter_provider.dart';

part 'filter_notifier.g.dart';

@riverpod
class FilterNotifier extends _$FilterNotifier{

  @override
  Map<InventoryFilter, bool> build() {
    return ({
      InventoryFilter.all: true,
      InventoryFilter.myBooth: false,
      InventoryFilter.listed: false,
      InventoryFilter.sold: false,
      InventoryFilter.furniture: false,
      InventoryFilter.deleted: false,
      InventoryFilter.current: false,
    });
  }

  void setCurrentFilters(Map<InventoryFilter, bool> filters) {
    state = filters;
  }
}