import 'package:dartz/dartz.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/data/models/book_list_response.dart';
import 'package:lms1/data/models/models.dart';

abstract class BookRepository {
  Future<Either<Failure, BookListResponse>> getBooks();
  Future<Either<Failure, BookDetailsResponse>> getBookDetails(String bookId);
}
