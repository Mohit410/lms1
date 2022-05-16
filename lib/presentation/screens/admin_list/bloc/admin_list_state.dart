part of 'admin_list_bloc.dart';

abstract class AdminListState extends Equatable {
  const AdminListState();

  @override
  List<Object> get props => [];
}

class Loading extends AdminListState {}

class AdminsLoaded extends AdminListState {
  final List<UserModel> admins;
  const AdminsLoaded({required this.admins});

  @override
  List<Object> get props => [admins];
}

class EmptyAdmins extends AdminListState {}

class Failed extends AdminListState {
  final String message;
  const Failed({required this.message});

  @override
  List<Object> get props => [message];
}
