part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class UploadBulkUsers extends NavigationEvent {
  final PlatformFile file;

  const UploadBulkUsers(this.file);

  @override
  List<Object> get props => [file];
}

class UploadBulkBooks extends NavigationEvent {
  final PlatformFile file;

  const UploadBulkBooks(this.file);

  @override
  List<Object> get props => [file];


}
