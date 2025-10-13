

// Create class with annotation
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_notifier.g.dart';

enum InventoryFilter {
  all,
  listed,
  sold,
  furniture,
  backStock,
  deleted,
  current,
}

@riverpod
class FilterNotifier extends _$FilterNotifier{

  @override
  InventoryFilter build() {

    return InventoryFilter.all;
  }

  void setCurrentFilter(InventoryFilter filter) {
    state = filter;
  }

  void setCurrentTabInventoryFilter(int tabInd) {

    switch (tabInd) {
      case 1:
        state = InventoryFilter.listed;
      case 2:
        state = InventoryFilter.current;
      default:
        state = InventoryFilter.all;
    }
  }
}