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
