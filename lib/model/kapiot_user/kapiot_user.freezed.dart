// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'kapiot_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

KapiotUser _$KapiotUserFromJson(Map<String, dynamic> json) {
  return _KapiotUser.fromJson(json);
}

/// @nodoc
class _$KapiotUserTearOff {
  const _$KapiotUserTearOff();

  _KapiotUser call(
      {required String id,
      String? displayName,
      String? email,
      String? phoneNumber,
      String? photoUrl}) {
    return _KapiotUser(
      id: id,
      displayName: displayName,
      email: email,
      phoneNumber: phoneNumber,
      photoUrl: photoUrl,
    );
  }

  KapiotUser fromJson(Map<String, Object> json) {
    return KapiotUser.fromJson(json);
  }
}

/// @nodoc
const $KapiotUser = _$KapiotUserTearOff();

/// @nodoc
mixin _$KapiotUser {
  String get id => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KapiotUserCopyWith<KapiotUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KapiotUserCopyWith<$Res> {
  factory $KapiotUserCopyWith(
          KapiotUser value, $Res Function(KapiotUser) then) =
      _$KapiotUserCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String? displayName,
      String? email,
      String? phoneNumber,
      String? photoUrl});
}

/// @nodoc
class _$KapiotUserCopyWithImpl<$Res> implements $KapiotUserCopyWith<$Res> {
  _$KapiotUserCopyWithImpl(this._value, this._then);

  final KapiotUser _value;
  // ignore: unused_field
  final $Res Function(KapiotUser) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? displayName = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: photoUrl == freezed
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$KapiotUserCopyWith<$Res> implements $KapiotUserCopyWith<$Res> {
  factory _$KapiotUserCopyWith(
          _KapiotUser value, $Res Function(_KapiotUser) then) =
      __$KapiotUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String? displayName,
      String? email,
      String? phoneNumber,
      String? photoUrl});
}

/// @nodoc
class __$KapiotUserCopyWithImpl<$Res> extends _$KapiotUserCopyWithImpl<$Res>
    implements _$KapiotUserCopyWith<$Res> {
  __$KapiotUserCopyWithImpl(
      _KapiotUser _value, $Res Function(_KapiotUser) _then)
      : super(_value, (v) => _then(v as _KapiotUser));

  @override
  _KapiotUser get _value => super._value as _KapiotUser;

  @override
  $Res call({
    Object? id = freezed,
    Object? displayName = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_KapiotUser(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: photoUrl == freezed
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_KapiotUser with DiagnosticableTreeMixin implements _KapiotUser {
  const _$_KapiotUser(
      {required this.id,
      this.displayName,
      this.email,
      this.phoneNumber,
      this.photoUrl});

  factory _$_KapiotUser.fromJson(Map<String, dynamic> json) =>
      _$$_KapiotUserFromJson(json);

  @override
  final String id;
  @override
  final String? displayName;
  @override
  final String? email;
  @override
  final String? phoneNumber;
  @override
  final String? photoUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'KapiotUser(id: $id, displayName: $displayName, email: $email, phoneNumber: $phoneNumber, photoUrl: $photoUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'KapiotUser'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('photoUrl', photoUrl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _KapiotUser &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.displayName, displayName) ||
                const DeepCollectionEquality()
                    .equals(other.displayName, displayName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.photoUrl, photoUrl) ||
                const DeepCollectionEquality()
                    .equals(other.photoUrl, photoUrl)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(displayName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(photoUrl);

  @JsonKey(ignore: true)
  @override
  _$KapiotUserCopyWith<_KapiotUser> get copyWith =>
      __$KapiotUserCopyWithImpl<_KapiotUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_KapiotUserToJson(this);
  }
}

abstract class _KapiotUser implements KapiotUser {
  const factory _KapiotUser(
      {required String id,
      String? displayName,
      String? email,
      String? phoneNumber,
      String? photoUrl}) = _$_KapiotUser;

  factory _KapiotUser.fromJson(Map<String, dynamic> json) =
      _$_KapiotUser.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String? get displayName => throw _privateConstructorUsedError;
  @override
  String? get email => throw _privateConstructorUsedError;
  @override
  String? get phoneNumber => throw _privateConstructorUsedError;
  @override
  String? get photoUrl => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$KapiotUserCopyWith<_KapiotUser> get copyWith =>
      throw _privateConstructorUsedError;
}
