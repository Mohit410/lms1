part of 'return_book_bloc.dart';

abstract class ReturnBookEvent extends Equatable {
  const ReturnBookEvent();

  @override
  List<Object> get props => [];
}

class FetchIssuedBookDetails extends ReturnBookEvent {
  final String email;
  final String bookId;

  const FetchIssuedBookDetails(this.email, this.bookId);

  @override
  List<Object> get props => [email, bookId];
}

class ReturnBookClicked extends ReturnBookEvent {
  final String bookId;
  final String email;
  final String issueDate;
  final String returnDate;
  final String fine;

  const ReturnBookClicked(this.bookId, this.email, this.issueDate, this.returnDate, this.fine);

  @override
  List<Object> get props => [bookId, email, issueDate, returnDate, fine];
}
