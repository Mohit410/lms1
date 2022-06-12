import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final CreateUser createUser;
  final GetUpdateUser updateUser;
  RegisterBloc(this.createUser, this.updateUser) : super(RegisterInitial()) {
    on<RegisterClicked>(
      (event, emit) async {
        emit(RegisterLoading());
        final result = await createUser(event.userModel);
        result.fold(
          (failure) {
            if (failure is ServerFailureWithMessage) {
              emit(RegisterFailed(failure.message));
            } else {
              emit(RegisterFailed('Server Failure'));
            }
          },
          (response) => emit(RegisterSuccess(response.message)),
        );
      },
    );

    on<UpdateUserClicked>((event, emit) async {
      emit(RegisterLoading());
      final result = await updateUser(event.userModel);

      result.fold((failure) {
        if (failure is ServerFailureWithMessage) {
          emit(RegisterFailed(failure.message));
        } else {
          emit(RegisterFailed('Server Failure'));
        }
      }, (response) => emit(RegisterSuccess(response.message)));
    });
  }
}
