part of 'update_password_bloc.dart';

abstract class UpdatePasswordEvent extends Equatable {
  const UpdatePasswordEvent();

  @override
  List<Object> get props => [];
}

class UpdatePasswordClicked extends UpdatePasswordEvent {
  final String email;
  final String role;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const UpdatePasswordClicked({
    required this.email,
    required this.role,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [email, role, oldPassword, newPassword, confirmPassword];
}
