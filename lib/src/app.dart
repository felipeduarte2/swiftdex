import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/signup/signup_bloc.dart';
import '../repositories/auth_repository.dart';
import 'package:listgenius/ui/screens/dashboard_screen.dart';
import 'package:listgenius/ui/screens/login_screen.dart';

import '../ui/screens/signup_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AuthRepository authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: '/login',
      routes: {
        '/login': (context) => BlocProvider(
          create: (context) => AuthBloc(authRepository: authRepository),
          child: const LoginScreen(),
        ),
        '/signup': (context) => BlocProvider(
          create: (context) => SignupBloc(authRepository: authRepository),
          child: const SignupScreen(),
        ),
        '/dashboard': (context) => const DashboardScreen(),
      },
    );
  }
}