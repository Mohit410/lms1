import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/data/models/book_list_response.dart';
import 'package:lms1/data/models/models.dart';

abstract class BookRepository {
  Future<Either<Failure, BookListResponse>> getBooks();
  Future<Either<Failure, BookDetailsResponse>> getBookDetails(String bookId);

  Future<Either<Failure, CommonResponse>> addBook(AddNewBookModel book);

  Future<Either<Failure, CommonResponse>> updateBook(BookModel book);

  Future<Either<Failure, BulkBookUploadResponse>> uploadBulkBooks(
      PlatformFile file);

  Future<Either<Failure, IssuedBookResponse>> getIssuedBookDetails(
      String email, String bookId);
}
