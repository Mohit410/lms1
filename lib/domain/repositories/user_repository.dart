import 'package:dartz/dartz.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, CommonResponse>> createUser(UserModel userModel);
}
