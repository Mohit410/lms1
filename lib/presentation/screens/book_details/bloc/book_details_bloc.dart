import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/data/models/models.dart';

import 'package:lms1/domain/usecases/get_book_details.dart';

part 'book_details_event.dart';
part 'book_details_state.dart';

class BookDetailsBloc extends Bloc<BookDetailsEvent, BookDetailsState> {
  final GetBookDetails _getBookDetails;
  BookDetailsBloc(this._getBookDetails) : super(BookDetailsInitial()) {
    on<FetchBookDetails>((event, emit) async {
      emit(BookDetailsLoading());

      final result = await _getBookDetails(event.bookId);

      result.fold(
        (failure) {
          if (failure is ServerFailureWithMessage) {
            emit(BookDetailsFailed(failure.message));
          } else {
            emit(const BookDetailsFailed('Server Error'));
          }
        },
        (response) => emit(BookDetailsLoaded(response.issuedBooks)),
      );
    });
  }
}
