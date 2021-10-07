// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'kapiot_user_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

KapiotUserInfo _$KapiotUserInfoFromJson(Map<String, dynamic> json) {
  return _KapiotUserInfo.fromJson(json);
}

/// @nodoc
class _$KapiotUserInfoTearOff {
  const _$KapiotUserInfoTearOff();

  _KapiotUserInfo call(
      {required double points,
      required List<Map<String, KapiotLocation>> savedLocations,
      required UserType userType,
      DriverInfo? driverInfo}) {
    return _KapiotUserInfo(
      points: points,
      savedLocations: savedLocations,
      userType: userType,
      driverInfo: driverInfo,
    );
  }

  KapiotUserInfo fromJson(Map<String, Object> json) {
    return KapiotUserInfo.fromJson(json);
  }
}

/// @nodoc
const $KapiotUserInfo = _$KapiotUserInfoTearOff();

/// @nodoc
mixin _$KapiotUserInfo {
  double get points => throw _privateConstructorUsedError;
  List<Map<String, KapiotLocation>> get savedLocations =>
      throw _privateConstructorUsedError;
  UserType get userType => throw _privateConstructorUsedError;
  DriverInfo? get driverInfo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KapiotUserInfoCopyWith<KapiotUserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KapiotUserInfoCopyWith<$Res> {
  factory $KapiotUserInfoCopyWith(
          KapiotUserInfo value, $Res Function(KapiotUserInfo) then) =
      _$KapiotUserInfoCopyWithImpl<$Res>;
  $Res call(
      {double points,
      List<Map<String, KapiotLocation>> savedLocations,
      UserType userType,
      DriverInfo? driverInfo});

  $DriverInfoCopyWith<$Res>? get driverInfo;
}

/// @nodoc
class _$KapiotUserInfoCopyWithImpl<$Res>
    implements $KapiotUserInfoCopyWith<$Res> {
  _$KapiotUserInfoCopyWithImpl(this._value, this._then);

  final KapiotUserInfo _value;
  // ignore: unused_field
  final $Res Function(KapiotUserInfo) _then;

  @override
  $Res call({
    Object? points = freezed,
    Object? savedLocations = freezed,
    Object? userType = freezed,
    Object? driverInfo = freezed,
  }) {
    return _then(_value.copyWith(
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as double,
      savedLocations: savedLocations == freezed
          ? _value.savedLocations
          : savedLocations // ignore: cast_nullable_to_non_nullable
              as List<Map<String, KapiotLocation>>,
      userType: userType == freezed
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as UserType,
      driverInfo: driverInfo == freezed
          ? _value.driverInfo
          : driverInfo // ignore: cast_nullable_to_non_nullable
              as DriverInfo?,
    ));
  }

  @override
  $DriverInfoCopyWith<$Res>? get driverInfo {
    if (_value.driverInfo == null) {
      return null;
    }

    return $DriverInfoCopyWith<$Res>(_value.driverInfo!, (value) {
      return _then(_value.copyWith(driverInfo: value));
    });
  }
}

/// @nodoc
abstract class _$KapiotUserInfoCopyWith<$Res>
    implements $KapiotUserInfoCopyWith<$Res> {
  factory _$KapiotUserInfoCopyWith(
          _KapiotUserInfo value, $Res Function(_KapiotUserInfo) then) =
      __$KapiotUserInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {double points,
      List<Map<String, KapiotLocation>> savedLocations,
      UserType userType,
      DriverInfo? driverInfo});

  @override
  $DriverInfoCopyWith<$Res>? get driverInfo;
}

/// @nodoc
class __$KapiotUserInfoCopyWithImpl<$Res>
    extends _$KapiotUserInfoCopyWithImpl<$Res>
    implements _$KapiotUserInfoCopyWith<$Res> {
  __$KapiotUserInfoCopyWithImpl(
      _KapiotUserInfo _value, $Res Function(_KapiotUserInfo) _then)
      : super(_value, (v) => _then(v as _KapiotUserInfo));

  @override
  _KapiotUserInfo get _value => super._value as _KapiotUserInfo;

  @override
  $Res call({
    Object? points = freezed,
    Object? savedLocations = freezed,
    Object? userType = freezed,
    Object? driverInfo = freezed,
  }) {
    return _then(_KapiotUserInfo(
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as double,
      savedLocations: savedLocations == freezed
          ? _value.savedLocations
          : savedLocations // ignore: cast_nullable_to_non_nullable
              as List<Map<String, KapiotLocation>>,
      userType: userType == freezed
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as UserType,
      driverInfo: driverInfo == freezed
          ? _value.driverInfo
          : driverInfo // ignore: cast_nullable_to_non_nullable
              as DriverInfo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_KapiotUserInfo extends _KapiotUserInfo with DiagnosticableTreeMixin {
  const _$_KapiotUserInfo(
      {required this.points,
      required this.savedLocations,
      required this.userType,
      this.driverInfo})
      : super._();

  factory _$_KapiotUserInfo.fromJson(Map<String, dynamic> json) =>
      _$$_KapiotUserInfoFromJson(json);

  @override
  final double points;
  @override
  final List<Map<String, KapiotLocation>> savedLocations;
  @override
  final UserType userType;
  @override
  final DriverInfo? driverInfo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'KapiotUserInfo(points: $points, savedLocations: $savedLocations, userType: $userType, driverInfo: $driverInfo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'KapiotUserInfo'))
      ..add(DiagnosticsProperty('points', points))
      ..add(DiagnosticsProperty('savedLocations', savedLocations))
      ..add(DiagnosticsProperty('userType', userType))
      ..add(DiagnosticsProperty('driverInfo', driverInfo));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _KapiotUserInfo &&
            (identical(other.points, points) ||
                const DeepCollectionEquality().equals(other.points, points)) &&
            (identical(other.savedLocations, savedLocations) ||
                const DeepCollectionEquality()
                    .equals(other.savedLocations, savedLocations)) &&
            (identical(other.userType, userType) ||
                const DeepCollectionEquality()
                    .equals(other.userType, userType)) &&
            (identical(other.driverInfo, driverInfo) ||
                const DeepCollectionEquality()
                    .equals(other.driverInfo, driverInfo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(points) ^
      const DeepCollectionEquality().hash(savedLocations) ^
      const DeepCollectionEquality().hash(userType) ^
      const DeepCollectionEquality().hash(driverInfo);

  @JsonKey(ignore: true)
  @override
  _$KapiotUserInfoCopyWith<_KapiotUserInfo> get copyWith =>
      __$KapiotUserInfoCopyWithImpl<_KapiotUserInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_KapiotUserInfoToJson(this);
  }
}

abstract class _KapiotUserInfo extends KapiotUserInfo {
  const factory _KapiotUserInfo(
      {required double points,
      required List<Map<String, KapiotLocation>> savedLocations,
      required UserType userType,
      DriverInfo? driverInfo}) = _$_KapiotUserInfo;
  const _KapiotUserInfo._() : super._();

  factory _KapiotUserInfo.fromJson(Map<String, dynamic> json) =
      _$_KapiotUserInfo.fromJson;

  @override
  double get points => throw _privateConstructorUsedError;
  @override
  List<Map<String, KapiotLocation>> get savedLocations =>
      throw _privateConstructorUsedError;
  @override
  UserType get userType => throw _privateConstructorUsedError;
  @override
  DriverInfo? get driverInfo => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$KapiotUserInfoCopyWith<_KapiotUserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
