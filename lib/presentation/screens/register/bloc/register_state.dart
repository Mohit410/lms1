part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String message;

  RegisterSuccess(this.message);
}

class RegisterFailed extends RegisterState {
  final String message;

  RegisterFailed(this.message);
}
