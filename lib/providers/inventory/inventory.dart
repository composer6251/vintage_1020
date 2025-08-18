
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/domain/models/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/data/repositories/inventory_repository.dart';
import 'package:vintage_1020/data/repositories/inventory_repository_impl.dart';

part 'inventory.g.dart';


@riverpod
Future<List<InventoryItem>> getUserInventory(
  Ref ref, {
    required String userEmail,
  }
) async {

  return ref
    .watch(inventoryRepositoryProvider)
    .getInventoryByUserEmail(userEmail);

}

@riverpod
InventoryRepository inventoryRepository(Ref ref) => InventoryRepositoryImpl();
// final FirebaseAuth auth = FirebaseAuth.instance;
// String? email = auth.currentUser?.email;

// @riverpod
// class Inventory extends _$Inventory {



  // late final InventoryRepository inventoryRepository;
  // List<InventoryItem> _items = [];
  // String? userEmail = email;
  // void build(){}
  // List<InventoryItem> get => _items;

  // @override
  // FutureOr<List<InventoryItem>> build() async {
    
  //   state = await AsyncValue.guard(() async {
  //     return inventoryRepository.getInventoryByUserEmail(email!);
  //   });
  // }

// @override
//   AsyncValue<List<InventoryItem>> build()  {

//         state =  AsyncValue.guard(()  {
//       return inventoryRepository.getInventoryByUserEmail(email!);
//     });

//     return state;
//   }



  // InventoryRepository inventoryRepository(Ref ref) => InventoryRepositoryImpl();
// }
