part of 'book_list_bloc.dart';

abstract class BookListEvent extends Equatable {
  const BookListEvent();

  @override
  List<Object> get props => [];
}

class FetchBooks extends BookListEvent {}

class IssueBook extends BookListEvent {
  final String bookId;

  const IssueBook(this.bookId);

  @override
  List<Object> get props => [bookId];
}
