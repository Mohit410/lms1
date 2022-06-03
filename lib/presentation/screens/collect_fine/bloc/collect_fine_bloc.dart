import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/data/models/fine_details_response.dart';
import 'package:lms1/data/models/user_detail_response.dart';
import 'package:lms1/domain/usecases/usecases.dart';

part 'collect_fine_event.dart';
part 'collect_fine_state.dart';

class CollectFineBloc extends Bloc<CollectFineEvent, CollectFineState> {
  final GetFineDetails _getFineDetails;
  final GetPayFine _getPayFine;
  CollectFineBloc(this._getFineDetails, this._getPayFine)
      : super(CollectFineInitial()) {
    on<FetchFineDetails>((event, emit) async {
      emit(CollectFineLoading());
      final result = await _getFineDetails(event.email);

      result.fold(
        (failure) {
          if (failure is ServerFailureWithMessage) {
            emit(CollectFineFailed(failure.message));
          } else {
            emit(const CollectFineFailed('Server Failed'));
          }
        },
        (response) =>
            emit(FineDetailsLoaded(response.fineData, response.fineHistory)),
      );
    });

    on<CollectFineClicked>((event, emit) async {
      emit(CollectFineLoading());
      final body = {
        "email": event.email,
        "book_id": event.bookId,
        "amount": int.parse(event.amount),
        "purpose": event.purpose,
      };
      final result = await _getPayFine(body);

      result.fold(
        (failure) {
          if (failure is ServerFailureWithMessage) {
            emit(CollectFineFailed(failure.message));
          } else {
            emit(const CollectFineFailed('Server Failed'));
          }
        },
        (response) => emit(CollectFineSuccess(response.message)),
      );
    });
  }
}
