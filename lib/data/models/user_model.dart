import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String pincode;
  final String role;
  final int v;
  final int fine;
  final int cardNumber;
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.role,
    required this.v,
    required this.fine,
    required this.cardNumber,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      phone,
      address,
      city,
      state,
      pincode,
      role,
      v,
      fine,
      cardNumber,
    ];
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phone': phone});
    result.addAll({'address': address});
    result.addAll({'city': city});
    result.addAll({'state': state});
    result.addAll({'pincode': pincode});
    result.addAll({'role': role});
    result.addAll({'v': v});
    result.addAll({'fine': fine});
    result.addAll({'card_number': cardNumber});
  
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone']?.toString() ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      pincode: map['pincode'] ?? '',
      role: map['role'] ?? '',
      v: map['v']?.toInt() ?? 0,
      fine: map['fine']?.toInt() ?? 0,
      cardNumber: map['card_number']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phone: $phone, address: $address, city: $city, state: $state, pincode: $pincode, role: $role, v: $v, fine: $fine, cardNumber: $cardNumber)';
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? city,
    String? state,
    String? pincode,
    String? role,
    int? v,
    int? fine,
    int? cardNumber,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      role: role ?? this.role,
      v: v ?? this.v,
      fine: fine ?? this.fine,
      cardNumber: cardNumber ?? this.cardNumber,
    );
  }
}
