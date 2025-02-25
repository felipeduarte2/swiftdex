import 'package:shared_preferences/shared_preferences.dart';
import '../services/tarea_service.dart';

class TareaRepository {
  final TareaService tareaService;

  TareaRepository({required this.tareaService});

  Future<Map<String, dynamic>> getTareas() async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data = await tareaService.getTareas(token);
      if (data['message'] != null) {
        return {'success': true, 'data': data['data']};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<Map<String, dynamic>> createTarea(Map<String, dynamic> tareaData) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data = await tareaService.createTarea(token, tareaData);
      if (data['message'] != null) {
        return {'success': true, 'message': data['message']};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<Map<String, dynamic>> updateTarea(int idTarea, Map<String, dynamic> tareaData) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data = await tareaService.updateTarea(token, idTarea, tareaData);
      if (data['message'] != null) {
        return {'success': true, 'message': data['message']};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<Map<String, dynamic>> deleteTarea(int idTarea) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data = await tareaService.deleteTarea(token, idTarea);
      if (data['message'] != null) {
        return {'success': true, 'message': data['message']};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
