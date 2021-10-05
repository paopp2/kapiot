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
      {required String licensePlateNum,
      required List<Car> registeredCars,
      required int passengerCount,
      double? rating}) {
    return _DriverInfo(
      licensePlateNum: licensePlateNum,
      registeredCars: registeredCars,
      passengerCount: passengerCount,
      rating: rating,
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
  String get licensePlateNum => throw _privateConstructorUsedError;
  List<Car> get registeredCars => throw _privateConstructorUsedError;
  int get passengerCount => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;

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
      {String licensePlateNum,
      List<Car> registeredCars,
      int passengerCount,
      double? rating});
}

/// @nodoc
class _$DriverInfoCopyWithImpl<$Res> implements $DriverInfoCopyWith<$Res> {
  _$DriverInfoCopyWithImpl(this._value, this._then);

  final DriverInfo _value;
  // ignore: unused_field
  final $Res Function(DriverInfo) _then;

  @override
  $Res call({
    Object? licensePlateNum = freezed,
    Object? registeredCars = freezed,
    Object? passengerCount = freezed,
    Object? rating = freezed,
  }) {
    return _then(_value.copyWith(
      licensePlateNum: licensePlateNum == freezed
          ? _value.licensePlateNum
          : licensePlateNum // ignore: cast_nullable_to_non_nullable
              as String,
      registeredCars: registeredCars == freezed
          ? _value.registeredCars
          : registeredCars // ignore: cast_nullable_to_non_nullable
              as List<Car>,
      passengerCount: passengerCount == freezed
          ? _value.passengerCount
          : passengerCount // ignore: cast_nullable_to_non_nullable
              as int,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
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
      {String licensePlateNum,
      List<Car> registeredCars,
      int passengerCount,
      double? rating});
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
    Object? licensePlateNum = freezed,
    Object? registeredCars = freezed,
    Object? passengerCount = freezed,
    Object? rating = freezed,
  }) {
    return _then(_DriverInfo(
      licensePlateNum: licensePlateNum == freezed
          ? _value.licensePlateNum
          : licensePlateNum // ignore: cast_nullable_to_non_nullable
              as String,
      registeredCars: registeredCars == freezed
          ? _value.registeredCars
          : registeredCars // ignore: cast_nullable_to_non_nullable
              as List<Car>,
      passengerCount: passengerCount == freezed
          ? _value.passengerCount
          : passengerCount // ignore: cast_nullable_to_non_nullable
              as int,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DriverInfo with DiagnosticableTreeMixin implements _DriverInfo {
  const _$_DriverInfo(
      {required this.licensePlateNum,
      required this.registeredCars,
      required this.passengerCount,
      this.rating});

  factory _$_DriverInfo.fromJson(Map<String, dynamic> json) =>
      _$$_DriverInfoFromJson(json);

  @override
  final String licensePlateNum;
  @override
  final List<Car> registeredCars;
  @override
  final int passengerCount;
  @override
  final double? rating;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DriverInfo(licensePlateNum: $licensePlateNum, registeredCars: $registeredCars, passengerCount: $passengerCount, rating: $rating)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DriverInfo'))
      ..add(DiagnosticsProperty('licensePlateNum', licensePlateNum))
      ..add(DiagnosticsProperty('registeredCars', registeredCars))
      ..add(DiagnosticsProperty('passengerCount', passengerCount))
      ..add(DiagnosticsProperty('rating', rating));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DriverInfo &&
            (identical(other.licensePlateNum, licensePlateNum) ||
                const DeepCollectionEquality()
                    .equals(other.licensePlateNum, licensePlateNum)) &&
            (identical(other.registeredCars, registeredCars) ||
                const DeepCollectionEquality()
                    .equals(other.registeredCars, registeredCars)) &&
            (identical(other.passengerCount, passengerCount) ||
                const DeepCollectionEquality()
                    .equals(other.passengerCount, passengerCount)) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(licensePlateNum) ^
      const DeepCollectionEquality().hash(registeredCars) ^
      const DeepCollectionEquality().hash(passengerCount) ^
      const DeepCollectionEquality().hash(rating);

  @JsonKey(ignore: true)
  @override
  _$DriverInfoCopyWith<_DriverInfo> get copyWith =>
      __$DriverInfoCopyWithImpl<_DriverInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DriverInfoToJson(this);
  }
}

abstract class _DriverInfo implements DriverInfo {
  const factory _DriverInfo(
      {required String licensePlateNum,
      required List<Car> registeredCars,
      required int passengerCount,
      double? rating}) = _$_DriverInfo;

  factory _DriverInfo.fromJson(Map<String, dynamic> json) =
      _$_DriverInfo.fromJson;

  @override
  String get licensePlateNum => throw _privateConstructorUsedError;
  @override
  List<Car> get registeredCars => throw _privateConstructorUsedError;
  @override
  int get passengerCount => throw _privateConstructorUsedError;
  @override
  double? get rating => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DriverInfoCopyWith<_DriverInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
