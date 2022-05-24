import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/book_model.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class GetAddBook extends UseCase<CommonResponse, AddNewBookModel> {
  final BookRepository _repository;

  GetAddBook(this._repository);

  @override
  Future<Either<Failure, CommonResponse>> call(AddNewBookModel params) async {
    return await _repository.addBook(params);
  }
}
