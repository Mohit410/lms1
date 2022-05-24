import 'dart:convert';

import 'package:lms1/core/response/response.dart';
import 'package:lms1/data/models/models.dart';

class BulkUploadResponse extends CommonResponse {
  final List<ExcelRowResponse> data;
  const BulkUploadResponse({
    required super.success,
    required super.message,
    required this.data,
  });

  @override
  Map<String, dynamic> toMap() {
    final result = super.toMap();

    result.addAll({'data': data.map((x) => x.toMap()).toList()});

    return result;
  }

  factory BulkUploadResponse.fromMap(Map<String, dynamic> map) {
    return BulkUploadResponse(
      data: List<ExcelRowResponse>.from(
          map['data']?.map((x) => ExcelRowResponse.fromMap(x))),
      message: map['message'],
      success: map['success'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory BulkUploadResponse.fromJson(String source) =>
      BulkUploadResponse.fromMap(json.decode(source));

  @override
  String toString() => 'BulkUploadResponse(data: $data)';
}

abstract class BulkResponseWrapper<T> {
  Map<String, dynamic> toMap();
  T fromMap(Map<String, dynamic> map);
}

class ExcelRowResponse extends RegisterUserModel {
  final String error;

  const ExcelRowResponse({
    required super.name,
    required super.email,
    required super.address,
    required super.city,
    required super.pincode,
    required super.state,
    required super.mobileNo,
    required super.role,
    required this.error,
  });

  @override
  Map<String, dynamic> toMap() {
    final result = super.toMap();

    result.addAll({'error': error});

    return result;
  }

  factory ExcelRowResponse.fromMap(Map<String, dynamic> map) {
    return ExcelRowResponse(
      error: map['error'] ?? '',
      name: map['name'],
      address: map['address'],
      city: map['city'],
      email: map['email'],
      mobileNo: map['phone']?.toString() ?? '',
      pincode: map['pincode']?.toString() ?? '',
      role: map['role'],
      state: map['state'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ExcelRowResponse.fromJson(String source) =>
      ExcelRowResponse.fromMap(json.decode(source));
}

class BulkBookUploadResponse extends CommonResponse {
  final List<BookRowResponse> data;
  const BulkBookUploadResponse({
    required super.success,
    required super.message,
    required this.data,
  });

  @override
  Map<String, dynamic> toMap() {
    final result = super.toMap();

    result.addAll({'data': data.map((x) => x.toMap()).toList()});

    return result;
  }

  factory BulkBookUploadResponse.fromMap(Map<String, dynamic> map) {
    return BulkBookUploadResponse(
      data: List<BookRowResponse>.from(
          map['data']?.map((x) => BookRowResponse.fromMap(x))),
      message: map['message'],
      success: map['success'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory BulkBookUploadResponse.fromJson(String source) =>
      BulkBookUploadResponse.fromMap(json.decode(source));

  @override
  String toString() => 'BulkUploadResponse(data: $data)';
}

class BookRowResponse extends AddNewBookModel {
  final String error;
  const BookRowResponse(
      {required this.error,
      required super.id,
      required super.title,
      required super.name,
      required super.publisher,
      required super.author,
      required super.category,
      required super.price,
      required super.totalCopies});

  @override
  Map<String, dynamic> toMap() {
    final result = super.toMap();

    result.addAll({'error': error});

    return result;
  }

  factory BookRowResponse.fromMap(Map<String, dynamic> map) {
    return BookRowResponse(
      error: map['error'] ?? '',
      id: map['book_id']?.toString() ?? '',
      title: map['bk_title'],
      name: map['bk_name'],
      author: map['author'],
      publisher: map['publisher'],
      category: map['bk_category'],
      price: map['bk_price']?.toString() ?? '',
      totalCopies: map['bk_copies']?.toString() ?? '',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory BookRowResponse.fromJson(String source) =>
      BookRowResponse.fromMap(json.decode(source));
}
