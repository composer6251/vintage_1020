

// Create class with annotation
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/providers/inventory_filter_provider/inventory_filter_provider.dart';

part 'filter_notifier.g.dart';

@riverpod
class FilterNotifier extends _$FilterNotifier{

  @override
  InventoryFilter build() {

    return InventoryFilter.all;
    // return ({
    //   InventoryFilter.all: true,
    //   InventoryFilter.myBooth: false,
    //   InventoryFilter.listed: false,
    //   InventoryFilter.sold: false,
    //   InventoryFilter.furniture: false,
    //   InventoryFilter.deleted: false,
    //   InventoryFilter.current: false,
    // });
  }

  void setCurrentFilters(InventoryFilter filter) {
    state = filter;
  }
}