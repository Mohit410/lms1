part of 'return_book_bloc.dart';

abstract class ReturnBookState extends Equatable {
  const ReturnBookState();

  @override
  List<Object> get props => [];
}

class ReturnBookInitial extends ReturnBookState {}

class ReturnBookLoading extends ReturnBookState {}

class IssuedBookDetailsLoaded extends ReturnBookState {
  final ReturnBookModel issuedBook;

  const IssuedBookDetailsLoaded(this.issuedBook);
}

class ReturnBookSuccess extends ReturnBookState {
  final String message;

  const ReturnBookSuccess(this.message);
}

class ReturnBookFailed extends ReturnBookState {
  final String message;

  const ReturnBookFailed(this.message);
}
