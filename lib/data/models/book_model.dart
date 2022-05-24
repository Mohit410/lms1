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
  final int price;
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
    required this.price,
  });

  BookModel copyWith({
    int? copies,
  }) {
    return BookModel(
      id: id,
      bookId: bookId,
      title: title,
      name: name,
      publisher: publisher,
      author: author,
      copies: copies ?? this.copies,
      category: category,
      availableCopies: availableCopies,
      v: v,
      addedBy: addedBy,
      price: price,
    );
  }

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
    result.addAll({
      'addedBy': addedBy,
      'bk_price': price,
    });

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
      price: map['bk_price'] ?? 0,
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

class AddNewBookModel extends Equatable {
  final String id;
  final String title;
  final String name;
  final String publisher;
  final String author;
  final String totalCopies;
  final String category;
  final String price;
  const AddNewBookModel({
    required this.id,
    required this.title,
    required this.name,
    required this.publisher,
    required this.author,
    required this.totalCopies,
    required this.category,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'book_id': id});
    result.addAll({'bk_title': title});
    result.addAll({'bk_name': name});
    result.addAll({'publisher': publisher});
    result.addAll({'author': author});
    result.addAll({'bk_copies': totalCopies});
    result.addAll({'bk_category': category});
    result.addAll({'bk_price': price});

    return result;
  }

  factory AddNewBookModel.fromMap(Map<String, dynamic> map) => AddNewBookModel(
        id: map['book_id'] ?? '',
        title: map['bk_title'] ?? '',
        name: map['bk_name'] ?? '',
        publisher: map['publisher'] ?? '',
        author: map['author'] ?? '',
        totalCopies: map['bk_copies'] ?? '',
        category: map['bk_category'] ?? '',
        price: map['bk_price'] ?? '',
      );

  String toJson() => json.encode(toMap());

  factory AddNewBookModel.fromJson(String source) =>
      AddNewBookModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'AddNewBookModel(id: $id, title: $title, name: $name, publisher: $publisher, author: $author, totalCopies: $totalCopies, category: $category, price: $price)';

  @override
  List<Object> get props =>
      [id, title, name, publisher, author, totalCopies, category, price];
}
