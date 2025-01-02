import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class AuthRepository {
  final ApiService apiService = ApiService();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final data = await apiService.login(email, password);

      if (data['token'] != null) {
        // Guardar el token en local
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', data['token']);

        return {'success': true, 'message':'Inicio de sesión exitoso '};
      }
      else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }
  // Método para registrar un nuevo usuario
  Future<Map<String, dynamic>> signup(String nombre, String email, String password) async {
    try{
      final data = await apiService.signup(nombre,email, password);
      if (data['message'] != null) {
        return {'success': true, 'message':'Inicio de sesión exitoso '};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<Map<String, dynamic>> updateUser(String nombre, String email, String password) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Token no encontrado. Por favor, inicia sesión nuevamente.'};
      }
      final data = await apiService.updateUser(token, nombre, email, password);
      if (data['message'] != null) {
        return {'success': true, 'message': 'Usuario actualizado exitosamente'};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<Map<String, dynamic>> deleteUser(int id) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Token no encontrado. Por favor, inicia sesión nuevamente.'};
      }

      final data = await apiService.deleteUser(token, id);
      if (data['message'] != null) {
        await logout();
        return {'success': true, 'message': 'Usuario eliminado exitosamente'};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}