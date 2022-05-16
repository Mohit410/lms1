import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:lms1/data/models/user_model.dart';

class UserListResponse extends Equatable {
  final bool success;
  final List<UserModel> users;

  const UserListResponse({
    required this.success,
    required this.users,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'success': success});
    result.addAll({'users': users.map((x) => x.toMap()).toList()});

    return result;
  }

  factory UserListResponse.fromMap(Map<String, dynamic> map) {
    return UserListResponse(
      success: map['success'],
      users:
          List<UserModel>.from(map['users']?.map((x) => UserModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserListResponse.fromJson(String source) =>
      UserListResponse.fromMap(json.decode(source));

  @override
  String toString() => 'UserListResponse(sucess: $success, users: $users)';

  @override
  List<Object> get props => [success, users];
}
