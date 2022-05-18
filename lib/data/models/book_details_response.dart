import 'dart:convert';

import 'package:equatable/equatable.dart';

class BookDetailsResponse extends Equatable {
  final bool success;
  final List<AdminBookDetailsModel> issuedBooks;
  const BookDetailsResponse({
    required this.success,
    required this.issuedBooks,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'success': success});
    result.addAll({'issuedBooks': issuedBooks.map((x) => x.toMap()).toList()});

    return result;
  }

  factory BookDetailsResponse.fromMap(Map<String, dynamic> map) {
    return BookDetailsResponse(
      success: map['success'] ?? false,
      issuedBooks: List<AdminBookDetailsModel>.from(
          map['issuedBooks']?.map((x) => AdminBookDetailsModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookDetailsResponse.fromJson(String source) =>
      BookDetailsResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'BookDetailsResponse(success: $success, issuedBooks: $issuedBooks)';

  @override
  List<Object> get props => [success, issuedBooks];
}

class AdminBookDetailsModel extends Equatable {
  final String id;
  final String issuedBy;
  final String bookId;
  final int issueDays;
  final String issueDate;
  final String returnDate;
  final int fine;
  final int isReturn;
  final int v;
  const AdminBookDetailsModel({
    required this.id,
    required this.issuedBy,
    required this.bookId,
    required this.issueDays,
    required this.issueDate,
    required this.returnDate,
    required this.fine,
    required this.isReturn,
    required this.v,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'_id': id});
    result.addAll({'issue_by': issuedBy});
    result.addAll({'book_id': bookId});
    result.addAll({'issue_days': issueDays});
    result.addAll({'issue_date': issueDate});
    result.addAll({'return_date': returnDate});
    result.addAll({'fine': fine});
    result.addAll({'is_return': isReturn});
    result.addAll({'__v': v});

    return result;
  }

  factory AdminBookDetailsModel.fromMap(Map<String, dynamic> map) {
    return AdminBookDetailsModel(
      id: map['_id'] ?? '',
      issuedBy: map['issue_by'] ?? '',
      bookId: map['book_id'] ?? '',
      issueDays: map['issue_days']?.toInt() ?? 0,
      issueDate: map['issue_date'] ?? '',
      returnDate: map['return_date'] ?? '',
      fine: map['fine']?.toInt() ?? 0,
      isReturn: map['is_return']?.toInt() ?? 0,
      v: map['__v']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminBookDetailsModel.fromJson(String source) =>
      AdminBookDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AdminBookDetailsModel(id: $id, issuedBy: $issuedBy, bookId: $bookId, issueDays: $issueDays, issueDate: $issueDate, returnDate: $returnDate, fine: $fine, isReturn: $isReturn, v: $v)';
  }

  @override
  List<Object> get props {
    return [
      id,
      issuedBy,
      bookId,
      issueDays,
      issueDate,
      returnDate,
      fine,
      isReturn,
      v
    ];
  }
}
