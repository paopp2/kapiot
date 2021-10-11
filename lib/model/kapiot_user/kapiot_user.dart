import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'kapiot_user.freezed.dart';
part 'kapiot_user.g.dart';

enum UserType {
  student,
  faculty,
  staff,
}

extension UserTypeDescription on UserType {
  String get description {
    final String d = describeEnum(this);
    return '${d[0].toUpperCase()}${d.substring(1)}';
  }
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
