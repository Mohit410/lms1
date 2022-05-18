import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class GetBookDetails extends UseCase<BookDetailsResponse, String> {
  final BookRepository _repository;

  GetBookDetails(this._repository);
  @override
  Future<Either<Failure, BookDetailsResponse>> call(String params) async {
    return await _repository.getBookDetails(params);
  }
}
