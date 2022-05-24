part of 'add_new_book_bloc.dart';

abstract class AddNewBookState extends Equatable {
  const AddNewBookState();

  @override
  List<Object> get props => [];
}

class AddNewBookInitial extends AddNewBookState {}

class AddNewBookLoading extends AddNewBookState {}

class AddNewBookSuccess extends AddNewBookState {
  final String message;

  const AddNewBookSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AddNewBookFailed extends AddNewBookState {
  final String message;

  const AddNewBookFailed(this.message);

  @override
  List<Object> get props => [message];
}