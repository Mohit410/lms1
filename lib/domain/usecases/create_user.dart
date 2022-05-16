import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/register_user_model.dart';
import 'package:lms1/domain/repositories/user_repository.dart';

class CreateUser extends UseCase<CommonResponse, RegisterUserModel> {
  final UserRepository _repository;

  CreateUser(this._repository);

  @override
  Future<Either<Failure, CommonResponse>> call(RegisterUserModel params) async {
    return await _repository.createUser(params);
  }
}
