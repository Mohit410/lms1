part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterClicked extends RegisterEvent {
  final RegisterUserModel userModel;

  RegisterClicked({required this.userModel});
}

class UpdateUserClicked extends RegisterEvent {
  final UserModel userModel;
  
  UpdateUserClicked({required this.userModel});
}

class BackButtonClicked extends RegisterEvent {}
