import 'dart:convert';

import 'package:lms1/data/models/models.dart';
import 'package:lms1/data/models/user_detail_response.dart';

class StudentDashboardResponse extends DashboardResponse {
  final bool success;
  final List<IssuedBookModel> issuedBooks;
  final String totalFine;
  final List<TransactionModel> transactions;
  final List<FineHistoryModel> fineHistory;
  StudentDashboardResponse({
    required this.success,
    required this.issuedBooks,
    required this.totalFine,
    required this.transactions,
    required this.fineHistory,
    required UserModel user1,
  }) : super(user1);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'success': success});
    result.addAll({'issued_books': issuedBooks.map((x) => x.toMap()).toList()});
    result.addAll({'totalfine': totalFine});
    result
        .addAll({'transactions': transactions.map((x) => x.toMap()).toList()});
    result.addAll({'finehistory': fineHistory.map((x) => x.toMap()).toList()});
    result.addAll({'registration_details': user.toMap()});

    return result;
  }

  factory StudentDashboardResponse.fromMap(Map<String, dynamic> map) {
    return StudentDashboardResponse(
      success: map['success'] ?? false,
      issuedBooks: List<IssuedBookModel>.from(
          map['issued_books']?.map((x) => IssuedBookModel.fromMap(x))),
      totalFine: map['totalfine']?.toString() ?? '',
      transactions: List<TransactionModel>.from(
          map['transactions']?.map((x) => TransactionModel.fromMap(x))),
      fineHistory: List<FineHistoryModel>.from(
          map['finehistory']?.map((x) => FineHistoryModel.fromMap(x))),
      user1: UserModel.fromMap(map['registration_details']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentDashboardResponse.fromJson(String source) =>
      StudentDashboardResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StudentDashboardResponse(success: $success, issuedBooks: $issuedBooks, totalFine: $totalFine, transactions: $transactions, fineHistory: $fineHistory, studentData: $user)';
  }

  @override
  List<Object> get props {
    return [
      success,
      issuedBooks,
      totalFine,
      transactions,
      fineHistory,
      user,
    ];
  }
}
