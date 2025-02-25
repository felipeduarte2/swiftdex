import 'package:equatable/equatable.dart';

class Etiqueta extends Equatable {
  final int idEtiqueta;
  final int idUsuario;
  final String nombreEtiqueta;

  const Etiqueta({
    required this.idEtiqueta,
    required this.idUsuario,
    required this.nombreEtiqueta,
  });

  // Constructor para crear un objeto Etiqueta desde un JSON
  factory Etiqueta.fromJson(Map<String, dynamic> json) {
    return Etiqueta(
      idEtiqueta: json['id_etiqueta'],
      idUsuario: json['id_usuario'],
      nombreEtiqueta: json['nombre_etiqueta'],
    );
  }

  // Método para convertir un objeto Etiqueta a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_etiqueta': idEtiqueta,
      'id_usuario': idUsuario,
      'nombre_etiqueta': nombreEtiqueta,
    };
  }

  @override
  List<Object?> get props => [idEtiqueta, idUsuario, nombreEtiqueta];
}
