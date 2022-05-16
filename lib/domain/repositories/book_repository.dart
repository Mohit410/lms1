import 'package:dartz/dartz.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/data/models/book_list_response.dart';

abstract class BookRepository {
  Future<Either<Failure, BookListResponse>> getBooks();
}
