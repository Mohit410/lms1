part of 'book_list_bloc.dart';

abstract class BookListState extends Equatable {
  const BookListState();

  @override
  List<Object> get props => [];
}

class EmptyBookList extends BookListState {}

class Loading extends BookListState {}

class BooksLoaded extends BookListState {
  final List<BookModel> books;

  const BooksLoaded(this.books);
}

class Failed extends BookListState {
  final String message;

  const Failed(this.message);
}

class IssueBookSuccess extends BookListState {
  final String message;

  const IssueBookSuccess(this.message);
}

class IssueBookFailed extends BookListState {
  final String message;

  const IssueBookFailed(this.message);
}
