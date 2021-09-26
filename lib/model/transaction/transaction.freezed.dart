// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TransactionTearOff {
  const _$TransactionTearOff();

  _Transaction call(
      {String? currentUserId,
      RouteConfig? driver,
      List<RouteConfig>? riders,
      KapiotLocation? startLocation,
      KapiotLocation? endLocation,
      double? points,
      DateTime? startTime,
      DateTime? endTime,
      double? distance}) {
    return _Transaction(
      currentUserId: currentUserId,
      driver: driver,
      riders: riders,
      startLocation: startLocation,
      endLocation: endLocation,
      points: points,
      startTime: startTime,
      endTime: endTime,
      distance: distance,
    );
  }
}

/// @nodoc
const $Transaction = _$TransactionTearOff();

/// @nodoc
mixin _$Transaction {
  String? get currentUserId => throw _privateConstructorUsedError;
  RouteConfig? get driver => throw _privateConstructorUsedError;
  List<RouteConfig>? get riders => throw _privateConstructorUsedError;
  KapiotLocation? get startLocation => throw _privateConstructorUsedError;
  KapiotLocation? get endLocation => throw _privateConstructorUsedError;
  double? get points => throw _privateConstructorUsedError;
  DateTime? get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res>;
  $Res call(
      {String? currentUserId,
      RouteConfig? driver,
      List<RouteConfig>? riders,
      KapiotLocation? startLocation,
      KapiotLocation? endLocation,
      double? points,
      DateTime? startTime,
      DateTime? endTime,
      double? distance});

  $RouteConfigCopyWith<$Res>? get driver;
  $KapiotLocationCopyWith<$Res>? get startLocation;
  $KapiotLocationCopyWith<$Res>? get endLocation;
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res> implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  final Transaction _value;
  // ignore: unused_field
  final $Res Function(Transaction) _then;

  @override
  $Res call({
    Object? currentUserId = freezed,
    Object? driver = freezed,
    Object? riders = freezed,
    Object? startLocation = freezed,
    Object? endLocation = freezed,
    Object? points = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? distance = freezed,
  }) {
    return _then(_value.copyWith(
      currentUserId: currentUserId == freezed
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      driver: driver == freezed
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as RouteConfig?,
      riders: riders == freezed
          ? _value.riders
          : riders // ignore: cast_nullable_to_non_nullable
              as List<RouteConfig>?,
      startLocation: startLocation == freezed
          ? _value.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as KapiotLocation?,
      endLocation: endLocation == freezed
          ? _value.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as KapiotLocation?,
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as double?,
      startTime: startTime == freezed
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: endTime == freezed
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      distance: distance == freezed
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }

  @override
  $RouteConfigCopyWith<$Res>? get driver {
    if (_value.driver == null) {
      return null;
    }

    return $RouteConfigCopyWith<$Res>(_value.driver!, (value) {
      return _then(_value.copyWith(driver: value));
    });
  }

  @override
  $KapiotLocationCopyWith<$Res>? get startLocation {
    if (_value.startLocation == null) {
      return null;
    }

    return $KapiotLocationCopyWith<$Res>(_value.startLocation!, (value) {
      return _then(_value.copyWith(startLocation: value));
    });
  }

  @override
  $KapiotLocationCopyWith<$Res>? get endLocation {
    if (_value.endLocation == null) {
      return null;
    }

    return $KapiotLocationCopyWith<$Res>(_value.endLocation!, (value) {
      return _then(_value.copyWith(endLocation: value));
    });
  }
}

/// @nodoc
abstract class _$TransactionCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$TransactionCopyWith(
          _Transaction value, $Res Function(_Transaction) then) =
      __$TransactionCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? currentUserId,
      RouteConfig? driver,
      List<RouteConfig>? riders,
      KapiotLocation? startLocation,
      KapiotLocation? endLocation,
      double? points,
      DateTime? startTime,
      DateTime? endTime,
      double? distance});

  @override
  $RouteConfigCopyWith<$Res>? get driver;
  @override
  $KapiotLocationCopyWith<$Res>? get startLocation;
  @override
  $KapiotLocationCopyWith<$Res>? get endLocation;
}

