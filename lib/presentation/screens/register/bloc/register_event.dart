part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterClicked extends RegisterEvent {
  final UserModel userModel;

  RegisterClicked({required this.userModel});
}
