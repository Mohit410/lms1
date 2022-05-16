part of 'user_detail_bloc.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchData extends UserDetailEvent {
  final String email;
  final String role;

  const FetchData({required this.email,required this.role});
  
}
