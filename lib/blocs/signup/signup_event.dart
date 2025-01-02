part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupRequested extends SignupEvent {
  final String nombre;
  final String email;
  final String password;
  final String confirmPassword;

  SignupRequested({
    required this.nombre,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [nombre, email, password, confirmPassword];
}
