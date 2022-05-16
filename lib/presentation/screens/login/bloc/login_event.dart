part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {}

class LoginClicked extends LoginEvent {
  final String email;
  final String password;

  LoginClicked({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class BackButtonClicked extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class PreLoginSuccess extends LoginEvent {
  final String message;

  PreLoginSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
