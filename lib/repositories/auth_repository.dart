import '../services/api_service.dart';

class AuthRepository {
  final ApiService apiService = ApiService();

  Future<void> login(String email, String password) async {
    try {
      final data = await apiService.login(email, password);

      if (data['token'] == null) {
        throw Exception('Inicio de sesión fallido');
      }
      // Aquí podrías almacenar el token en local si fuera necesario
    } catch (e) {
      throw Exception('Error de autenticación: $e');
    }
  }
}

