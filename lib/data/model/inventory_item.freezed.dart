// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InventoryItem {

 String get id; List<String> get itemImageUrls; DateTime get itemPurchaseDate; double? get itemPurchasePrice; InventoryCategory get itemCategory; DateTime? get itemListingDate; double? get itemListingPrice; double? get itemSoldPrice; String? get primaryImageUrl; String? get itemDescription; DateTime? get itemSoldDate;
/// Create a copy of InventoryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryItemCopyWith<InventoryItem> get copyWith => _$InventoryItemCopyWithImpl<InventoryItem>(this as InventoryItem, _$identity);

  /// Serializes this InventoryItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryItem&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.itemImageUrls, itemImageUrls)&&(identical(other.itemPurchaseDate, itemPurchaseDate) || other.itemPurchaseDate == itemPurchaseDate)&&(identical(other.itemPurchasePrice, itemPurchasePrice) || other.itemPurchasePrice == itemPurchasePrice)&&(identical(other.itemCategory, itemCategory) || other.itemCategory == itemCategory)&&(identical(other.itemListingDate, itemListingDate) || other.itemListingDate == itemListingDate)&&(identical(other.itemListingPrice, itemListingPrice) || other.itemListingPrice == itemListingPrice)&&(identical(other.itemSoldPrice, itemSoldPrice) || other.itemSoldPrice == itemSoldPrice)&&(identical(other.primaryImageUrl, primaryImageUrl) || other.primaryImageUrl == primaryImageUrl)&&(identical(other.itemDescription, itemDescription) || other.itemDescription == itemDescription)&&(identical(other.itemSoldDate, itemSoldDate) || other.itemSoldDate == itemSoldDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(itemImageUrls),itemPurchaseDate,itemPurchasePrice,itemCategory,itemListingDate,itemListingPrice,itemSoldPrice,primaryImageUrl,itemDescription,itemSoldDate);

@override
String toString() {
  return 'InventoryItem(id: $id, itemImageUrls: $itemImageUrls, itemPurchaseDate: $itemPurchaseDate, itemPurchasePrice: $itemPurchasePrice, itemCategory: $itemCategory, itemListingDate: $itemListingDate, itemListingPrice: $itemListingPrice, itemSoldPrice: $itemSoldPrice, primaryImageUrl: $primaryImageUrl, itemDescription: $itemDescription, itemSoldDate: $itemSoldDate)';
}


}

/// @nodoc
abstract mixin class $InventoryItemCopyWith<$Res>  {
  factory $InventoryItemCopyWith(InventoryItem value, $Res Function(InventoryItem) _then) = _$InventoryItemCopyWithImpl;
@useResult
$Res call({
 String id, List<String> itemImageUrls, DateTime itemPurchaseDate, double? itemPurchasePrice, InventoryCategory itemCategory, DateTime? itemListingDate, double? itemListingPrice, double? itemSoldPrice, String? primaryImageUrl, String? itemDescription, DateTime? itemSoldDate
});




}
/// @nodoc
class _$InventoryItemCopyWithImpl<$Res>
    implements $InventoryItemCopyWith<$Res> {
  _$InventoryItemCopyWithImpl(this._self, this._then);

  final InventoryItem _self;
  final $Res Function(InventoryItem) _then;

/// Create a copy of InventoryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? itemImageUrls = null,Object? itemPurchaseDate = null,Object? itemPurchasePrice = freezed,Object? itemCategory = null,Object? itemListingDate = freezed,Object? itemListingPrice = freezed,Object? itemSoldPrice = freezed,Object? primaryImageUrl = freezed,Object? itemDescription = freezed,Object? itemSoldDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,itemImageUrls: null == itemImageUrls ? _self.itemImageUrls : itemImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,itemPurchaseDate: null == itemPurchaseDate ? _self.itemPurchaseDate : itemPurchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime,itemPurchasePrice: freezed == itemPurchasePrice ? _self.itemPurchasePrice : itemPurchasePrice // ignore: cast_nullable_to_non_nullable
as double?,itemCategory: null == itemCategory ? _self.itemCategory : itemCategory // ignore: cast_nullable_to_non_nullable
as InventoryCategory,itemListingDate: freezed == itemListingDate ? _self.itemListingDate : itemListingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,itemListingPrice: freezed == itemListingPrice ? _self.itemListingPrice : itemListingPrice // ignore: cast_nullable_to_non_nullable
as double?,itemSoldPrice: freezed == itemSoldPrice ? _self.itemSoldPrice : itemSoldPrice // ignore: cast_nullable_to_non_nullable
as double?,primaryImageUrl: freezed == primaryImageUrl ? _self.primaryImageUrl : primaryImageUrl // ignore: cast_nullable_to_non_nullable
as String?,itemDescription: freezed == itemDescription ? _self.itemDescription : itemDescription // ignore: cast_nullable_to_non_nullable
as String?,itemSoldDate: freezed == itemSoldDate ? _self.itemSoldDate : itemSoldDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _InventoryItem implements InventoryItem {
  const _InventoryItem({required this.id, required final  List<String> itemImageUrls, required this.itemPurchaseDate, this.itemPurchasePrice, required this.itemCategory, this.itemListingDate, this.itemListingPrice, this.itemSoldPrice, this.primaryImageUrl, this.itemDescription, this.itemSoldDate}): _itemImageUrls = itemImageUrls;
  factory _InventoryItem.fromJson(Map<String, dynamic> json) => _$InventoryItemFromJson(json);

@override final  String id;
 final  List<String> _itemImageUrls;
@override List<String> get itemImageUrls {
  if (_itemImageUrls is EqualUnmodifiableListView) return _itemImageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_itemImageUrls);
}

@override final  DateTime itemPurchaseDate;
@override final  double? itemPurchasePrice;
@override final  InventoryCategory itemCategory;
@override final  DateTime? itemListingDate;
@override final  double? itemListingPrice;
@override final  double? itemSoldPrice;
@override final  String? primaryImageUrl;
@override final  String? itemDescription;
@override final  DateTime? itemSoldDate;

/// Create a copy of InventoryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InventoryItemCopyWith<_InventoryItem> get copyWith => __$InventoryItemCopyWithImpl<_InventoryItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InventoryItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InventoryItem&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._itemImageUrls, _itemImageUrls)&&(identical(other.itemPurchaseDate, itemPurchaseDate) || other.itemPurchaseDate == itemPurchaseDate)&&(identical(other.itemPurchasePrice, itemPurchasePrice) || other.itemPurchasePrice == itemPurchasePrice)&&(identical(other.itemCategory, itemCategory) || other.itemCategory == itemCategory)&&(identical(other.itemListingDate, itemListingDate) || other.itemListingDate == itemListingDate)&&(identical(other.itemListingPrice, itemListingPrice) || other.itemListingPrice == itemListingPrice)&&(identical(other.itemSoldPrice, itemSoldPrice) || other.itemSoldPrice == itemSoldPrice)&&(identical(other.primaryImageUrl, primaryImageUrl) || other.primaryImageUrl == primaryImageUrl)&&(identical(other.itemDescription, itemDescription) || other.itemDescription == itemDescription)&&(identical(other.itemSoldDate, itemSoldDate) || other.itemSoldDate == itemSoldDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_itemImageUrls),itemPurchaseDate,itemPurchasePrice,itemCategory,itemListingDate,itemListingPrice,itemSoldPrice,primaryImageUrl,itemDescription,itemSoldDate);

@override
String toString() {
  return 'InventoryItem(id: $id, itemImageUrls: $itemImageUrls, itemPurchaseDate: $itemPurchaseDate, itemPurchasePrice: $itemPurchasePrice, itemCategory: $itemCategory, itemListingDate: $itemListingDate, itemListingPrice: $itemListingPrice, itemSoldPrice: $itemSoldPrice, primaryImageUrl: $primaryImageUrl, itemDescription: $itemDescription, itemSoldDate: $itemSoldDate)';
}


}

