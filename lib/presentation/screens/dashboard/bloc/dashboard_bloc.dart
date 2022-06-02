import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/core/error/failure.dart';

import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/usecases/usecases.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetAdminDashboard _getAdminDashboard;
  final GetLibrarianDashBoard _getLibrarianDashBoard;
  final GetStudentDashboard _getStudentDashboard;
  DashboardBloc(
    this._getAdminDashboard,
    this._getLibrarianDashBoard,
    this._getStudentDashboard,
  ) : super(DashboardEmpty()) {
    on<FetchDashboardData>((event, emit) async {
      emit(DashboardLoading());
      late Either<Failure, DashboardResponse> result;
      if (UserPreferences.userRole == Role.admin.name) {
        result = await _getAdminDashboard(NoParams());
      } else if (UserPreferences.userRole == Role.librarian.name) {
        result = await _getLibrarianDashBoard(NoParams());
      } else if (UserPreferences.userRole == Role.student.name) {
        result = await _getStudentDashboard(NoParams());
      }
      result.fold((failure) {
        if (failure is ServerFailureWithMessage) {
          emit(DashboardFailed(message: failure.message));
        } else {
          emit(const DashboardFailed(message: 'Server Failed'));
        }
      }, (response) {
        emit(DashboardLoaded(dashboardData: response));
      });
    });

    on<LogOutClicked>((event, emit) async {
      emit(LogoutLoading());

      await UserPreferences.clearPreferences();

      emit(LogoutSuccess());
    });
  }
}
