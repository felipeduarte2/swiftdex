import 'package:equatable/equatable.dart';

class TareaEtiqueta extends Equatable {
  final int idTarea;
  final int idEtiqueta;

  const TareaEtiqueta({
    required this.idTarea,
    required this.idEtiqueta,
  });

  // Constructor para crear un objeto TareaEtiqueta desde un JSON
  factory TareaEtiqueta.fromJson(Map<String, dynamic> json) {
    return TareaEtiqueta(
      idTarea: json['id_tarea'],
      idEtiqueta: json['id_etiqueta'],
    );
  }

  // Método para convertir un objeto TareaEtiqueta a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_tarea': idTarea,
      'id_etiqueta': idEtiqueta,
    };
  }

  @override
  List<Object?> get props => [idTarea, idEtiqueta];
}
