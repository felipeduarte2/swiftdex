import 'api_service.dart';

class EtiquetaService {
  final ApiService apiService;

  EtiquetaService({required this.apiService});

  Future<Map<String, dynamic>> getEtiquetas(String token) async {
    return await apiService.get('etiquetas', token: token);
  }

  Future<Map<String, dynamic>> createEtiqueta(String token, String nombreEtiqueta) async {
    return await apiService.post(
      'etiquetas',
      {'nombre': nombreEtiqueta},
      token: token,
    );
  }

  Future<Map<String, dynamic>> updateEtiqueta(String token, int idEtiqueta, String nombreEtiqueta) async {
    return await apiService.put(
      'etiquetas/$idEtiqueta',
      {'nombre': nombreEtiqueta},
      token: token,
    );
  }

  Future<Map<String, dynamic>> deleteEtiqueta(String token, int idEtiqueta) async {
    return await apiService.delete('etiquetas/$idEtiqueta', token: token);
  }
}
