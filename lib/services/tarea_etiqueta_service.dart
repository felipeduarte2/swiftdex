import 'api_service.dart';

class TareaEtiquetaService {
  final ApiService apiService;

  TareaEtiquetaService({required this.apiService});

  Future<Map<String, dynamic>> getTareaEtiquetas(String token) async {
    return await apiService.get('tarea_etiqueta', token: token);
  }

  Future<Map<String, dynamic>> createTareaEtiqueta(String token, int idTarea, int idEtiqueta) async {
    return await apiService.post(
      'tarea_etiqueta',
      {'id_tarea': idTarea, 'id_etiqueta': idEtiqueta},
      token: token,
    );
  }

  Future<Map<String, dynamic>> deleteTareaEtiqueta(String token, int idTarea, int idEtiqueta) async {
    return await apiService.delete('tarea_etiqueta/$idTarea/$idEtiqueta', token: token);
  }
}
