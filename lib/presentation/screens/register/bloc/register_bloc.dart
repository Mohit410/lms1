import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/data/models/user_model.dart';
import 'package:lms1/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final CreateUser createUser;
  RegisterBloc(this.createUser) : super(RegisterInitial()) {
    on<RegisterClicked>(
      (event, emit) async {
        emit(RegisterLoading());
        final result = await createUser(event.userModel);
        result.fold(
          (failure) => emit(RegisterFailed('Server Failure')),
          (response) => emit(response.success
              ? RegisterSuccess(response.message)
              : RegisterFailed(response.message)),
        );
      },
    );
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
