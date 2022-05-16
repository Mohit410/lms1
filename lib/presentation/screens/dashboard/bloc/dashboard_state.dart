part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class Loaded extends DashboardState {
  final UserModel user;
  final int totalUsers;
  final int totalFine;
  final int totalBooks;
  const Loaded({
    required this.totalUsers,
    required this.totalFine,
    required this.totalBooks,
    required this.user,
  });
}

class Failed extends DashboardState {
  final String message;
  const Failed({required this.message});
}

class Empty extends DashboardState {}

class Loading extends DashboardState {}
