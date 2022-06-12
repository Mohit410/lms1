part of 'admin_list_bloc.dart';

abstract class AdminListState extends Equatable {
  const AdminListState();

  @override
  List<Object> get props => [];
}

class AdminListLoading extends AdminListState {}

class AdminListLoaded extends AdminListState {
  final List<UserModel> admins;
  const AdminListLoaded({required this.admins});

  @override
  List<Object> get props => [admins];
}

class EmptyAdmins extends AdminListState {}

class AdminListFailed extends AdminListState {
  final String message;
  const AdminListFailed({required this.message});

  @override
  List<Object> get props => [message];
}
