// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(InventoryNotifier)
const inventoryNotifierProvider = InventoryNotifierProvider._();

final class InventoryNotifierProvider
    extends $NotifierProvider<InventoryNotifier, List<InventoryItem>> {
  const InventoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inventoryNotifierProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inventoryNotifierHash();

  @$internal
  @override
  InventoryNotifier create() => InventoryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<InventoryItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<InventoryItem>>(value),
    );
  }
}

String _$inventoryNotifierHash() => r'5a4a9fb4a842a0a3186d6889e77b75a39ea1605b';

abstract class _$InventoryNotifier extends $Notifier<List<InventoryItem>> {
  List<InventoryItem> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<InventoryItem>, List<InventoryItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<InventoryItem>, List<InventoryItem>>,
              List<InventoryItem>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
