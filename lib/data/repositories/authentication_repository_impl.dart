import 'package:lms1/core/error/exception.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/data/datasources/remote_datasource.dart';
import 'package:lms1/data/models/login_body.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final RemoteDatasource _datasource;

  AuthenticationRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, LoginResponse>> login(LoginBody loginBody) async {
    try {
      final response = await _datasource.login(loginBody);
      return Right(response);
    } on ServerExceptionWithMessage catch (e) {
      return Left(ServerFailureWithMessage(e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
