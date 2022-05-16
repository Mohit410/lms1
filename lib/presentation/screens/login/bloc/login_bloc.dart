import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/core/utils/user_preferences.dart';
import 'package:lms1/data/models/login_body.dart';
import 'package:lms1/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetLogin _getLogin;
  LoginBloc(
    this._getLogin,
  ) : super(LoginInitial()) {
    on<LoginClicked>((event, emit) async {
      emit(LoginLoading());
      final result = await _getLogin(
          LoginBody(email: event.email, password: event.password));
      result.fold(
        (failure) {
          if (failure is ServerFailureWithMessage) {
            emit(LoginFailed(failure.message));
          } else if (failure is ServerFailure) {
            emit(LoginFailed('Server Error'));
          }
        },
        (response) => handleResponse(response, emit),
      );
    });

    on<PreLoginSuccess>(
      (event, emit) {
        emit(LoginSuccess(event.message));
      },
    );

    on<BackButtonClicked>((event, emit) async {
      emit(LoginInitial());
    });
  }

  Future handleResponse(LoginResponse response, dynamic emit) async {
    if (response.success) {
      await saveDetailsInPreferences(response.token, response.role);
      add(PreLoginSuccess(response.message));
    } else {
      emit(LoginFailed(response.message));
    }
  }

  Future saveDetailsInPreferences(String token, String role) async {
    await UserPreferences.setUserToken(token);
    await UserPreferences.setUserRole(role);
  }
}
