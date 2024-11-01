import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_';
import '../../blocs/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Correo Electrónico'),
              onChanged: (value) => authBloc.add(EmailChanged(value)),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
              onChanged: (value) => authBloc.add(PasswordChanged(value)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => authBloc.add(LoginSubmitted()),
              child: const Text('Iniciar Sesión'),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthFailure) {
                  return Text(state.message, style: const TextStyle(color: Colors.red));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
