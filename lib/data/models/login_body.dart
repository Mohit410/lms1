import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginBody extends Equatable {
  final String email;
  final String password;

  const LoginBody({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'password': password});

    return result;
  }

  factory LoginBody.fromMap(Map<String, dynamic> map) {
    return LoginBody(
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginBody.fromJson(String source) =>
      LoginBody.fromMap(json.decode(source));
}
