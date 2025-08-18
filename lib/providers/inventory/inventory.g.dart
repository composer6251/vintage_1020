// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(getUserInventory)
const getUserInventoryProvider = GetUserInventoryFamily._();

final class GetUserInventoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<InventoryItem>>,
          List<InventoryItem>,
          FutureOr<List<InventoryItem>>
        >
    with
        $FutureModifier<List<InventoryItem>>,
        $FutureProvider<List<InventoryItem>> {
  const GetUserInventoryProvider._({
    required GetUserInventoryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getUserInventoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getUserInventoryHash();

  @override
  String toString() {
    return r'getUserInventoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<InventoryItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<InventoryItem>> create(Ref ref) {
    final argument = this.argument as String;
    return getUserInventory(ref, userEmail: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetUserInventoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getUserInventoryHash() => r'8ffeb071d7a2725610f3c074a369e3177a8ab34b';

final class GetUserInventoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<InventoryItem>>, String> {
  const GetUserInventoryFamily._()
    : super(
        retry: null,
        name: r'getUserInventoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetUserInventoryProvider call({required String userEmail}) =>
      GetUserInventoryProvider._(argument: userEmail, from: this);

  @override
  String toString() => r'getUserInventoryProvider';
}

@ProviderFor(inventoryRepository)
const inventoryRepositoryProvider = InventoryRepositoryProvider._();

final class InventoryRepositoryProvider
    extends
        $FunctionalProvider<
          InventoryRepository,
          InventoryRepository,
          InventoryRepository
        >
    with $Provider<InventoryRepository> {
  const InventoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inventoryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inventoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<InventoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InventoryRepository create(Ref ref) {
    return inventoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InventoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InventoryRepository>(value),
    );
  }
}

String _$inventoryRepositoryHash() =>
    r'b4eafb410b6e9ff666c01d55755393677bf5ce92';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
