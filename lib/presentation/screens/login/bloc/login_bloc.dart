import 'package:bloc/bloc.dart';
import 'package:lms1/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetLogin getLogin;
  LoginBloc({
    required this.getLogin,
  }) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
