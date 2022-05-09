import 'package:lms1/core/error/exception.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/data/datasources/datasources.dart';
import 'package:lms1/data/models/user_model.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class UserReposiotryImpl implements UserRepository {
  final RemoteDatasource datasource;

  UserReposiotryImpl(this.datasource);

  @override
  Future<Either<Failure, CommonResponse>> createUser(
      UserModel userModel) async {
    try {
      final commonRepsonse = await datasource.createUser(userModel);
      return Right(commonRepsonse);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
