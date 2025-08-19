// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

 num? get id;// Optional ID for the item
 List<String> get itemImageUrls; DateTime get itemPurchaseDate; double? get itemPurchasePrice; InventoryCategory get itemCategory; DateTime? get itemListingDate; double? get itemListingPrice; double? get itemSoldPrice; String? get primaryImageUrl; String? get itemDescription; DateTime? get itemSoldDate; Map<String, String>? get itemDimensions;
/// Create a copy of InventoryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryItemCopyWith<InventoryItem> get copyWith => _$InventoryItemCopyWithImpl<InventoryItem>(this as InventoryItem, _$identity);

  /// Serializes this InventoryItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryItem&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.itemImageUrls, itemImageUrls)&&(identical(other.itemPurchaseDate, itemPurchaseDate) || other.itemPurchaseDate == itemPurchaseDate)&&(identical(other.itemPurchasePrice, itemPurchasePrice) || other.itemPurchasePrice == itemPurchasePrice)&&(identical(other.itemCategory, itemCategory) || other.itemCategory == itemCategory)&&(identical(other.itemListingDate, itemListingDate) || other.itemListingDate == itemListingDate)&&(identical(other.itemListingPrice, itemListingPrice) || other.itemListingPrice == itemListingPrice)&&(identical(other.itemSoldPrice, itemSoldPrice) || other.itemSoldPrice == itemSoldPrice)&&(identical(other.primaryImageUrl, primaryImageUrl) || other.primaryImageUrl == primaryImageUrl)&&(identical(other.itemDescription, itemDescription) || other.itemDescription == itemDescription)&&(identical(other.itemSoldDate, itemSoldDate) || other.itemSoldDate == itemSoldDate)&&const DeepCollectionEquality().equals(other.itemDimensions, itemDimensions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(itemImageUrls),itemPurchaseDate,itemPurchasePrice,itemCategory,itemListingDate,itemListingPrice,itemSoldPrice,primaryImageUrl,itemDescription,itemSoldDate,const DeepCollectionEquality().hash(itemDimensions));

@override
String toString() {
  return 'InventoryItem(id: $id, itemImageUrls: $itemImageUrls, itemPurchaseDate: $itemPurchaseDate, itemPurchasePrice: $itemPurchasePrice, itemCategory: $itemCategory, itemListingDate: $itemListingDate, itemListingPrice: $itemListingPrice, itemSoldPrice: $itemSoldPrice, primaryImageUrl: $primaryImageUrl, itemDescription: $itemDescription, itemSoldDate: $itemSoldDate, itemDimensions: $itemDimensions)';
}


}

