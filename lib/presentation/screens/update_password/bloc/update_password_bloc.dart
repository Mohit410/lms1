import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/domain/usecases/usecases.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc
    extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  final GetUpdatePassword _getUpdatePassword;
  UpdatePasswordBloc(this._getUpdatePassword) : super(UpdatePasswordInitial()) {
    on<UpdatePasswordClicked>((event, emit) async {
      
    });
  }
}
