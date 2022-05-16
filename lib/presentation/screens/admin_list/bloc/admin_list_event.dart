part of 'admin_list_bloc.dart';

abstract class AdminListEvent extends Equatable {
  const AdminListEvent();

  @override
  List<Object> get props => [];
}

class FetchAdminList extends AdminListEvent {}
