part of 'librarian_list_bloc.dart';

abstract class LibrarianListEvent extends Equatable {
  const LibrarianListEvent();

  @override
  List<Object> get props => [];
}

class FetchLibrarianList extends LibrarianListEvent {}
