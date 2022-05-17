import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/usecases/usecases.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc
    extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  final GetUpdatePassword _getUpdatePassword;
  UpdatePasswordBloc(this._getUpdatePassword) : super(UpdatePasswordInitial()) {
    on<UpdatePasswordClicked>((event, emit) async {
      emit(PasswordUpdateLoading());
      final result = await _getUpdatePassword(UpdatePasswordBody(
          email: event.email,
          role: event.role,
          newPassword: event.newPassword,
          currentPassword: event.oldPassword,
          confirmPassword: event.confirmPassword));

      result.fold((failure) {
        if (failure is ServerFailureWithMessage) {
          emit(PasswordUpdateFailed(failure.message));
        } else {
          emit(const PasswordUpdateFailed('Server Error'));
        }
      }, (response) => emit(PasswordUpdateSucsess(response.message)));
    });
  }
}
