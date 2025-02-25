import 'package:equatable/equatable.dart';

class Tarea extends Equatable {
  final int idTarea;
  final int idUsuario;
  final int? idCategoria;
  final String titulo;
  final String? descripcion;
  final DateTime fechaCreacion;
  final DateTime? fechaVencimiento;
  final String estado;
  final String prioridad;

  const Tarea({
    required this.idTarea,
    required this.idUsuario,
    this.idCategoria,
    required this.titulo,
    this.descripcion,
    required this.fechaCreacion,
    this.fechaVencimiento,
    required this.estado,
    required this.prioridad,
  });

  // Constructor para crear un objeto Tarea desde un JSON
  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      idTarea: json['id_tarea'],
      idUsuario: json['id_usuario'],
      idCategoria: json['id_categoria'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      fechaCreacion: DateTime.parse(json['fecha_creacion']),
      fechaVencimiento: json['fecha_vencimiento'] != null
          ? DateTime.parse(json['fecha_vencimiento'])
          : null,
      estado: json['estado'],
      prioridad: json['prioridad'],
    );
  }

  // Método para convertir un objeto Tarea a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_tarea': idTarea,
      'id_usuario': idUsuario,
      'id_categoria': idCategoria,
      'titulo': titulo,
      'descripcion': descripcion,
      'fecha_creacion': fechaCreacion.toIso8601String(),
      'fecha_vencimiento': fechaVencimiento?.toIso8601String(),
      'estado': estado,
      'prioridad': prioridad,
    };
  }

  @override
  List<Object?> get props => [
    idTarea,
    idUsuario,
    idCategoria,
    titulo,
    descripcion,
    fechaCreacion,
    fechaVencimiento,
    estado,
    prioridad,
  ];
}