/// @nodoc
class __$TransactionCopyWithImpl<$Res> extends _$TransactionCopyWithImpl<$Res>
    implements _$TransactionCopyWith<$Res> {
  __$TransactionCopyWithImpl(
      _Transaction _value, $Res Function(_Transaction) _then)
      : super(_value, (v) => _then(v as _Transaction));

  @override
  _Transaction get _value => super._value as _Transaction;

  @override
  $Res call({
    Object? currentUserId = freezed,
    Object? driver = freezed,
    Object? riders = freezed,
    Object? startLocation = freezed,
    Object? endLocation = freezed,
    Object? points = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? distance = freezed,
  }) {
    return _then(_Transaction(
      currentUserId: currentUserId == freezed
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      driver: driver == freezed
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as RouteConfig?,
      riders: riders == freezed
          ? _value.riders
          : riders // ignore: cast_nullable_to_non_nullable
              as List<RouteConfig>?,
      startLocation: startLocation == freezed
          ? _value.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as KapiotLocation?,
      endLocation: endLocation == freezed
          ? _value.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as KapiotLocation?,
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as double?,
      startTime: startTime == freezed
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: endTime == freezed
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      distance: distance == freezed
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$_Transaction with DiagnosticableTreeMixin implements _Transaction {
  const _$_Transaction(
      {this.currentUserId,
      this.driver,
      this.riders,
      this.startLocation,
      this.endLocation,
      this.points,
      this.startTime,
      this.endTime,
      this.distance});

  @override
  final String? currentUserId;
  @override
  final RouteConfig? driver;
  @override
  final List<RouteConfig>? riders;
  @override
  final KapiotLocation? startLocation;
  @override
  final KapiotLocation? endLocation;
  @override
  final double? points;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  @override
  final double? distance;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Transaction(currentUserId: $currentUserId, driver: $driver, riders: $riders, startLocation: $startLocation, endLocation: $endLocation, points: $points, startTime: $startTime, endTime: $endTime, distance: $distance)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Transaction'))
      ..add(DiagnosticsProperty('currentUserId', currentUserId))
      ..add(DiagnosticsProperty('driver', driver))
      ..add(DiagnosticsProperty('riders', riders))
      ..add(DiagnosticsProperty('startLocation', startLocation))
      ..add(DiagnosticsProperty('endLocation', endLocation))
      ..add(DiagnosticsProperty('points', points))
      ..add(DiagnosticsProperty('startTime', startTime))
      ..add(DiagnosticsProperty('endTime', endTime))
      ..add(DiagnosticsProperty('distance', distance));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Transaction &&
            (identical(other.currentUserId, currentUserId) ||
                const DeepCollectionEquality()
                    .equals(other.currentUserId, currentUserId)) &&
            (identical(other.driver, driver) ||
                const DeepCollectionEquality().equals(other.driver, driver)) &&
            (identical(other.riders, riders) ||
                const DeepCollectionEquality().equals(other.riders, riders)) &&
            (identical(other.startLocation, startLocation) ||
                const DeepCollectionEquality()
                    .equals(other.startLocation, startLocation)) &&
            (identical(other.endLocation, endLocation) ||
                const DeepCollectionEquality()
                    .equals(other.endLocation, endLocation)) &&
            (identical(other.points, points) ||
                const DeepCollectionEquality().equals(other.points, points)) &&
            (identical(other.startTime, startTime) ||
                const DeepCollectionEquality()
                    .equals(other.startTime, startTime)) &&
            (identical(other.endTime, endTime) ||
                const DeepCollectionEquality()
                    .equals(other.endTime, endTime)) &&
            (identical(other.distance, distance) ||
                const DeepCollectionEquality()
                    .equals(other.distance, distance)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(currentUserId) ^
      const DeepCollectionEquality().hash(driver) ^
      const DeepCollectionEquality().hash(riders) ^
      const DeepCollectionEquality().hash(startLocation) ^
      const DeepCollectionEquality().hash(endLocation) ^
      const DeepCollectionEquality().hash(points) ^
      const DeepCollectionEquality().hash(startTime) ^
      const DeepCollectionEquality().hash(endTime) ^
      const DeepCollectionEquality().hash(distance);

  @JsonKey(ignore: true)
  @override
  _$TransactionCopyWith<_Transaction> get copyWith =>
      __$TransactionCopyWithImpl<_Transaction>(this, _$identity);
}

abstract class _Transaction implements Transaction {
  const factory _Transaction(
      {String? currentUserId,
      RouteConfig? driver,
      List<RouteConfig>? riders,
      KapiotLocation? startLocation,
      KapiotLocation? endLocation,
      double? points,
      DateTime? startTime,
      DateTime? endTime,
      double? distance}) = _$_Transaction;

  @override
  String? get currentUserId => throw _privateConstructorUsedError;
  @override
  RouteConfig? get driver => throw _privateConstructorUsedError;
  @override
  List<RouteConfig>? get riders => throw _privateConstructorUsedError;
  @override
  KapiotLocation? get startLocation => throw _privateConstructorUsedError;
  @override
  KapiotLocation? get endLocation => throw _privateConstructorUsedError;
  @override
  double? get points => throw _privateConstructorUsedError;
  @override
  DateTime? get startTime => throw _privateConstructorUsedError;
  @override
  DateTime? get endTime => throw _privateConstructorUsedError;
  @override
  double? get distance => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TransactionCopyWith<_Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}
