import 'package:shared_preferences/shared_preferences.dart';
import '../services/etiqueta_service.dart';

class EtiquetaRepository {
  final EtiquetaService etiquetaService;

  EtiquetaRepository({required this.etiquetaService});

  Future<Map<String, dynamic>> getEtiquetas() async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data = await etiquetaService.getEtiquetas(token);
      if (data['message'] != null) {
        return {'success': true, 'data': data['data']};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<Map<String, dynamic>> createEtiqueta(String nombreEtiqueta) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data = await etiquetaService.createEtiqueta(token, nombreEtiqueta);
      if (data['message'] != null) {
        return {'success': true, 'message': data['message']};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<Map<String, dynamic>> updateEtiqueta(int idEtiqueta, String nombreEtiqueta) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data = await etiquetaService.updateEtiqueta(token, idEtiqueta, nombreEtiqueta);
      if (data['message'] != null) {
        return {'success': true, 'message': data['message']};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<Map<String, dynamic>> deleteEtiqueta(int idEtiqueta) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data = await etiquetaService.deleteEtiqueta(token, idEtiqueta);
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
