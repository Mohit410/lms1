import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:lms1/data/models/models.dart';

class AdminDashboardResponse extends Equatable {
  final bool success;
  final UserModel adminData;
  final int totalUsers;
  final int totalBooks;
  final int totalFineCollection;
  const AdminDashboardResponse({
    required this.success,
    required this.adminData,
    required this.totalUsers,
    required this.totalBooks,
    required this.totalFineCollection,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'success': success});
    result.addAll({'adminData': adminData.toMap()});
    result.addAll({'total_users': totalUsers});
    result.addAll({'total_books': totalBooks});
    result.addAll({'total_fine_collection': totalFineCollection});

    return result;
  }

  factory AdminDashboardResponse.fromMap(Map<String, dynamic> map) {
    return AdminDashboardResponse(
      success: map['success'],
      adminData: UserModel.fromMap(map['adminData']),
      totalUsers: map['total_users'],
      totalBooks: map['total_books'],
      totalFineCollection: map['total_fine_collection'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminDashboardResponse.fromJson(String source) =>
      AdminDashboardResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AdminDashboard(success: $success, adminData: $adminData, totalUsers: $totalUsers, totalBooks: $totalBooks, totalFineCollection: $totalFineCollection)';
  }

  @override
  List<Object> get props {
    return [success, adminData, totalUsers, totalBooks, totalFineCollection];
  }
}
