import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/core/error/failure.dart';

import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/usecases/usecases.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetAdminDashboard _getAdminDashboard;
  DashboardBloc(
    this._getAdminDashboard,
  ) : super(Empty()) {
    on<FetchData>((event, emit) async {
      emit(Loading());
      final result = await _getAdminDashboard(NoParams());
      result.fold(
        (failure) {
          if (failure is ServerFailureWithMessage) {
            emit(Failed(message: failure.message));
          } else {
            emit(const Failed(message: 'Server Failed'));
          }
        },
        (response) => emit(Loaded(
          totalUsers: response.totalUsers,
          totalFine: response.totalFineCollection,
          totalBooks: response.totalBooks,
          user: response.adminData,
        )),
      );
    });
  }
}
