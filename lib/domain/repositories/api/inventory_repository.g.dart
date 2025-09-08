// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(InventoryProvider)
const inventoryProviderProvider = InventoryProviderProvider._();

final class InventoryProviderProvider
    extends $NotifierProvider<InventoryProvider, List<InventoryItem>> {
  const InventoryProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inventoryProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inventoryProviderHash();

  @$internal
  @override
  InventoryProvider create() => InventoryProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<InventoryItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<InventoryItem>>(value),
    );
  }
}

String _$inventoryProviderHash() => r'f6bbe747943591678d37b98e749ed3757b6964be';

abstract class _$InventoryProvider extends $Notifier<List<InventoryItem>> {
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
