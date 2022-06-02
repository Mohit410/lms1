part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardLoaded extends DashboardState {
  final DashboardResponse dashboardData;
  const DashboardLoaded({required this.dashboardData});

  @override
  List<Object> get props => [dashboardData];
}

class DashboardFailed extends DashboardState {
  final String message;
  const DashboardFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class DashboardEmpty extends DashboardState {}

class DashboardLoading extends DashboardState {}

class LogoutLoading extends DashboardState {}

class LogoutSuccess extends DashboardState {}
