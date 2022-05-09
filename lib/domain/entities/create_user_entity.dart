import 'package:equatable/equatable.dart';

class CreateUserEntity extends Equatable {
  final String success;
  final String message;

  const CreateUserEntity({
    required this.success,
    required this.message,
  });

  @override
  List<Object?> get props => [success, message];
}
