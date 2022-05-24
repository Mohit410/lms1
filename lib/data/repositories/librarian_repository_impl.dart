import 'dart:developer';

import 'package:lms1/core/error/exception.dart';
import 'package:lms1/data/datasources/datasources.dart';
import 'package:lms1/data/models/dashboard_response.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class LibrarianRepositoryImpl implements LibrarianRepository {
  final RemoteDatasource _datasource;

  LibrarianRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, DashboardResponse>> getDashboardData() async {
    try {
      final response = await _datasource.getLibrarianDashboardData();
      return Right(response);
    } on ServerExceptionWithMessage catch (e) {
      return Left(ServerFailureWithMessage(e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