/// @nodoc
abstract mixin class _$InventoryItemCopyWith<$Res> implements $InventoryItemCopyWith<$Res> {
  factory _$InventoryItemCopyWith(_InventoryItem value, $Res Function(_InventoryItem) _then) = __$InventoryItemCopyWithImpl;
@override @useResult
$Res call({
 String id, List<String> itemImageUrls, DateTime itemPurchaseDate, double? itemPurchasePrice, InventoryCategory itemCategory, DateTime? itemListingDate, double? itemListingPrice, double? itemSoldPrice, String? primaryImageUrl, String? itemDescription, DateTime? itemSoldDate
});




}
/// @nodoc
class __$InventoryItemCopyWithImpl<$Res>
    implements _$InventoryItemCopyWith<$Res> {
  __$InventoryItemCopyWithImpl(this._self, this._then);

  final _InventoryItem _self;
  final $Res Function(_InventoryItem) _then;

/// Create a copy of InventoryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? itemImageUrls = null,Object? itemPurchaseDate = null,Object? itemPurchasePrice = freezed,Object? itemCategory = null,Object? itemListingDate = freezed,Object? itemListingPrice = freezed,Object? itemSoldPrice = freezed,Object? primaryImageUrl = freezed,Object? itemDescription = freezed,Object? itemSoldDate = freezed,}) {
  return _then(_InventoryItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,itemImageUrls: null == itemImageUrls ? _self._itemImageUrls : itemImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,itemPurchaseDate: null == itemPurchaseDate ? _self.itemPurchaseDate : itemPurchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime,itemPurchasePrice: freezed == itemPurchasePrice ? _self.itemPurchasePrice : itemPurchasePrice // ignore: cast_nullable_to_non_nullable
as double?,itemCategory: null == itemCategory ? _self.itemCategory : itemCategory // ignore: cast_nullable_to_non_nullable
as InventoryCategory,itemListingDate: freezed == itemListingDate ? _self.itemListingDate : itemListingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,itemListingPrice: freezed == itemListingPrice ? _self.itemListingPrice : itemListingPrice // ignore: cast_nullable_to_non_nullable
as double?,itemSoldPrice: freezed == itemSoldPrice ? _self.itemSoldPrice : itemSoldPrice // ignore: cast_nullable_to_non_nullable
as double?,primaryImageUrl: freezed == primaryImageUrl ? _self.primaryImageUrl : primaryImageUrl // ignore: cast_nullable_to_non_nullable
as String?,itemDescription: freezed == itemDescription ? _self.itemDescription : itemDescription // ignore: cast_nullable_to_non_nullable
as String?,itemSoldDate: freezed == itemSoldDate ? _self.itemSoldDate : itemSoldDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
