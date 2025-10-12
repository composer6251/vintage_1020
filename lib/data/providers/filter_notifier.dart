

// Create class with annotation
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_notifier.g.dart';

enum InventoryFilter {
  all,
  myBooth,
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

    return InventoryFilter.myBooth;
  }

  void setCurrentFilters(InventoryFilter filter) {
    state = filter;
  }
}