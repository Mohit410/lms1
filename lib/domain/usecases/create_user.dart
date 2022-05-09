import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/user_model.dart';
import 'package:lms1/domain/repositories/user_repository.dart';

class CreateUser extends UseCase<CommonResponse, UserModel> {
  final UserRepository repository;

  CreateUser({required this.repository});

  @override
  Future<Either<Failure, CommonResponse>> call(UserModel params) async {
    return await repository.createUser(params);
  }
}
