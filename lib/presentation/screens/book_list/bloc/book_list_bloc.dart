import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/usecase/usecase.dart';

import 'package:lms1/data/models/book_model.dart';
import 'package:lms1/domain/usecases/usecases.dart';

part 'book_list_event.dart';
part 'book_list_state.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {
  final GetBookList _getBookList;
  final GetIssueBook _getIssueBook;
  BookListBloc(this._getBookList, this._getIssueBook) : super(EmptyBookList()) {
    on<FetchBooks>((event, emit) async {
      emit(Loading());
      final result = await _getBookList(NoParams());

      result.fold((failure) {
        if (failure is ServerFailureWithMessage) {
          emit(BookListFailed(failure.message));
        } else {
          emit(const BookListFailed('Server Failed'));
        }
      }, (response) {
        if (response.success) {
          if (response.books.isEmpty) {
            emit(EmptyBookList());
          } else {
            emit(BookList(response.books));
          }
        } else {
          emit(const BookListFailed('No data'));
        }
      });
    });

    on<IssueBook>((event, emit) async {
      emit(Loading());

      final result = await _getIssueBook(event.bookId);

      result.fold(
        (failure) {
          failure is ServerFailureWithMessage
              ? emit(IssueBookFailed(failure.message))
              : emit(const IssueBookFailed('Server Error'));
        },
        (response) => emit(IssueBookSuccess(response.message)),
      );
    });
  }
}
