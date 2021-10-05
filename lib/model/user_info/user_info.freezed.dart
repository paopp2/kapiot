// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return _UserInfo.fromJson(json);
}

/// @nodoc
class _$UserInfoTearOff {
  const _$UserInfoTearOff();

  _UserInfo call(
      {required double points,
      required String course,
      required int year,
      required List<Map<String, KapiotLocation>> savedLocations,
      DriverInfo? driverInfo}) {
    return _UserInfo(
      points: points,
      course: course,
      year: year,
      savedLocations: savedLocations,
      driverInfo: driverInfo,
    );
  }

  UserInfo fromJson(Map<String, Object> json) {
    return UserInfo.fromJson(json);
  }
}

/// @nodoc
const $UserInfo = _$UserInfoTearOff();

/// @nodoc
mixin _$UserInfo {
  double get points => throw _privateConstructorUsedError;
  String get course => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  List<Map<String, KapiotLocation>> get savedLocations =>
      throw _privateConstructorUsedError;
  DriverInfo? get driverInfo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserInfoCopyWith<UserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoCopyWith<$Res> {
  factory $UserInfoCopyWith(UserInfo value, $Res Function(UserInfo) then) =
      _$UserInfoCopyWithImpl<$Res>;
  $Res call(
      {double points,
      String course,
      int year,
      List<Map<String, KapiotLocation>> savedLocations,
      DriverInfo? driverInfo});

  $DriverInfoCopyWith<$Res>? get driverInfo;
}

/// @nodoc
class _$UserInfoCopyWithImpl<$Res> implements $UserInfoCopyWith<$Res> {
  _$UserInfoCopyWithImpl(this._value, this._then);

  final UserInfo _value;
  // ignore: unused_field
  final $Res Function(UserInfo) _then;

  @override
  $Res call({
    Object? points = freezed,
    Object? course = freezed,
    Object? year = freezed,
    Object? savedLocations = freezed,
    Object? driverInfo = freezed,
  }) {
    return _then(_value.copyWith(
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as double,
      course: course == freezed
          ? _value.course
          : course // ignore: cast_nullable_to_non_nullable
              as String,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      savedLocations: savedLocations == freezed
          ? _value.savedLocations
          : savedLocations // ignore: cast_nullable_to_non_nullable
              as List<Map<String, KapiotLocation>>,
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
abstract class _$UserInfoCopyWith<$Res> implements $UserInfoCopyWith<$Res> {
  factory _$UserInfoCopyWith(_UserInfo value, $Res Function(_UserInfo) then) =
      __$UserInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {double points,
      String course,
      int year,
      List<Map<String, KapiotLocation>> savedLocations,
      DriverInfo? driverInfo});

  @override
  $DriverInfoCopyWith<$Res>? get driverInfo;
}

/// @nodoc
class __$UserInfoCopyWithImpl<$Res> extends _$UserInfoCopyWithImpl<$Res>
    implements _$UserInfoCopyWith<$Res> {
  __$UserInfoCopyWithImpl(_UserInfo _value, $Res Function(_UserInfo) _then)
      : super(_value, (v) => _then(v as _UserInfo));

  @override
  _UserInfo get _value => super._value as _UserInfo;

  @override
  $Res call({
    Object? points = freezed,
    Object? course = freezed,
    Object? year = freezed,
    Object? savedLocations = freezed,
    Object? driverInfo = freezed,
  }) {
    return _then(_UserInfo(
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as double,
      course: course == freezed
          ? _value.course
          : course // ignore: cast_nullable_to_non_nullable
              as String,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      savedLocations: savedLocations == freezed
          ? _value.savedLocations
          : savedLocations // ignore: cast_nullable_to_non_nullable
              as List<Map<String, KapiotLocation>>,
      driverInfo: driverInfo == freezed
          ? _value.driverInfo
          : driverInfo // ignore: cast_nullable_to_non_nullable
              as DriverInfo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserInfo extends _UserInfo with DiagnosticableTreeMixin {
  const _$_UserInfo(
      {required this.points,
      required this.course,
      required this.year,
      required this.savedLocations,
      this.driverInfo})
      : super._();

  factory _$_UserInfo.fromJson(Map<String, dynamic> json) =>
      _$$_UserInfoFromJson(json);

  @override
  final double points;
  @override
  final String course;
  @override
  final int year;
  @override
  final List<Map<String, KapiotLocation>> savedLocations;
  @override
  final DriverInfo? driverInfo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserInfo(points: $points, course: $course, year: $year, savedLocations: $savedLocations, driverInfo: $driverInfo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserInfo'))
      ..add(DiagnosticsProperty('points', points))
      ..add(DiagnosticsProperty('course', course))
      ..add(DiagnosticsProperty('year', year))
      ..add(DiagnosticsProperty('savedLocations', savedLocations))
      ..add(DiagnosticsProperty('driverInfo', driverInfo));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserInfo &&
            (identical(other.points, points) ||
                const DeepCollectionEquality().equals(other.points, points)) &&
            (identical(other.course, course) ||
                const DeepCollectionEquality().equals(other.course, course)) &&
            (identical(other.year, year) ||
                const DeepCollectionEquality().equals(other.year, year)) &&
            (identical(other.savedLocations, savedLocations) ||
                const DeepCollectionEquality()
                    .equals(other.savedLocations, savedLocations)) &&
            (identical(other.driverInfo, driverInfo) ||
                const DeepCollectionEquality()
                    .equals(other.driverInfo, driverInfo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(points) ^
      const DeepCollectionEquality().hash(course) ^
      const DeepCollectionEquality().hash(year) ^
      const DeepCollectionEquality().hash(savedLocations) ^
      const DeepCollectionEquality().hash(driverInfo);

  @JsonKey(ignore: true)
  @override
  _$UserInfoCopyWith<_UserInfo> get copyWith =>
      __$UserInfoCopyWithImpl<_UserInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserInfoToJson(this);
  }
}

abstract class _UserInfo extends UserInfo {
  const factory _UserInfo(
      {required double points,
      required String course,
      required int year,
      required List<Map<String, KapiotLocation>> savedLocations,
      DriverInfo? driverInfo}) = _$_UserInfo;
  const _UserInfo._() : super._();

  factory _UserInfo.fromJson(Map<String, dynamic> json) = _$_UserInfo.fromJson;

  @override
  double get points => throw _privateConstructorUsedError;
  @override
  String get course => throw _privateConstructorUsedError;
  @override
  int get year => throw _privateConstructorUsedError;
  @override
  List<Map<String, KapiotLocation>> get savedLocations =>
      throw _privateConstructorUsedError;
  @override
  DriverInfo? get driverInfo => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserInfoCopyWith<_UserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
