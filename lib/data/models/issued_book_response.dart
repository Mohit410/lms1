import 'dart:convert';

import 'package:equatable/equatable.dart';

class IssuedBookResponse extends Equatable {
  final bool success;
  final ReturnBookModel book;
  const IssuedBookResponse({
    required this.success,
    required this.book,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'success': success});
    result.addAll({'issuedBook': book.toMap()});

    return result;
  }

  factory IssuedBookResponse.fromMap(Map<String, dynamic> map) {
    return IssuedBookResponse(
      success: map['success'] ?? false,
      book: ReturnBookModel.fromMap(map['issuedBook']),
    );
  }

  String toJson() => json.encode(toMap());

  factory IssuedBookResponse.fromJson(String source) =>
      IssuedBookResponse.fromMap(json.decode(source));

  @override
  String toString() => 'IssuedBookResponse(success: $success, book: $book)';

  @override
  List<Object> get props => [success, book];
}

class ReturnBookModel extends Equatable {
  final String id;
  final String issuedBy;
  final String bookId;
  final String issueDate;
  final String issueDays;
  final String returnDate;
  final String fine;
  final int isReturn;
  final int v;
  const ReturnBookModel({
    required this.id,
    required this.issuedBy,
    required this.bookId,
    required this.issueDate,
    required this.issueDays,
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
    result.addAll({'issue_date': issueDate});
    result.addAll({'issue_days': issueDays});
    result.addAll({'return_date': returnDate});
    result.addAll({'fine': fine});
    result.addAll({'is_return': isReturn});
    result.addAll({'__v': v});

    return result;
  }

  factory ReturnBookModel.fromMap(Map<String, dynamic> map) {
    return ReturnBookModel(
      id: map['_id'] ?? '',
      issuedBy: map['issue_by'] ?? '',
      bookId: map['book_id'] ?? '',
      issueDate: map['issue_date'] ?? '',
      issueDays: map['issue_days']?.toString() ?? '',
      returnDate: map['return_date'] ?? '',
      fine: map['fine']?.toString() ?? '',
      isReturn: map['is_return']?.toInt() ?? 0,
      v: map['__v']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReturnBookModel.fromJson(String source) =>
      ReturnBookModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReturnBookModel(id: $id, issuedBy: $issuedBy, bookId: $bookId, issueDate: $issueDate, issueDays: $issueDays, returnDate: $returnDate, fine: $fine, isReturn: $isReturn, v: $v)';
  }

  @override
  List<Object> get props {
    return [
      id,
      issuedBy,
      bookId,
      issueDate,
      issueDays,
      returnDate,
      fine,
      isReturn,
      v
    ];
  }
}
