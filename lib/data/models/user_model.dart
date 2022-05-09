import 'dart:convert';
import 'package:lms1/domain/entities/entities.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String name,
    required String email,
    required String mobileNo,
    required String address,
    required String state,
    required String city,
    required String pincode,
    required String role,
  }) : super(
          name: name,
          email: email,
          mobileNo: mobileNo,
          address: address,
          state: state,
          city: city,
          pincode: pincode,
          role: role,
        );

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'phone': mobileNo,
        'address': address,
        'state': state,
        'city': city,
        'pincode': pincode,
        'role': role
      };

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      mobileNo: map['phone'] ?? '',
      address: map['address'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      pincode: map['pincode'] ?? '',
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
