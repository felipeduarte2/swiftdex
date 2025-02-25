import 'package:equatable/equatable.dart';

class Categoria extends Equatable {
  final int idCategoria;
  final int idUsuario;
  final String nombreCategoria;

  const Categoria({
    required this.idCategoria,
    required this.idUsuario,
    required this.nombreCategoria,
  });

  // Constructor para crear un objeto Categoria desde un JSON
  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      idCategoria: json['id_categoria'],
      idUsuario: json['id_usuario'],
      nombreCategoria: json['nombre_categoria'],
    );
  }

  // Método para convertir un objeto Categoria a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_categoria': idCategoria,
      'id_usuario': idUsuario,
      'nombre_categoria': nombreCategoria,
    };
  }

  @override
  List<Object?> get props => [
    idCategoria,
    idUsuario,
    nombreCategoria,
  ];
}
