import 'package:dartz/dartz.dart';

import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/user_list_reponse.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class GetUserList extends UseCase<UserListResponse, NoParams> {
  final UserRepository _repository;
  GetUserList(this._repository);

  @override
  Future<Either<Failure, UserListResponse>> call(params) async {
    return await _repository.getUserList();
  }
}
