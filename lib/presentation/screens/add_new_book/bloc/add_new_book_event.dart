part of 'add_new_book_bloc.dart';

abstract class AddNewBookEvent extends Equatable {
  const AddNewBookEvent();

  @override
  List<Object> get props => [];
}

class AddNewBookClicked extends AddNewBookEvent {
  final AddNewBookModel book;

  const AddNewBookClicked(this.book);

  @override
  List<Object> get props => [book];
}

class UpdateBookClicked extends AddNewBookEvent {
  final BookModel book;

  const UpdateBookClicked(this.book);

@override
  List<Object> get props => [book];
}
