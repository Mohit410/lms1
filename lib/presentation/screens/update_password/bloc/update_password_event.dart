part of 'update_password_bloc.dart';

abstract class UpdatePasswordEvent extends Equatable {
  const UpdatePasswordEvent();

  @override
  List<Object> get props => [];
}

class UpdatePasswordClicked extends UpdatePasswordEvent {
  final String oldPassword;
  final String newPassword;

  const UpdatePasswordClicked(this.oldPassword, this.newPassword);
}
