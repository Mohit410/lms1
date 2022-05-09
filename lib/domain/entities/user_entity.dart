import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String mobileNo;
  final String address;
  final String state;
  final String city;
  final String pincode;
  final String role;

  const UserEntity({
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.address,
    required this.state,
    required this.city,
    required this.pincode,
    required this.role,
  });

  @override
  List<Object?> get props =>
      [name, email, mobileNo, address, state, city, pincode, role];
}
