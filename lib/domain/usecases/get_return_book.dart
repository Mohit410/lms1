import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class GetReturnBook extends UseCase<CommonResponse, Map<String, dynamic>> {
  final LibrarianRepository _repository;

  GetReturnBook(this._repository);

  @override
  Future<Either<Failure, CommonResponse>> call(
      Map<String, dynamic> params) async {
    return await _repository.returnBook(params);
  }
}
