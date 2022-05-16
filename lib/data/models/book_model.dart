import 'dart:convert';

import 'package:equatable/equatable.dart';

class BookModel extends Equatable {
  final String id;
  final String bookId;
  final String title;
  final String name;
  final String publisher;
  final String author;
  final int copies;
  final String category;
  final int availableCopies;
  final int v;
  final String addedBy;
  const BookModel({
    required this.id,
    required this.bookId,
    required this.title,
    required this.name,
    required this.publisher,
    required this.author,
    required this.copies,
    required this.category,
    required this.availableCopies,
    required this.v,
    required this.addedBy,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'_id': id});
    result.addAll({'book_id': bookId});
    result.addAll({'bk_title': title});
    result.addAll({'bk_name': name});
    result.addAll({'publisher': publisher});
    result.addAll({'author': author});
    result.addAll({'bk_copies': copies});
    result.addAll({'bk_category': category});
    result.addAll({'available_copies': availableCopies});
    result.addAll({'__v': v});
    result.addAll({'addedBy': addedBy});

    return result;
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['_id'] ?? '',
      bookId: map['book_id'] ?? '',
      title: map['bk_title'] ?? '',
      name: map['bk_name'] ?? '',
      publisher: map['publisher'] ?? '',
      author: map['author'] ?? '',
      copies: map['bk_copies'],
      category: map['bk_category'] ?? '',
      availableCopies: map['available_copies'],
      v: map['__v'],
      addedBy: map['addedBy'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookModel(id: $id, bookId: $bookId, title: $title, name: $name, publisher: $publisher, author: $author, copies: $copies, category: $category, available_copies: $availableCopies, v: $v, addedBy: $addedBy)';
  }

  @override
  List<Object> get props => [
        id,
        bookId,
        title,
        name,
        publisher,
        author,
        copies,
        category,
        availableCopies,
        v,
        addedBy
      ];
}
