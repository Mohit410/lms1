import 'package:lms1/core/error/exception.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/data/datasources/datasources.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class StudentRepositoryImpl implements StudentRepository {
  final RemoteDatasource _datasource;

  StudentRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, DashboardResponse>> getStudentDashbaordData() async {
    try {
      final response = await _datasource.getStudentDashboardDetails();
      return Right(response);
    } on ServerExceptionWithMessage catch (e) {
      return Left(ServerFailureWithMessage(e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CommonResponse>> issueBook(String bookId) async {
    try {
      final response = await _datasource.issueBook(bookId);
      return Right(response);
    } on ServerExceptionWithMessage catch (e) {
      return Left(ServerFailureWithMessage(e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
