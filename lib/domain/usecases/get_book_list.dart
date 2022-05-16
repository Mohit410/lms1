import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/book_list_response.dart';
import 'package:lms1/domain/repositories/repositories.dart';


class GetBookList extends UseCase<BookListResponse, NoParams> {
  final BookRepository _repository;

  GetBookList(this._repository);


  @override
  Future<Either<Failure, BookListResponse>> call(params) {
    return _repository.getBooks();
  }
}
