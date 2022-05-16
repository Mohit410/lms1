import 'package:dartz/dartz.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/data/models/login_body.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, LoginResponse>> login(LoginBody loginBody);
}
