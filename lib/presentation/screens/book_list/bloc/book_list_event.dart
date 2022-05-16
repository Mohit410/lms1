part of 'book_list_bloc.dart';

abstract class BookListEvent extends Equatable {
  const BookListEvent();

  @override
  List<Object> get props => [];
}

class FetchBooks extends BookListEvent {}
