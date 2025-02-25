import 'api_service.dart';

class HistorialService {
  final ApiService apiService;

  HistorialService({required this.apiService});

  Future<Map<String, dynamic>> getHistorialByTarea(String token, int idTarea) async {
    return await apiService.get('historial/tarea/$idTarea', token: token);
  }

  Future<Map<String, dynamic>> getHistorialCompleto(String token) async {
    return await apiService.get('historial', token: token);
  }
}
