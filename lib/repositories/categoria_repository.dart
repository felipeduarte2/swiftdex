import 'package:shared_preferences/shared_preferences.dart';
import '../services/categoria_service.dart';

class CategoriaRepository {
  final CategoriaService categoriaService;

  CategoriaRepository({required this.categoriaService});

  Future<Map<String, dynamic>> getCategorias() async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data = await categoriaService.getCategorias(token);
      if (data['message'] != null) {
        return {'success': true, 'data': data['data']};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<Map<String, dynamic>> createCategoria(String nombreCategoria) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data = await categoriaService.createCategoria(token, nombreCategoria);
      if (data['message'] != null) {
        return {'success': true, 'message': 'Categoría creada exitosamente'};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<Map<String, dynamic>> updateCategoria(int idCategoria, String nombreCategoria) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data = await categoriaService.updateCategoria(token, idCategoria, nombreCategoria);
      if (data['message'] != null) {
        return {'success': true, 'message': 'Categoría actualizada exitosamente'};
      }else{
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error al conectar con el servidor'};
    }
  }

  Future<Map<String, dynamic>> deleteCategoria(int idCategoria) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'error': 'Usuario no autenticado'};
      }
      final data = await categoriaService.deleteCategoria(token, idCategoria);
      if (data['message'] != null) {
        return {'success': true, 'message': 'Categoría eliminada exitosamente'};
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
