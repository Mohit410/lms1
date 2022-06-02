import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/issued_book_response.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class GetIssuedBookDetails
    extends UseCase<IssuedBookResponse, IssuedBookDetailsParams> {
  final BookRepository _repository;

  GetIssuedBookDetails(this._repository);

  @override
  Future<Either<Failure, IssuedBookResponse>> call(IssuedBookDetailsParams params) async {
    return await _repository.getIssuedBookDetails(params.email, params.bookId);
  }
}

class IssuedBookDetailsParams extends Equatable {
  final String email;
  final String bookId;

  const IssuedBookDetailsParams(this.email, this.bookId);

  @override
  List<Object?> get props => [email, bookId];
}
