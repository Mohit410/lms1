import 'dart:convert';
import 'package:lms1/domain/entities/entities.dart';

class RegisterUserModel extends UserEntity {
  const RegisterUserModel({
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

  factory RegisterUserModel.fromMap(Map<String, dynamic> map) {
    return RegisterUserModel(
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

  factory RegisterUserModel.fromJson(String source) =>
      RegisterUserModel.fromMap(json.decode(source));
}
