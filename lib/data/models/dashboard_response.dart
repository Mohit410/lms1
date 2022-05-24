import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:lms1/data/models/models.dart';

abstract class DashboardResponse extends Equatable {}

class AdminDashboardResponse extends DashboardResponse {
  final bool success;
  final UserModel adminData;
  final int totalUsers;
  final int totalBooks;
  final int totalFineCollection;
  AdminDashboardResponse({
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

class LibrarianDashboardResponse extends DashboardResponse {
  final bool success;
  final UserModel librarianData;
  final int totalBooks;
  final int totalStudents;
  final List<StudentHeavyFineModel> studentsHeavyFine;
  final List<UnavailableBook> unavailableBooks;
  LibrarianDashboardResponse({
    required this.success,
    required this.librarianData,
    required this.totalBooks,
    required this.totalStudents,
    required this.studentsHeavyFine,
    required this.unavailableBooks,
  });

  LibrarianDashboardResponse copyWith({
    bool? success,
    UserModel? librarianData,
    int? totalBooks,
    int? totalStudents,
    List<StudentHeavyFineModel>? studentsHeavyFine,
    List<UnavailableBook>? unavailableBooks,
  }) {
    return LibrarianDashboardResponse(
      success: success ?? this.success,
      librarianData: librarianData ?? this.librarianData,
      totalBooks: totalBooks ?? this.totalBooks,
      totalStudents: totalStudents ?? this.totalStudents,
      studentsHeavyFine: studentsHeavyFine ?? this.studentsHeavyFine,
      unavailableBooks: unavailableBooks ?? this.unavailableBooks,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'success': success});
    result.addAll({'librarianData': librarianData.toMap()});
    result.addAll({'total_books': totalBooks});
    result.addAll({'total_students': totalStudents});
    result.addAll({
      'students_heavy_fine': studentsHeavyFine.map((x) => x.toMap()).toList()
    });
    result.addAll(
        {'unavailable_book_copies': unavailableBooks.map((x) => x.toMap()).toList()});

    return result;
  }

  factory LibrarianDashboardResponse.fromMap(Map<String, dynamic> map) {
    return LibrarianDashboardResponse(
      success: map['success'] ?? false,
      librarianData: UserModel.fromMap(map['librarianData']),
      totalBooks: map['total_books']?.toInt() ?? 0,
      totalStudents: map['total_students']?.toInt() ?? 0,
      studentsHeavyFine: List<StudentHeavyFineModel>.from(
          map['students_heavy_fine']
              ?.map((x) => StudentHeavyFineModel.fromMap(x))),
      unavailableBooks: List<UnavailableBook>.from(
          map['unavailable_book_copies']?.map((x) => UnavailableBook.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory LibrarianDashboardResponse.fromJson(String source) =>
      LibrarianDashboardResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LibrarianDashboardResponse(success: $success, librarianData: $librarianData, totalBooks: $totalBooks, totalStudents: $totalStudents, studentHeavyFine: $studentsHeavyFine, unavailableBooks: $unavailableBooks)';
  }

  @override
  List<Object> get props {
    return [
      success,
      librarianData,
      totalBooks,
      totalStudents,
      studentsHeavyFine,
      unavailableBooks
    ];
  }
}

class UnavailableBook extends Equatable {
  final String id;
  final String name;
  const UnavailableBook({
    required this.id,
    required this.name,
  });

  UnavailableBook copyWith({
    String? id,
    String? name,
  }) {
    return UnavailableBook(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'book_id': id});
    result.addAll({'bk_name': name});

    return result;
  }

  factory UnavailableBook.fromMap(Map<String, dynamic> map) {
    return UnavailableBook(
      id: map['book_id'] ?? '',
      name: map['bk_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UnavailableBook.fromJson(String source) =>
      UnavailableBook.fromMap(json.decode(source));

  @override
  String toString() => 'UnavailableBook(id: $id, name: $name)';

  @override
  List<Object> get props => [id, name];
}

class StudentHeavyFineModel extends Equatable {
  final String email;
  final int fine;
  const StudentHeavyFineModel({
    required this.email,
    required this.fine,
  });

  StudentHeavyFineModel copyWith({
    String? email,
    int? fine,
  }) {
    return StudentHeavyFineModel(
      email: email ?? this.email,
      fine: fine ?? this.fine,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'fine': fine});

    return result;
  }

  factory StudentHeavyFineModel.fromMap(Map<String, dynamic> map) {
    return StudentHeavyFineModel(
      email: map['email'] ?? '',
      fine: map['fine'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentHeavyFineModel.fromJson(String source) =>
      StudentHeavyFineModel.fromMap(json.decode(source));

  @override
  String toString() => 'StudentHeavyFineModel(email: $email, fine: $fine)';

  @override
  List<Object> get props => [email, fine];
}
