import 'package:file_picker/src/platform_file.dart';
import 'package:lms1/core/error/exception.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/data/datasources/datasources.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/data/models/user_detail_response.dart';
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
  Future<Either<Failure, DashboardResponse>>
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
      UpdatePasswordBody body, String email, String role) async {
    try {
      final response = await _datasource.updatePassword(body, email, role);
      return Right(response);
    } on ServerExceptionWithMessage catch (e) {
      return Left(ServerFailureWithMessage(e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, BulkUploadResponse>> uploadBulkUsers(
      PlatformFile file) async {
    try {
      final response = await _datasource.uploadBulk(file.path!, file.name);
      return Right(response);
    } on ServerExceptionWithMessage<List<ExcelRowResponse>> catch (e) {
      return Left(ServerFailureWithMessage<List<ExcelRowResponse>>(e.message,
          data: e.data));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
