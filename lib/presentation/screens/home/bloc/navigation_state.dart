part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationInitial extends NavigationState {}

class Uploading extends NavigationState {}

class UploadSuccess extends NavigationState {
  final String message;

  const UploadSuccess(this.message);
}

class UploadFailed extends NavigationState {
  final String message;

  const UploadFailed(this.message);
}
