import 'api_service.dart';

class RecordatoriosService {
  final ApiService apiService;

  RecordatoriosService({required this.apiService});

  Future<Map<String, dynamic>> getRecordatorios(String token) async {
    return await apiService.get('recordatorios', token: token);
  }

  Future<Map<String, dynamic>> createRecordatorio(String token, int idTarea, String fechaRecordatorio) async {
    return await apiService.post(
      'recordatorios',
      {'id_tarea': idTarea, 'fecha_recordatorio': fechaRecordatorio},
      token: token,
    );
  }

  Future<Map<String, dynamic>> updateRecordatorio(String token, int idRecordatorio, String fechaRecordatorio, bool activo) async {
    return await apiService.put(
      'recordatorios/$idRecordatorio',
      {'fecha_recordatorio': fechaRecordatorio, 'activo': activo},
      token: token,
    );
  }

  Future<Map<String, dynamic>> deleteRecordatorio(String token, int idRecordatorio) async {
    return await apiService.delete('recordatorios/$idRecordatorio', token: token);
  }
}
