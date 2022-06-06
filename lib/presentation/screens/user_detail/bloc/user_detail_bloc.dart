import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/data/models/user_detail_response.dart';
import 'package:lms1/domain/usecases/usecases.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final GetStudentDetails _getStudentDetails;
  UserDetailBloc(this._getStudentDetails) : super(UserDetailsEmpty()) {
    on<FetchData>((event, emit) async {
      emit(UserDetailsLoading());
      final result = await _getStudentDetails(event.email);

      result.fold(
        (failure) {
          if (failure is ServerFailureWithMessage) {
            emit(UserDetailsFailed(failure.message));
          } else {
            emit(const UserDetailsFailed('Server Failure'));
          }
        },
        (response) => emit(UserDetailsLoaded(
          issuedBooks: response.issuedBooks,
          totalFine: response.totalFine,
          transactions: response.transactions,
          user: response.user,
          fineHistory: response.fineHistory,
        )),
      );
    });
  }
}
