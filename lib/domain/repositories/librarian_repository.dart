import 'package:dartz/dartz.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/data/models/models.dart';

abstract class LibrarianRepository {
  Future<Either<Failure, DashboardResponse>> getDashboardData();
}
