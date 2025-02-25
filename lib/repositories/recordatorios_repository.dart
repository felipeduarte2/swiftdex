import 'package:shared_preferences/shared_preferences.dart';
import '../services/recordatorios_service.dart';

class RecordatoriosRepository {
  final RecordatoriosService recordatoriosService;

  RecordatoriosRepository({required this.recordatoriosService});

  Future<Map<String, dynamic>> getRecordatorios() async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data = await recordatoriosService.getRecordatorios(token);
      if (data['message'] != null) {
        return {'success': true, 'data': data['data']};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<Map<String, dynamic>> createRecordatorio(int idTarea, String fechaRecordatorio) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data = await recordatoriosService.createRecordatorio(token, idTarea, fechaRecordatorio);
      if (data['message'] != null) {
        return {'success': true, 'message': data['message']};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<Map<String, dynamic>> updateRecordatorio(int idRecordatorio, String fechaRecordatorio, bool activo) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }

      final data = await recordatoriosService.updateRecordatorio(token, idRecordatorio, fechaRecordatorio, activo);
      if (data['message'] != null) {
        return {'success': true, 'message': data['message']};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<Map<String, dynamic>> deleteRecordatorio(int idRecordatorio) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data = await recordatoriosService.deleteRecordatorio(token, idRecordatorio);
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
