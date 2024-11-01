import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/auth_repository.dart';

// Eventos
abstract class AuthEvent {}
class EmailChanged extends AuthEvent {
  final String email;
  EmailChanged(this.email);
}
class PasswordChanged extends AuthEvent {
  final String password;
  PasswordChanged(this.password);
}
class LoginSubmitted extends AuthEvent {}

// Estados
abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {}
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  String _email = '';
  String _password = '';

  AuthBloc(this.authRepository) : super(AuthInitial());

  //@override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is EmailChanged) {
      _email = event.email;
    } else if (event is PasswordChanged) {
      _password = event.password;
    } else if (event is LoginSubmitted) {
      yield AuthLoading();
      try {
        await authRepository.login(_email, _password);
        yield AuthSuccess();
      } catch (e) {
        yield AuthFailure(e.toString());
      }
    }
  }
}
