part of 'librarian_list_bloc.dart';

abstract class LibrarianListState extends Equatable {
  const LibrarianListState();

  @override
  List<Object> get props => [];
}

class LibrarianListInitial extends LibrarianListState {}

class Loading extends LibrarianListState {}

class LibrariansLoaded extends LibrarianListState {
  final List<UserModel> librarians;
  const LibrariansLoaded({required this.librarians});

  @override
  List<Object> get props => [librarians];
}

class EmptyLibrarians extends LibrarianListState {}

class Failed extends LibrarianListState {
  final String message;
  const Failed({required this.message});

  @override
  List<Object> get props => [message];
}
