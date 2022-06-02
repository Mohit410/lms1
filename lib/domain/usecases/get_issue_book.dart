import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class GetIssueBook extends UseCase<CommonResponse, String> {
  final StudentRepository _repository;

  GetIssueBook(this._repository);

  @override
  Future<Either<Failure, CommonResponse>> call(String params) async {
    return await _repository.issueBook(params);
  }
}
