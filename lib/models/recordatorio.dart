import 'package:equatable/equatable.dart';

class Recordatorio extends Equatable {
  final int idRecordatorio;
  final int idTarea;
  final DateTime fechaRecordatorio;
  final bool activo;

  const Recordatorio({
    required this.idRecordatorio,
    required this.idTarea,
    required this.fechaRecordatorio,
    required this.activo,
  });

  // Constructor para crear un objeto Recordatorio desde un JSON
  factory Recordatorio.fromJson(Map<String, dynamic> json) {
    return Recordatorio(
      idRecordatorio: json['id_recordatorio'],
      idTarea: json['id_tarea'],
      fechaRecordatorio: DateTime.parse(json['fecha_recordatorio']),
      activo: json['activo'],
    );
  }

  // Método para convertir un objeto Recordatorio a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_recordatorio': idRecordatorio,
      'id_tarea': idTarea,
      'fecha_recordatorio': fechaRecordatorio.toIso8601String(),
      'activo': activo,
    };
  }

  @override
  List<Object?> get props => [idRecordatorio, idTarea, fechaRecordatorio, activo];
}
