import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/usecases/usecases.dart';

part 'add_new_book_event.dart';
part 'add_new_book_state.dart';

class AddNewBookBloc extends Bloc<AddNewBookEvent, AddNewBookState> {
  final GetAddBook _getAddBook;
  final GetUpdateBook _getUpdateBook;
  AddNewBookBloc(this._getAddBook, this._getUpdateBook)
      : super(AddNewBookInitial()) {
    on<AddNewBookClicked>((event, emit) async {
      emit(AddNewBookLoading());

      final result = await _getAddBook(event.book);

      result.fold(
        (failure) {
          if (failure is ServerFailureWithMessage) {
            emit(AddNewBookFailed(failure.message));
          } else {
            emit(const AddNewBookFailed('Server Error'));
          }
        },
        (response) => emit(AddNewBookSuccess(response.message)),
      );
    });

    on<UpdateBookClicked>((event, emit) async {
      emit(AddNewBookLoading());

      final result = await _getUpdateBook(event.book);

      result.fold(
        (failure) {
          if (failure is ServerFailureWithMessage) {
            emit(AddNewBookFailed(failure.message));
          } else {
            emit(const AddNewBookFailed('Server Error'));
          }
        },
        (response) => emit(AddNewBookSuccess(response.message)),
      );
    });
  }
}
