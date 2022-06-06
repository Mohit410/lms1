import 'package:lms1/core/error/exception.dart';
import 'package:lms1/core/network/network_info.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/data/datasources/datasources.dart';
import 'package:lms1/data/models/dashboard_response.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/data/models/fine_details_response.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class LibrarianRepositoryImpl implements LibrarianRepository {
  final RemoteDatasource _datasource;
  final NetworkInfo _networkInfo;

  LibrarianRepositoryImpl(this._datasource, this._networkInfo);

  @override
  Future<Either<Failure, DashboardResponse>> getDashboardData() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _datasource.getLibrarianDashboardData();
        return Right(response);
      } on ServerExceptionWithMessage catch (e) {
        return Left(ServerFailureWithMessage(e.message));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailureWithMessage("No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, CollectFineDetailResposne>> getFineDetails(
      String email) async {
    if (await _networkInfo.isConnected) {
      try {
        final response1 = await _datasource.getFineDetails(email);
        final repsonse2 = await _datasource.getFineHistory(email);
        return Right(CollectFineDetailResposne(
            response1.fineData, repsonse2.fineHistory));
      } on ServerExceptionWithMessage catch (e) {
        return Left(ServerFailureWithMessage(e.message));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailureWithMessage("No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, CommonResponse>> payFine(
      Map<String, dynamic> body) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _datasource.payFine(body);
        return Right(response);
      } on ServerExceptionWithMessage catch (e) {
        return Left(ServerFailureWithMessage(e.message));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailureWithMessage("No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, CommonResponse>> returnBook(
      Map<String, dynamic> body) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _datasource.returnBook(body);
        return Right(response);
      } on ServerExceptionWithMessage catch (e) {
        return Left(ServerFailureWithMessage(e.message));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailureWithMessage("No Internet Connection"));
    }
  }
}
