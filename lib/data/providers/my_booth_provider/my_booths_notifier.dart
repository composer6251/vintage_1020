import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/data/local_db/my_booths_db.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

part 'my_booths_notifier.g.dart';

@riverpod
class MyBoothsNotifier extends _$MyBoothsNotifier {
  @override
  List<MyBooth> build() {
    print('MyBoothNotifier build');
    return [];
  }

  Future<void> fetchUserBooths() async {
    List<MyBooth> userBooths = await MyBoothsDb().fetchUserBoothsByEmail();

    if (ref.mounted) {
      print('Updating state with user booths ${userBooths.length}');
      state = userBooths;
    }
  }

  Future<List<MyBooth>> fetchUserBoothsReturn() async {
    List<MyBooth> userBooths = await MyBoothsDb().fetchUserBoothsByEmail();

    // state = userBooths;

    return userBooths;
  }

  Future<void> createBoothForUser(MyBooth boothToInsert) async {
    state = [...state, boothToInsert];
    await MyBoothsDb().createBoothForUser(boothToInsert);

    print('booths state after insert: ${state.length}');
  }

  Future<void> getCurrentBooth(String boothId) async {
    MyBooth currentBooth;
  }

  Future<void> addItemToBoothById(String itemId, String boothId) async {
    // Get boothFromState
    MyBooth currentBoothState = state
        .where((booth) => booth.id == boothId)
        .first;

    // Get Index of booth to update to maintain order
    int indexOfItemToUpdate = state.indexOf(currentBoothState);
    if (indexOfItemToUpdate == -1) {
      print('Failed to find item to update in current state');
      return;
    }
    List<String> boothCurrentItemIds = currentBoothState.boothInventoryIds;

    boothCurrentItemIds.add(itemId);

    currentBoothState.boothInventoryIds = boothCurrentItemIds;

    state.removeAt(indexOfItemToUpdate);
    state.insert(indexOfItemToUpdate, currentBoothState);
    await MyBoothsDb().createBoothForUser(currentBoothState);

    print('booths state after insert: ${state.length}');
  }

  Future<void> removeItemFromBoothById(String itemId, String boothId) async {
    // Get boothFromState
    MyBooth currentBoothState = state
        .where((booth) => booth.id == boothId)
        .first;

    // Get Index of booth to update to maintain order
    int indexOfItemToUpdate = state.indexOf(currentBoothState);
    if (indexOfItemToUpdate == -1) {
      print('Failed to find item to update in current state');
      return;
    }
    List<String> boothCurrentItemIds = currentBoothState.boothInventoryIds;

    boothCurrentItemIds.add(itemId);

    currentBoothState.boothInventoryIds = boothCurrentItemIds;

    state.removeAt(indexOfItemToUpdate);
    state.insert(indexOfItemToUpdate, currentBoothState);
    await MyBoothsDb().createBoothForUser(currentBoothState);

    print('booths state after insert: ${state.length}');
  }

  Future<void> updateBooth(MyBooth booth) async {
    // Get boothFromState
    MyBooth currentBoothState = state
        .where((booth) => booth.id == booth.id)
        .first;

    // Get Index of booth to update to maintain order
    int indexOfItemToUpdate = state.indexOf(currentBoothState);
    if (indexOfItemToUpdate == -1) {
      print('Failed to find item to update in current state');
      return;
    }
    state.removeAt(indexOfItemToUpdate);
    state.insert(indexOfItemToUpdate, booth);

    await MyBoothsDb().updateBooth(booth);

    print('booths state after insert: ${state.length}');
  }
}

Future<void> getCurrentBooth(String boothId) async {
  MyBooth currentBooth;
}

@riverpod
List<String> getNamesOfBooths(Ref ref) {
  List<MyBooth> currentBooths = ref.watch(myBoothsProvider);

  List<String> boothNames = currentBooths
      .map((booth) => booth.boothName)
      .toList();

  return boothNames;
}
