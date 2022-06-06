part of 'book_list_bloc.dart';

abstract class BookListState extends Equatable {
  const BookListState();

  @override
  List<Object> get props => [];
}

class EmptyBookList extends BookListState {}

class Loading extends BookListState {}

class BookList extends BookListState {
  final List<BookModel> books;

  const BookList(this.books);
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
