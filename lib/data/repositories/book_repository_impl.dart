import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lms1/core/error/exception.dart';

import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/data/datasources/datasources.dart';
import 'package:lms1/data/models/book_details_response.dart';
import 'package:lms1/data/models/book_list_response.dart';
import 'package:lms1/data/models/book_model.dart';
import 'package:lms1/data/models/bulk_upload_error_response.dart';
import 'package:lms1/domain/repositories/book_repository.dart';

class BookRepositoryImpl extends BookRepository {
  final RemoteDatasource _datasource;
  BookRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, BookListResponse>> getBooks() async {
    try {
      final result = await _datasource.getBooks();
      return Right(result);
    } on ServerExceptionWithMessage catch (e) {
      return Left(ServerFailureWithMessage(e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, BookDetailsResponse>> getBookDetails(String bookId) async {
    try {
      final result = await _datasource.getBookDetails(bookId);
      return Right(result);
    } on ServerExceptionWithMessage catch (e) {
      return Left(ServerFailureWithMessage(e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CommonResponse>> addBook(AddNewBookModel book) async {
    try {
      final result = await _datasource.addBook(book);
      return Right(result);
    } on ServerExceptionWithMessage catch (e) {
      return Left(ServerFailureWithMessage(e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, CommonResponse>> updateBook(BookModel book) async {
    try {
      final result = await _datasource.updateBook(book);
      return Right(result);
    } on ServerExceptionWithMessage catch (e) {
      return Left(ServerFailureWithMessage(e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, BulkBookUploadResponse>> uploadBulkBooks(
      PlatformFile file) async {
    try {
      final response = await _datasource.uploadBooksInBulk(file.path!, file.name);
      return Right(response);
    } on ServerExceptionWithMessage<List<BookRowResponse>> catch (e) {
      return Left(ServerFailureWithMessage<List<BookRowResponse>>(e.message,
          data: e.data));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  
}
