import 'api_service.dart';

class CategoriaService {
  final ApiService apiService;

  CategoriaService({required this.apiService});

  Future<Map<String, dynamic>> getCategorias(String token) async {
    return await apiService.get('categorias', token: token);
  }

  Future<Map<String, dynamic>> createCategoria(String token, String nombreCategoria) async {
    return await apiService.post(
      'categorias',
      {'nombre': nombreCategoria},
      token: token,
    );
  }

  Future<Map<String, dynamic>> updateCategoria(String token, int idCategoria, String nombreCategoria) async {
    return await apiService.put(
      'categorias/$idCategoria',
      {'nombre': nombreCategoria},
      token: token,
    );
  }

  Future<Map<String, dynamic>> deleteCategoria(String token, int idCategoria) async {
    return await apiService.delete('categorias/$idCategoria', token: token);
  }
}
