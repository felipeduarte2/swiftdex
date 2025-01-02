import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con formas
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3A7BD5), Color(0xFF00D2FF)], // Degradado azul
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Contenido principal
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.pushNamedAndRemoveUntil(context, '/dashboard',(Route<dynamic> route) => false,);
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator();
                  }

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Bienvenido a SwiftDex",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10.0,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              TextField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Correo electrónico',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: Icon(isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                obscureText: !isPasswordVisible,
                              ),
                              const SizedBox(height: 16.0),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF3A7BD5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 12),
                                ),
                                onPressed: () {
                                  final email = emailController.text;
                                  final password = passwordController.text;

                                  BlocProvider.of<AuthBloc>(context).add(
                                    LoginRequested(
                                        email: email, password: password),
                                  );
                                },
                                child: const Text(
                                  'Iniciar Sesión',
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(context, '/signup',(Route<dynamic> route) => false,);
                                },
                                child: const Text(
                                  '¿No tienes cuenta? Crear una cuenta',
                                  style: TextStyle(color: Color(0xFF3A7BD5)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
