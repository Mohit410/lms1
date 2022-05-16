import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:lms1/data/models/book_model.dart';

class BookListResponse extends Equatable {
  final bool success;
  final List<BookModel> books;
  const BookListResponse({
    required this.success,
    required this.books,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'success': success});
    result.addAll({'book': books.map((x) => x.toMap()).toList()});

    return result;
  }

  factory BookListResponse.fromMap(Map<String, dynamic> map) {
    return BookListResponse(
      success: map['success'] ?? false,
      books:
          List<BookModel>.from(map['book']?.map((x) => BookModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookListResponse.fromJson(String source) =>
      BookListResponse.fromMap(json.decode(source));

  @override
  String toString() => 'BookListResponse(success: $success, books: $books)';

  @override
  List<Object> get props => [success, books];
}
