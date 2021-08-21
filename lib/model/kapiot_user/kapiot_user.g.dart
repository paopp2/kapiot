// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kapiot_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_KapiotUser _$$_KapiotUserFromJson(Map<String, dynamic> json) =>
    _$_KapiotUser(
      id: json['id'] as String,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$$_KapiotUserToJson(_$_KapiotUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'photoUrl': instance.photoUrl,
    };
