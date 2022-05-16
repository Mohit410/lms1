import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/core/usecase/usecase.dart';

import 'package:lms1/data/models/book_model.dart';
import 'package:lms1/domain/usecases/get_book_list.dart';

part 'book_list_event.dart';
part 'book_list_state.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {
  final GetBookList _getBookList;
  BookListBloc(this._getBookList) : super(EmptyBookList()) {
    on<FetchBooks>((event, emit) async {
      emit(Loading());
      final result = await _getBookList(NoParams());

      result.fold((failure) => emit(const Failed('Server Failed')), (response) {
        if (response.success) {
          if (response.books.isEmpty) {
            emit(EmptyBookList());
          } else {
            emit(BooksLoaded(response.books));
          }
        } else {
          emit(const Failed('No data'));
        }
      });
    });
  }
}
