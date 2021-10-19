// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'driver_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DriverInfo _$DriverInfoFromJson(Map<String, dynamic> json) {
  return _DriverInfo.fromJson(json);
}

/// @nodoc
class _$DriverInfoTearOff {
  const _$DriverInfoTearOff();

  _DriverInfo call(
      {required List<Car> registeredCars,
      int ratingResponseCount = 0,
      double rateTotal = 0}) {
    return _DriverInfo(
      registeredCars: registeredCars,
      ratingResponseCount: ratingResponseCount,
      rateTotal: rateTotal,
    );
  }

  DriverInfo fromJson(Map<String, Object> json) {
    return DriverInfo.fromJson(json);
  }
}

/// @nodoc
const $DriverInfo = _$DriverInfoTearOff();

/// @nodoc
mixin _$DriverInfo {
  List<Car> get registeredCars => throw _privateConstructorUsedError;
  int get ratingResponseCount => throw _privateConstructorUsedError;
  double get rateTotal => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DriverInfoCopyWith<DriverInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverInfoCopyWith<$Res> {
  factory $DriverInfoCopyWith(
          DriverInfo value, $Res Function(DriverInfo) then) =
      _$DriverInfoCopyWithImpl<$Res>;
  $Res call(
      {List<Car> registeredCars, int ratingResponseCount, double rateTotal});
}

/// @nodoc
class _$DriverInfoCopyWithImpl<$Res> implements $DriverInfoCopyWith<$Res> {
  _$DriverInfoCopyWithImpl(this._value, this._then);

  final DriverInfo _value;
  // ignore: unused_field
  final $Res Function(DriverInfo) _then;

  @override
  $Res call({
    Object? registeredCars = freezed,
    Object? ratingResponseCount = freezed,
    Object? rateTotal = freezed,
  }) {
    return _then(_value.copyWith(
      registeredCars: registeredCars == freezed
          ? _value.registeredCars
          : registeredCars // ignore: cast_nullable_to_non_nullable
              as List<Car>,
      ratingResponseCount: ratingResponseCount == freezed
          ? _value.ratingResponseCount
          : ratingResponseCount // ignore: cast_nullable_to_non_nullable
              as int,
      rateTotal: rateTotal == freezed
          ? _value.rateTotal
          : rateTotal // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$DriverInfoCopyWith<$Res> implements $DriverInfoCopyWith<$Res> {
  factory _$DriverInfoCopyWith(
          _DriverInfo value, $Res Function(_DriverInfo) then) =
      __$DriverInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Car> registeredCars, int ratingResponseCount, double rateTotal});
}

/// @nodoc
class __$DriverInfoCopyWithImpl<$Res> extends _$DriverInfoCopyWithImpl<$Res>
    implements _$DriverInfoCopyWith<$Res> {
  __$DriverInfoCopyWithImpl(
      _DriverInfo _value, $Res Function(_DriverInfo) _then)
      : super(_value, (v) => _then(v as _DriverInfo));

  @override
  _DriverInfo get _value => super._value as _DriverInfo;

  @override
  $Res call({
    Object? registeredCars = freezed,
    Object? ratingResponseCount = freezed,
    Object? rateTotal = freezed,
  }) {
    return _then(_DriverInfo(
      registeredCars: registeredCars == freezed
          ? _value.registeredCars
          : registeredCars // ignore: cast_nullable_to_non_nullable
              as List<Car>,
      ratingResponseCount: ratingResponseCount == freezed
          ? _value.ratingResponseCount
          : ratingResponseCount // ignore: cast_nullable_to_non_nullable
              as int,
      rateTotal: rateTotal == freezed
          ? _value.rateTotal
          : rateTotal // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DriverInfo extends _DriverInfo with DiagnosticableTreeMixin {
  const _$_DriverInfo(
      {required this.registeredCars,
      this.ratingResponseCount = 0,
      this.rateTotal = 0})
      : super._();

  factory _$_DriverInfo.fromJson(Map<String, dynamic> json) =>
      _$$_DriverInfoFromJson(json);

  @override
  final List<Car> registeredCars;
  @JsonKey(defaultValue: 0)
  @override
  final int ratingResponseCount;
  @JsonKey(defaultValue: 0)
  @override
  final double rateTotal;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DriverInfo(registeredCars: $registeredCars, ratingResponseCount: $ratingResponseCount, rateTotal: $rateTotal)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DriverInfo'))
      ..add(DiagnosticsProperty('registeredCars', registeredCars))
      ..add(DiagnosticsProperty('ratingResponseCount', ratingResponseCount))
      ..add(DiagnosticsProperty('rateTotal', rateTotal));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DriverInfo &&
            (identical(other.registeredCars, registeredCars) ||
                const DeepCollectionEquality()
                    .equals(other.registeredCars, registeredCars)) &&
            (identical(other.ratingResponseCount, ratingResponseCount) ||
                const DeepCollectionEquality()
                    .equals(other.ratingResponseCount, ratingResponseCount)) &&
            (identical(other.rateTotal, rateTotal) ||
                const DeepCollectionEquality()
                    .equals(other.rateTotal, rateTotal)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(registeredCars) ^
      const DeepCollectionEquality().hash(ratingResponseCount) ^
      const DeepCollectionEquality().hash(rateTotal);

  @JsonKey(ignore: true)
  @override
  _$DriverInfoCopyWith<_DriverInfo> get copyWith =>
      __$DriverInfoCopyWithImpl<_DriverInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DriverInfoToJson(this);
  }
}

abstract class _DriverInfo extends DriverInfo {
  const factory _DriverInfo(
      {required List<Car> registeredCars,
      int ratingResponseCount,
      double rateTotal}) = _$_DriverInfo;
  const _DriverInfo._() : super._();

  factory _DriverInfo.fromJson(Map<String, dynamic> json) =
      _$_DriverInfo.fromJson;

  @override
  List<Car> get registeredCars => throw _privateConstructorUsedError;
  @override
  int get ratingResponseCount => throw _privateConstructorUsedError;
  @override
  double get rateTotal => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DriverInfoCopyWith<_DriverInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
