import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:lms1/data/models/user_detail_response.dart';

class TransactionListResponse extends Equatable {
  final bool success;
  final List<TransactionModel> transactions;
  const TransactionListResponse({
    required this.success,
    required this.transactions,
  });

  TransactionListResponse copyWith({
    bool? success,
    List<TransactionModel>? transactions,
  }) {
    return TransactionListResponse(
      success: success ?? this.success,
      transactions: transactions ?? this.transactions,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'success': success});
    result
        .addAll({'transactions': transactions.map((x) => x.toMap()).toList()});

    return result;
  }

  factory TransactionListResponse.fromMap(Map<String, dynamic> map) {
    return TransactionListResponse(
      success: map['success'] ?? false,
      transactions: List<TransactionModel>.from(
          map['transactions']?.map((x) => TransactionModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionListResponse.fromJson(String source) =>
      TransactionListResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'TransactionListResponse(success: $success, transactions: $transactions)';

  @override
  List<Object> get props => [success, transactions];
}
