part of 'book_details_bloc.dart';

abstract class BookDetailsEvent extends Equatable {
  const BookDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchBookDetails extends BookDetailsEvent {
  final String bookId;

  const FetchBookDetails(this.bookId);

@override
  List<Object> get props => [bookId];
}
