import 'dart:convert';

import 'package:equatable/equatable.dart';

class CommonResponse extends Equatable {
  final bool success;
  final String message;

  const CommonResponse({required this.success, required this.message});

  @override
  List<Object?> get props => [success, message];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'success': success});
    result.addAll({'message': message});

    return result;
  }

  factory CommonResponse.fromMap(Map<String, dynamic> map) {
    return CommonResponse(
      success: map['success'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CommonResponse.fromJson(String source) =>
      CommonResponse.fromMap(json.decode(source));
}

class LoginResponse extends Equatable {
  final bool success;
  final String message;
  final String token;
  final String role;

  const LoginResponse(
      {required this.success,
      required this.message,
      required this.token,
      required this.role});

  @override
  List<Object?> get props => [success, message, token, role];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'success': success});
    result.addAll({'message': message});
    result.addAll({'access_token': token});
    result.addAll({'role': role});

    return result;
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      success: map['success'] ?? false,
      message: map['message'] ?? '',
      token: map['access_token'] ?? '',
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source));
}
