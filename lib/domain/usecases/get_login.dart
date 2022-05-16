import 'package:dartz/dartz.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/login_body.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class GetLogin extends UseCase<LoginResponse, LoginBody> {
  final AuthenticationRepository _repository;

  GetLogin(this._repository);

  @override
  Future<Either<Failure, LoginResponse>> call(LoginBody params) async {
    return await _repository.login(params);
  }
}
