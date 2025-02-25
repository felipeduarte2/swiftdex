import 'package:shared_preferences/shared_preferences.dart';
import '../services/tarea_etiqueta_service.dart';

class TareaEtiquetaRepository {
  final TareaEtiquetaService tareaEtiquetaService;

  TareaEtiquetaRepository({required this.tareaEtiquetaService});

  Future<Map<String, dynamic>> getTareaEtiquetas() async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data =  await tareaEtiquetaService.getTareaEtiquetas(token);
      if (data['message'] != null) {
        return {'success': true, 'data': data['data']};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<Map<String, dynamic>> createTareaEtiqueta(int idTarea, int idEtiqueta) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data =  await tareaEtiquetaService.createTareaEtiqueta(token, idTarea, idEtiqueta);
      if (data['message'] != null) {
        return {'success': true, 'message': data['message']};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<Map<String, dynamic>> deleteTareaEtiqueta(int idTarea, int idEtiqueta) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data =  await tareaEtiquetaService.deleteTareaEtiqueta(token, idTarea, idEtiqueta);
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
