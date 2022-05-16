part of 'update_password_bloc.dart';

abstract class UpdatePasswordState extends Equatable {
  const UpdatePasswordState();

  @override
  List<Object> get props => [];
}

class UpdatePasswordInitial extends UpdatePasswordState {}

class PasswordUpdateLoading extends UpdatePasswordState {}

class PasswordUpdateSucsess extends UpdatePasswordState {
  final String message;

  const PasswordUpdateSucsess(this.message);
}

class PasswordUpdateFailed extends UpdatePasswordState {
  final String message;

  const PasswordUpdateFailed(this.message);
}
