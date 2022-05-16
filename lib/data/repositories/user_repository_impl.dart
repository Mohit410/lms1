import 'package:lms1/core/error/exception.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/data/datasources/datasources.dart';
import 'package:lms1/data/models/dashboard_response.dart';
import 'package:lms1/data/models/register_user_model.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/data/models/update_password_body.dart';
import 'package:lms1/data/models/user_detail_response.dart';
import 'package:lms1/data/models/user_list_reponse.dart';
import 'package:lms1/data/models/user_model.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class UserReposiotryImpl implements UserRepository {
  final RemoteDatasource _datasource;

  UserReposiotryImpl(this._datasource);

  @override
  Future<Either<Failure, CommonResponse>> createUser(
      RegisterUserModel userModel) async {
    try {
      final commonRepsonse = await _datasource.createUser(userModel);
      return Right(commonRepsonse);
    } on ServerExceptionWithMessage catch (e) {
      return Left(ServerFailureWithMessage(e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserListResponse>> getUserList() async {
    try {
      final response = await _datasource.getUserList();
      return Right(response);
    } on ServerExceptionWithMessage catch (e) {
      return Left(ServerFailureWithMessage(e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AdminDashboardResponse>>
      getAdminDashboardData() async {
    try {
      final response = await _datasource.getAdminDashboardData();
      return Right(response);
    } on ServerExceptionWithMessage catch (e) {
      return Left(ServerFailureWithMessage(e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, StudentDetailResponse>> getStudentDetails(
      String email) async {
    try {
      final response = await _datasource.getStudentDetails(email);
      return Right(response);
    } on ServerExceptionWithMessage catch (e) {
      return Left(ServerFailureWithMessage(e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CommonResponse>> updateUser(
      String role, UserModel body) async {
    try {
      final response = await _datasource.updateUser(role, body);
      return Right(response);
    } on ServerExceptionWithMessage catch (e) {
      return Left(ServerFailureWithMessage(e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CommonResponse>> updatePassword(
      UpdatePasswordBody body) async {
    try {
      final response = await _datasource.updatePassword(body);
      return Right(response);
    } on ServerExceptionWithMessage catch (e) {
      return Left(ServerFailureWithMessage(e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
