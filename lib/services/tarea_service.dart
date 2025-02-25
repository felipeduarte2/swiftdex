import 'api_service.dart';

class TareaService {
  final ApiService apiService;

  TareaService({required this.apiService});

  Future<Map<String, dynamic>> getTareas(String token) async {
    return await apiService.get('tareas', token: token);
  }

  Future<Map<String, dynamic>> createTarea(String token, Map<String, dynamic> tareaData) async {
    return await apiService.post(
      'tareas',
      tareaData,
      token: token,
    );
  }

  Future<Map<String, dynamic>> updateTarea(String token, int idTarea, Map<String, dynamic> tareaData) async {
    return await apiService.put(
      'tareas/$idTarea',
      tareaData,
      token: token,
    );
  }

  Future<Map<String, dynamic>> deleteTarea(String token, int idTarea) async {
    return await apiService.delete('tareas/$idTarea', token: token);
  }
}
