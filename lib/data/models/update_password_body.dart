import 'dart:convert';

import 'package:equatable/equatable.dart';

class UpdatePasswordBody extends Equatable {
  final String email;
  final String role;
  final String newPassword;
  final String currentPassword;
  final String confirmPassword;

  const UpdatePasswordBody({
    required this.email,
    required this.role,
    required this.newPassword,
    required this.currentPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'newPassword': newPassword});
    result.addAll({'currentPassword': currentPassword});
    result.addAll({'confirmNewPassword': confirmPassword});

    return result;
  }

  factory UpdatePasswordBody.fromMap(Map<String, dynamic> map) {
    return UpdatePasswordBody(
      newPassword: map['newPassword'],
      currentPassword: map['currentPassword'],
      confirmPassword: map['confirmNewPassword'],
      email: map['email'],
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdatePasswordBody.fromJson(String source) =>
      UpdatePasswordBody.fromMap(json.decode(source));

  @override
  String toString() =>
      'UpdatePasswordBody(newPassword: $newPassword, currentPassword: $currentPassword, confirmPassword: $confirmPassword)';

  @override
  List<Object> get props => [newPassword, currentPassword, confirmPassword];
}