/// @nodoc
abstract mixin class $InventoryItemCopyWith<$Res>  {
  factory $InventoryItemCopyWith(InventoryItem value, $Res Function(InventoryItem) _then) = _$InventoryItemCopyWithImpl;
@useResult
$Res call({
 num? id, List<String> itemImageUrls, DateTime itemPurchaseDate, double? itemPurchasePrice, InventoryCategory itemCategory, DateTime? itemListingDate, double? itemListingPrice, double? itemSoldPrice, String? primaryImageUrl, String? itemDescription, DateTime? itemSoldDate, Map<String, String>? itemDimensions
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? itemImageUrls = null,Object? itemPurchaseDate = null,Object? itemPurchasePrice = freezed,Object? itemCategory = null,Object? itemListingDate = freezed,Object? itemListingPrice = freezed,Object? itemSoldPrice = freezed,Object? primaryImageUrl = freezed,Object? itemDescription = freezed,Object? itemSoldDate = freezed,Object? itemDimensions = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as num?,itemImageUrls: null == itemImageUrls ? _self.itemImageUrls : itemImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,itemPurchaseDate: null == itemPurchaseDate ? _self.itemPurchaseDate : itemPurchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime,itemPurchasePrice: freezed == itemPurchasePrice ? _self.itemPurchasePrice : itemPurchasePrice // ignore: cast_nullable_to_non_nullable
as double?,itemCategory: null == itemCategory ? _self.itemCategory : itemCategory // ignore: cast_nullable_to_non_nullable
as InventoryCategory,itemListingDate: freezed == itemListingDate ? _self.itemListingDate : itemListingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,itemListingPrice: freezed == itemListingPrice ? _self.itemListingPrice : itemListingPrice // ignore: cast_nullable_to_non_nullable
as double?,itemSoldPrice: freezed == itemSoldPrice ? _self.itemSoldPrice : itemSoldPrice // ignore: cast_nullable_to_non_nullable
as double?,primaryImageUrl: freezed == primaryImageUrl ? _self.primaryImageUrl : primaryImageUrl // ignore: cast_nullable_to_non_nullable
as String?,itemDescription: freezed == itemDescription ? _self.itemDescription : itemDescription // ignore: cast_nullable_to_non_nullable
as String?,itemSoldDate: freezed == itemSoldDate ? _self.itemSoldDate : itemSoldDate // ignore: cast_nullable_to_non_nullable
as DateTime?,itemDimensions: freezed == itemDimensions ? _self.itemDimensions : itemDimensions // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [InventoryItem].
extension InventoryItemPatterns on InventoryItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InventoryItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InventoryItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InventoryItem value)  $default,){
final _that = this;
switch (_that) {
case _InventoryItem():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InventoryItem value)?  $default,){
final _that = this;
switch (_that) {
case _InventoryItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num? id,  List<String> itemImageUrls,  DateTime itemPurchaseDate,  double? itemPurchasePrice,  InventoryCategory itemCategory,  DateTime? itemListingDate,  double? itemListingPrice,  double? itemSoldPrice,  String? primaryImageUrl,  String? itemDescription,  DateTime? itemSoldDate,  Map<String, String>? itemDimensions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InventoryItem() when $default != null:
return $default(_that.id,_that.itemImageUrls,_that.itemPurchaseDate,_that.itemPurchasePrice,_that.itemCategory,_that.itemListingDate,_that.itemListingPrice,_that.itemSoldPrice,_that.primaryImageUrl,_that.itemDescription,_that.itemSoldDate,_that.itemDimensions);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num? id,  List<String> itemImageUrls,  DateTime itemPurchaseDate,  double? itemPurchasePrice,  InventoryCategory itemCategory,  DateTime? itemListingDate,  double? itemListingPrice,  double? itemSoldPrice,  String? primaryImageUrl,  String? itemDescription,  DateTime? itemSoldDate,  Map<String, String>? itemDimensions)  $default,) {final _that = this;
switch (_that) {
case _InventoryItem():
return $default(_that.id,_that.itemImageUrls,_that.itemPurchaseDate,_that.itemPurchasePrice,_that.itemCategory,_that.itemListingDate,_that.itemListingPrice,_that.itemSoldPrice,_that.primaryImageUrl,_that.itemDescription,_that.itemSoldDate,_that.itemDimensions);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num? id,  List<String> itemImageUrls,  DateTime itemPurchaseDate,  double? itemPurchasePrice,  InventoryCategory itemCategory,  DateTime? itemListingDate,  double? itemListingPrice,  double? itemSoldPrice,  String? primaryImageUrl,  String? itemDescription,  DateTime? itemSoldDate,  Map<String, String>? itemDimensions)?  $default,) {final _that = this;
switch (_that) {
case _InventoryItem() when $default != null:
return $default(_that.id,_that.itemImageUrls,_that.itemPurchaseDate,_that.itemPurchasePrice,_that.itemCategory,_that.itemListingDate,_that.itemListingPrice,_that.itemSoldPrice,_that.primaryImageUrl,_that.itemDescription,_that.itemSoldDate,_that.itemDimensions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InventoryItem implements InventoryItem {
  const _InventoryItem({this.id, required final  List<String> itemImageUrls, required this.itemPurchaseDate, this.itemPurchasePrice, required this.itemCategory, this.itemListingDate, this.itemListingPrice, this.itemSoldPrice, this.primaryImageUrl, this.itemDescription, this.itemSoldDate, final  Map<String, String>? itemDimensions}): _itemImageUrls = itemImageUrls,_itemDimensions = itemDimensions;
  factory _InventoryItem.fromJson(Map<String, dynamic> json) => _$InventoryItemFromJson(json);

@override final  num? id;
// Optional ID for the item
 final  List<String> _itemImageUrls;
// Optional ID for the item
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
 final  Map<String, String>? _itemDimensions;
@override Map<String, String>? get itemDimensions {
  final value = _itemDimensions;
  if (value == null) return null;
  if (_itemDimensions is EqualUnmodifiableMapView) return _itemDimensions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InventoryItem&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._itemImageUrls, _itemImageUrls)&&(identical(other.itemPurchaseDate, itemPurchaseDate) || other.itemPurchaseDate == itemPurchaseDate)&&(identical(other.itemPurchasePrice, itemPurchasePrice) || other.itemPurchasePrice == itemPurchasePrice)&&(identical(other.itemCategory, itemCategory) || other.itemCategory == itemCategory)&&(identical(other.itemListingDate, itemListingDate) || other.itemListingDate == itemListingDate)&&(identical(other.itemListingPrice, itemListingPrice) || other.itemListingPrice == itemListingPrice)&&(identical(other.itemSoldPrice, itemSoldPrice) || other.itemSoldPrice == itemSoldPrice)&&(identical(other.primaryImageUrl, primaryImageUrl) || other.primaryImageUrl == primaryImageUrl)&&(identical(other.itemDescription, itemDescription) || other.itemDescription == itemDescription)&&(identical(other.itemSoldDate, itemSoldDate) || other.itemSoldDate == itemSoldDate)&&const DeepCollectionEquality().equals(other._itemDimensions, _itemDimensions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_itemImageUrls),itemPurchaseDate,itemPurchasePrice,itemCategory,itemListingDate,itemListingPrice,itemSoldPrice,primaryImageUrl,itemDescription,itemSoldDate,const DeepCollectionEquality().hash(_itemDimensions));

@override
String toString() {
  return 'InventoryItem(id: $id, itemImageUrls: $itemImageUrls, itemPurchaseDate: $itemPurchaseDate, itemPurchasePrice: $itemPurchasePrice, itemCategory: $itemCategory, itemListingDate: $itemListingDate, itemListingPrice: $itemListingPrice, itemSoldPrice: $itemSoldPrice, primaryImageUrl: $primaryImageUrl, itemDescription: $itemDescription, itemSoldDate: $itemSoldDate, itemDimensions: $itemDimensions)';
}


}

/// @nodoc
abstract mixin class _$InventoryItemCopyWith<$Res> implements $InventoryItemCopyWith<$Res> {
  factory _$InventoryItemCopyWith(_InventoryItem value, $Res Function(_InventoryItem) _then) = __$InventoryItemCopyWithImpl;
@override @useResult
$Res call({
 num? id, List<String> itemImageUrls, DateTime itemPurchaseDate, double? itemPurchasePrice, InventoryCategory itemCategory, DateTime? itemListingDate, double? itemListingPrice, double? itemSoldPrice, String? primaryImageUrl, String? itemDescription, DateTime? itemSoldDate, Map<String, String>? itemDimensions
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? itemImageUrls = null,Object? itemPurchaseDate = null,Object? itemPurchasePrice = freezed,Object? itemCategory = null,Object? itemListingDate = freezed,Object? itemListingPrice = freezed,Object? itemSoldPrice = freezed,Object? primaryImageUrl = freezed,Object? itemDescription = freezed,Object? itemSoldDate = freezed,Object? itemDimensions = freezed,}) {
  return _then(_InventoryItem(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as num?,itemImageUrls: null == itemImageUrls ? _self._itemImageUrls : itemImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,itemPurchaseDate: null == itemPurchaseDate ? _self.itemPurchaseDate : itemPurchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime,itemPurchasePrice: freezed == itemPurchasePrice ? _self.itemPurchasePrice : itemPurchasePrice // ignore: cast_nullable_to_non_nullable
as double?,itemCategory: null == itemCategory ? _self.itemCategory : itemCategory // ignore: cast_nullable_to_non_nullable
as InventoryCategory,itemListingDate: freezed == itemListingDate ? _self.itemListingDate : itemListingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,itemListingPrice: freezed == itemListingPrice ? _self.itemListingPrice : itemListingPrice // ignore: cast_nullable_to_non_nullable
as double?,itemSoldPrice: freezed == itemSoldPrice ? _self.itemSoldPrice : itemSoldPrice // ignore: cast_nullable_to_non_nullable
as double?,primaryImageUrl: freezed == primaryImageUrl ? _self.primaryImageUrl : primaryImageUrl // ignore: cast_nullable_to_non_nullable
as String?,itemDescription: freezed == itemDescription ? _self.itemDescription : itemDescription // ignore: cast_nullable_to_non_nullable
as String?,itemSoldDate: freezed == itemSoldDate ? _self.itemSoldDate : itemSoldDate // ignore: cast_nullable_to_non_nullable
as DateTime?,itemDimensions: freezed == itemDimensions ? _self._itemDimensions : itemDimensions // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}


}

// dart format on
