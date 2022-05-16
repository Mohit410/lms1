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
  UserDetailBloc(this._getStudentDetails) : super(Empty()) {
    on<FetchData>((event, emit) async {
      emit(Loading());
      final result = await _getStudentDetails(event.email);

      result.fold(
        (failure) {
          if (failure is ServerFailureWithMessage) {
            emit(Failed(failure.message));
          } else {
            emit(const Failed('Server Failure'));
          }
        },
        (response) => emit(Loaded(
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
