import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/data/models/issued_book_response.dart';
import 'package:lms1/data/models/user_detail_response.dart';
import 'package:lms1/domain/usecases/usecases.dart';

part 'return_book_event.dart';
part 'return_book_state.dart';

class ReturnBookBloc extends Bloc<ReturnBookEvent, ReturnBookState> {
  final GetIssuedBookDetails _fetchBookDetails;
  final GetReturnBook _getReturnBook;

  ReturnBookBloc(this._fetchBookDetails, this._getReturnBook)
      : super(ReturnBookInitial()) {
    on<FetchIssuedBookDetails>((event, emit) async {
      emit(ReturnBookLoading());
      final result = await _fetchBookDetails(
          IssuedBookDetailsParams(event.email, event.bookId));

      result.fold((failure) {
        if (failure is ServerFailureWithMessage) {
          emit(ReturnBookFailed(failure.message));
        } else {
          emit(const ReturnBookFailed('Server Failed'));
        }
      }, (response) => emit(IssuedBookDetailsLoaded(response.book)));
    });

    on<ReturnBookClicked>((event, emit) async {
      emit(ReturnBookLoading());
      final body = {
        "book_id": event.bookId,
        "email": event.email,
        "issue_date": event.issueDate,
        "return_date": event.returnDate,
        "fine": event.fine
      };
      final result = await _getReturnBook(body);

      result.fold(
        (failure) {
          if (failure is ServerFailureWithMessage) {
            emit(ReturnBookFailed(failure.message));
          } else {
            emit(const ReturnBookFailed('Server Failed'));
          }
        },
        (response) => emit(ReturnBookSuccess(response.message)),
      );
    });
  }
}
