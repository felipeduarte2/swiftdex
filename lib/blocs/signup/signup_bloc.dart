import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/auth_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository _authRepository;

  SignupBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignupInitial()) {
    on<SignupRequested>(_onSignupRequested);
  }

  Future<void> _onSignupRequested(SignupRequested event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    if (event.password != event.confirmPassword) {
      emit(SignupFailure("Las contraseñas no coinciden"));
      return;
    }
    final response = await _authRepository.signup(event.nombre, event.email, event.password);
    if (response['success']) {
      emit(SignupSuccess());
    } else {
      emit(SignupFailure(response['error']));
    }
  }

  /*SignupBloc(this.authRepository) : super(SignupInitial()) {
    on<SignupRequested>((event, emit) async {
      emit(SignupLoading());
      try {
        if (event.password != event.confirmPassword) {
          emit(SignupFailure(error: "Las contraseñas no coinciden."));
          return;
        }
        final success = await authRepository.signup(event.email, event.password);
        if (success) {
          emit(SignupSuccess());
        } else {
          emit(SignupFailure(error: "No se pudo completar el registro."));
        }
      } catch (e) {
        emit(SignupFailure(error: e.toString()));
      }
    });
  }*/
}
