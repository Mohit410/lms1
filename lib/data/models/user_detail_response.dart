import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:lms1/data/models/models.dart';

class StudentDetailResponse extends Equatable {
  final bool success;
  final List<IssuedBookModel> issuedBooks;
  final int totalFine;
  final List<TransactionModel> transactions;
  final UserModel user;
  final List<FineHistoryModel> fineHistory;
  const StudentDetailResponse({
    required this.success,
    required this.issuedBooks,
    required this.totalFine,
    required this.transactions,
    required this.user,
    required this.fineHistory,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'success': success});
    result.addAll({'issued_books': issuedBooks.map((x) => x.toMap()).toList()});
    result.addAll({'totalfine': totalFine});
    result
        .addAll({'transactions': transactions.map((x) => x.toMap()).toList()});
    result.addAll({'registration_details': user.toMap()});
    result.addAll({'finehistory': fineHistory.map((x) => x.toMap()).toList()});

    return result;
  }

  factory StudentDetailResponse.fromMap(Map<String, dynamic> map) {
    return StudentDetailResponse(
      success: map['success'] ?? false,
      issuedBooks: List<IssuedBookModel>.from(
          map['issued_books']?.map((x) => IssuedBookModel.fromMap(x))),
      totalFine: map['totalfine']?.toInt() ?? 0,
      transactions: List<TransactionModel>.from(
          map['transactions']?.map((x) => TransactionModel.fromMap(x))),
      user: UserModel.fromMap(map['registration_details']),
      fineHistory: List<FineHistoryModel>.from(
          map['finehistory']?.map((x) => FineHistoryModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentDetailResponse.fromJson(String source) =>
      StudentDetailResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StudentDetailResponse(success: $success, issuedBooks: $issuedBooks, totalFine: $totalFine, transactions: $transactions, user: $user, fineHistory: $fineHistory)';
  }

  @override
  List<Object> get props {
    return [success, issuedBooks, totalFine, transactions, user, fineHistory];
  }
}

class IssuedBookModel extends Equatable {
  final String id;
  final String name;
  final String author;
  final String publisher;
  final String category;
  final String issueDate;
  final String returnDate;
  final String bookId;
  final int fine;
  const IssuedBookModel({
    required this.id,
    required this.name,
    required this.author,
    required this.publisher,
    required this.category,
    required this.issueDate,
    required this.returnDate,
    required this.fine,
    required this.bookId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'book_id': id});
    result.addAll({'bk_name': name});
    result.addAll({'author': author});
    result.addAll({'publisher': publisher});
    result.addAll({'bk_category': category});
    result.addAll({'issue_date': issueDate});
    result.addAll({'return_date': returnDate});
    result.addAll({'fine': fine});
    result.addAll({'book_id': bookId});

    return result;
  }

  factory IssuedBookModel.fromMap(Map<String, dynamic> map) {
    return IssuedBookModel(
      id: map['book_id'] ?? '',
      name: map['bk_name'] ?? '',
      author: map['author'] ?? '',
      publisher: map['publisher'] ?? '',
      category: map['bk_category'] ?? '',
      issueDate: map['issue_date'] ?? '',
      returnDate: map['return_date'] ?? '',
      fine: map['fine']?.toInt() ?? 0,
      bookId: map['book_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory IssuedBookModel.fromJson(String source) =>
      IssuedBookModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'IssuedBookModel(id: $id, name: $name, author: $author, publisher: $publisher, category: $category, issue_date: $issueDate, return_date: $returnDate, fine: $fine)';
  }

  @override
  List<Object> get props {
    return [id, name, author, publisher, category, issueDate, returnDate, fine];
  }
}

class TransactionModel extends Equatable {
  final String id;
  final String userId;
  final int amount;
  final String transactionDate;
  final String purpose;
  final int v;
  const TransactionModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.transactionDate,
    required this.purpose,
    required this.v,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'_id': id});
    result.addAll({'user_id': userId});
    result.addAll({'amount': amount});
    result.addAll({'transaction_date': transactionDate});
    result.addAll({'purpose': purpose});
    result.addAll({'__v': v});

    return result;
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['_id'] ?? '',
      userId: map['user_id'] ?? '',
      amount: map['amount']?.toInt() ?? 0,
      transactionDate: map['transaction_date'] ?? '',
      purpose: map['purpose'] ?? '',
      v: map['__v']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionModel(id: $id, userId: $userId, amount: $amount, transactionDate: $transactionDate, purpose: $purpose, v: $v)';
  }

  @override
  List<Object> get props {
    return [id, userId, amount, transactionDate, purpose, v];
  }
}

class FineHistoryModel extends Equatable {
  final String id;
  final String issuedBy;
  final String bookId;
  final String issueDate;
  final String actualReturnDate;
  final String userReturnDate;
  final int fine;
  final int v;
  const FineHistoryModel({
    required this.id,
    required this.issuedBy,
    required this.bookId,
    required this.issueDate,
    required this.actualReturnDate,
    required this.userReturnDate,
    required this.fine,
    required this.v,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'_id': id});
    result.addAll({'issue_by': issuedBy});
    result.addAll({'book_id': bookId});
    result.addAll({'issue_date': issueDate});
    result.addAll({'actual_return_date': actualReturnDate});
    result.addAll({'user_return_date': userReturnDate});
    result.addAll({'fine': fine});
    result.addAll({'__v': v});

    return result;
  }

  factory FineHistoryModel.fromMap(Map<String, dynamic> map) {
    return FineHistoryModel(
      id: map['id'] ?? '',
      issuedBy: map['issued_by'] ?? '',
      bookId: map['book_id'] ?? '',
      issueDate: map['issue_date'] ?? '',
      actualReturnDate: map['actual_return_date'] ?? '',
      userReturnDate: map['user_return_date'] ?? '',
      fine: map['fine']?.toInt() ?? 0,
      v: map['__v']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FineHistoryModel.fromJson(String source) =>
      FineHistoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return "Book Id: $bookId, Fine: Rs. $fine";
  }

  @override
  List<Object> get props => [
        id,
        issuedBy,
        bookId,
        issueDate,
        actualReturnDate,
        userReturnDate,
        fine,
        v
      ];
}
