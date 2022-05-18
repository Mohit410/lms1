part of 'book_details_bloc.dart';

abstract class BookDetailsState extends Equatable {
  const BookDetailsState();

  @override
  List<Object> get props => [];
}

class BookDetailsInitial extends BookDetailsState {}

class BookDetailsLoading extends BookDetailsState {}

class BookDetailsLoaded extends BookDetailsState {
  final List<AdminBookDetailsModel> issuedBooks;

  const BookDetailsLoaded(this.issuedBooks);
}

class BookDetailsFailed extends BookDetailsState {
  final String message;

  const BookDetailsFailed(this.message);

  @override
  List<Object> get props => [message];
}
