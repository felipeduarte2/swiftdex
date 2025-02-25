import 'package:equatable/equatable.dart';

class Historial extends Equatable {
  final int idHistorial;
  final int idTarea;
  final String cambioDescripcion;
  final DateTime fechaCambio;

  const Historial({
    required this.idHistorial,
    required this.idTarea,
    required this.cambioDescripcion,
    required this.fechaCambio,
  });

  // Constructor para crear un objeto Historial desde un JSON
  factory Historial.fromJson(Map<String, dynamic> json) {
    return Historial(
      idHistorial: json['id_historial'],
      idTarea: json['id_tarea'],
      cambioDescripcion: json['cambio_descripcion'],
      fechaCambio: DateTime.parse(json['fecha_cambio']),
    );
  }

  // Método para convertir un objeto Historial a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_historial': idHistorial,
      'id_tarea': idTarea,
      'cambio_descripcion': cambioDescripcion,
      'fecha_cambio': fechaCambio.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [idHistorial, idTarea, cambioDescripcion, fechaCambio];
}
