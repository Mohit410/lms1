import 'package:dartz/dartz.dart';
import 'package:lms1/core/error/exception.dart';

import 'package:lms1/core/error/failure.dart';
import 'package:lms1/data/datasources/datasources.dart';
import 'package:lms1/data/models/book_details_response.dart';
import 'package:lms1/data/models/book_list_response.dart';
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
}
