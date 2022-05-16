import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class GetUpdateUser extends UseCase<CommonResponse, UserModel> {
  final UserRepository _repository;

  GetUpdateUser(this._repository);

  @override
  Future<Either<Failure, CommonResponse>> call(UserModel params) async {
    return await _repository.updateUser(params.role, params);
  }
}
