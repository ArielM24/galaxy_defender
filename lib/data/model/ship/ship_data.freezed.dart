// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ship_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShipData {


/// Create a copy of ShipData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShipDataCopyWith<ShipData> get copyWith => _$ShipDataCopyWithImpl<ShipData>(this as ShipData, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ShipData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShipData&&(identical(other.currentLife, _this.currentLife) || other.currentLife == _this.currentLife)&&(identical(other.maxLife, _this.maxLife) || other.maxLife == _this.maxLife)&&(identical(other.speed, _this.speed) || other.speed == _this.speed)&&(identical(other.attack, _this.attack) || other.attack == _this.attack)&&(identical(other.x, _this.x) || other.x == _this.x)&&(identical(other.y, _this.y) || other.y == _this.y)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.size, _this.size) || other.size == _this.size)&&(identical(other.armour, _this.armour) || other.armour == _this.armour)&&(identical(other.movementType, _this.movementType) || other.movementType == _this.movementType)&&(identical(other.attackType, _this.attackType) || other.attackType == _this.attackType)&&(identical(other.shipColor, _this.shipColor) || other.shipColor == _this.shipColor)&&(identical(other.faction, _this.faction) || other.faction == _this.faction)&&(identical(other.factionAttackType, _this.factionAttackType) || other.factionAttackType == _this.factionAttackType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ShipData;
  return Object.hash(runtimeType,_this.currentLife,_this.maxLife,_this.speed,_this.attack,_this.x,_this.y,_this.type,_this.size,_this.armour,_this.movementType,_this.attackType,_this.shipColor,_this.faction,_this.factionAttackType);
}

@override
String toString() {
  final _this = this as ShipData;
  return 'ShipData(currentLife: ${_this.currentLife}, maxLife: ${_this.maxLife}, speed: ${_this.speed}, attack: ${_this.attack}, x: ${_this.x}, y: ${_this.y}, type: ${_this.type}, size: ${_this.size}, armour: ${_this.armour}, movementType: ${_this.movementType}, attackType: ${_this.attackType}, shipColor: ${_this.shipColor}, faction: ${_this.faction}, factionAttackType: ${_this.factionAttackType})';
}


}

/// @nodoc
abstract mixin class $ShipDataCopyWith<$Res>  {
  factory $ShipDataCopyWith(ShipData value, $Res Function(ShipData) _then) = _$ShipDataCopyWithImpl;
@useResult
$Res call({
 double currentLife, double maxLife, double attack, double speed, double x, double y, double armour, double size, ShipFactionAttackType factionAttackType, ShipFaction faction, ShipAttackType attackType, int shipColor, ShipMovementType movementType, ShipType type
});




}
/// @nodoc
class _$ShipDataCopyWithImpl<$Res>
    implements $ShipDataCopyWith<$Res> {
  _$ShipDataCopyWithImpl(this._self, this._then);

  final ShipData _self;
  final $Res Function(ShipData) _then;

/// Create a copy of ShipData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentLife = null,Object? maxLife = null,Object? attack = null,Object? speed = null,Object? x = null,Object? y = null,Object? armour = null,Object? size = null,Object? factionAttackType = null,Object? faction = null,Object? attackType = null,Object? shipColor = null,Object? movementType = null,Object? type = null,}) {
  return _then(ShipData(
currentLife: null == currentLife ? _self.currentLife : currentLife // ignore: cast_nullable_to_non_nullable
as double,maxLife: null == maxLife ? _self.maxLife : maxLife // ignore: cast_nullable_to_non_nullable
as double,attack: null == attack ? _self.attack : attack // ignore: cast_nullable_to_non_nullable
as double,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,armour: null == armour ? _self.armour : armour // ignore: cast_nullable_to_non_nullable
as double,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as double,factionAttackType: null == factionAttackType ? _self.factionAttackType : factionAttackType // ignore: cast_nullable_to_non_nullable
as ShipFactionAttackType,faction: null == faction ? _self.faction : faction // ignore: cast_nullable_to_non_nullable
as ShipFaction,attackType: null == attackType ? _self.attackType : attackType // ignore: cast_nullable_to_non_nullable
as ShipAttackType,shipColor: null == shipColor ? _self.shipColor : shipColor // ignore: cast_nullable_to_non_nullable
as int,movementType: null == movementType ? _self.movementType : movementType // ignore: cast_nullable_to_non_nullable
as ShipMovementType,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ShipType,
  ));
}

}


/// Adds pattern-matching-related methods to [ShipData].
extension ShipDataPatterns on ShipData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
