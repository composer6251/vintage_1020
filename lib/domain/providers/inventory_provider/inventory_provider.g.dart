// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InventoryNotifier)
const inventoryProvider = InventoryNotifierProvider._();

final class InventoryNotifierProvider
    extends $NotifierProvider<InventoryNotifier, List<InventoryItemLocal>> {
  const InventoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inventoryProvider',
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
  Override overrideWithValue(List<InventoryItemLocal> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<InventoryItemLocal>>(value),
    );
  }
}

String _$inventoryNotifierHash() => r'd2a75fbf5cd358b95e9cc1ad5be2cc6f4dc80e87';

abstract class _$InventoryNotifier extends $Notifier<List<InventoryItemLocal>> {
  List<InventoryItemLocal> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<List<InventoryItemLocal>, List<InventoryItemLocal>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<InventoryItemLocal>, List<InventoryItemLocal>>,
              List<InventoryItemLocal>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
