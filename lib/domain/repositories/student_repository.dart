import 'package:dartz/dartz.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/data/models/models.dart';

abstract class StudentRepository {
  Future<Either<Failure, DashboardResponse>> getStudentDashbaordData();
  Future<Either<Failure, CommonResponse>> issueBook(String bookId);
}
