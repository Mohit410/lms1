import 'package:dartz/dartz.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/data/models/user_detail_response.dart';

abstract class UserRepository {
  Future<Either<Failure, CommonResponse>> createUser(
      RegisterUserModel userModel);

  Future<Either<Failure, UserListResponse>> getUserList();

  Future<Either<Failure, AdminDashboardResponse>> getAdminDashboardData();

  Future<Either<Failure, StudentDetailResponse>> getStudentDetails(
      String email);

  Future<Either<Failure, CommonResponse>> updateUser(
      String role, UserModel body);

  Future<Either<Failure, CommonResponse>> updatePassword(UpdatePasswordBody body);
}
