import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final int idUsuario;
  final String nombre;
  final String email;
  final String contrasena;
  final DateTime? fechaRegistro;
  final DateTime? ultimaSesion;

  const Usuario({
    required this.idUsuario,
    required this.nombre,
    required this.email,
    required this.contrasena,
    this.fechaRegistro,
    this.ultimaSesion,
  });

  // Constructor para crear un objeto Usuario desde un JSON
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      idUsuario: json['id_usuario'],
      nombre: json['nombre'],
      email: json['email'],
      contrasena: json['contrasena'],
      fechaRegistro: json['fecha_registro'] != null
          ? DateTime.parse(json['fecha_registro'])
          : null,
      ultimaSesion: json['ultima_sesion'] != null
          ? DateTime.parse(json['ultima_sesion'])
          : null,
    );
  }

  // Método para convertir un objeto Usuario a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_usuario': idUsuario,
      'nombre': nombre,
      'email': email,
      'contrasena': contrasena,
      'fecha_registro': fechaRegistro?.toIso8601String(),
      'ultima_sesion': ultimaSesion?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    idUsuario,
    nombre,
    email,
    contrasena,
    fechaRegistro,
    ultimaSesion,
  ];
}
