import 'api_service.dart';

class UsuarioService{

  final ApiService apiService;

  UsuarioService({required this.apiService});

  Future<Map<String, dynamic>> login(String email, String password) async {
    return await apiService.post(
      'usuarios/login',
      {'email': email,
        'password': password,},
    );
  }

  Future<Map<String, dynamic>> signup(String nombre, String email, String password) async {
    return await apiService.post(
      'usuarios/signup',
      {'nombre': nombre,
        'email': email,
        'password': password,},
    );
  }

  Future<Map<String, dynamic>> updateUser(String token, String nombre, String email, String password) async {
    return await apiService.put(
      'usuarios',
      {'nombre': nombre,
        'email': email,
        'password': password},
      token: token,
    );
  }

  Future<Map<String, dynamic>> deleteUser(String token) async {
    return await apiService.delete('usuarios', token: token);

  }


}