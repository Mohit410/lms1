import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/user_detail_response.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class GetStudentDetails extends UseCase<StudentDetailResponse, String> {
  final UserRepository _repository;

  GetStudentDetails(this._repository);

  @override
  Future<Either<Failure, StudentDetailResponse>> call(String params) async {
    return await _repository.getStudentDetails(params);
  }
}
