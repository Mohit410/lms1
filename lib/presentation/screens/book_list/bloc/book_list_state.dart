part of 'book_list_bloc.dart';

abstract class BookListState extends Equatable {
  const BookListState();

  @override
  List<Object> get props => [];
}

class EmptyBookList extends BookListState {}

class BookListLoading extends BookListState {}

class BookListLoaded extends BookListState {
  final List<BookModel> books;

  const BookListLoaded(this.books);
}

class BookListFailed extends BookListState {
  final String message;

  const BookListFailed(this.message);
}

class IssueBookSuccess extends BookListState {
  final String message;

  const IssueBookSuccess(this.message);
}

class IssueBookFailed extends BookListState {
  final String message;

  const IssueBookFailed(this.message);
}
