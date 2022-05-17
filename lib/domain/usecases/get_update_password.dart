import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class GetUpdatePassword extends UseCase<CommonResponse, UpdatePasswordBody> {
  final UserRepository _repository;

  GetUpdatePassword(this._repository);

  @override
  Future<Either<Failure, CommonResponse>> call(
      UpdatePasswordBody params) async {
    return await _repository.updatePassword(params, params.email, params.role);
  }
}
