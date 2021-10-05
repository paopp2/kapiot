import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'kapiot_user.freezed.dart';
part 'kapiot_user.g.dart';

enum UserType {
  student,
  faculty,
  personnel,
}

@freezed
class KapiotUser with _$KapiotUser {
  const factory KapiotUser({
    required String id,
    String? displayName,
    String? email,
    String? phoneNumber,
    String? photoUrl,
    UserType? userType,
  }) = _KapiotUser;

  factory KapiotUser.fromJson(Map<String, dynamic> json) =>
      _$KapiotUserFromJson(json);
}
