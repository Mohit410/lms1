import 'package:dartz/dartz.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/data/models/models.dart';

abstract class LibrarianRepository {
  Future<Either<Failure, DashboardResponse>> getDashboardData();
  Future<Either<Failure, CollectFineDetailResposne>> getFineDetails(String email);
  Future<Either< Failure, CommonResponse>> returnBook(Map<String,  dynamic> body);
  Future<Either< Failure, CommonResponse>> payFine(Map<String,  dynamic> body);
}
