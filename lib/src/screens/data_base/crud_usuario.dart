// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:sqflite/sqflite.dart';
import 'package:listgenius/src/screens/data_base/db_usuario.dart';

class UsuarioCRUD{

  Future<int> insertUser(User user) async {
    Database database = await DatabaseHelper.instance.database;
    return await database.insert(DatabaseHelper.tableUsers, user.toMap());
  }

  Future<User?> getUserById(int id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableUsers,
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateUser(User user) async {
    Database database = await DatabaseHelper.instance.database;
    return await database.update(DatabaseHelper.tableUsers, user.toMap(), 
    where: '${DatabaseHelper.columnId} = ?', 
    whereArgs: [user.id]);
  }

  Future<int> deleteUser(int id) async {
    Database database = await DatabaseHelper.instance.database;
    return await database.delete(DatabaseHelper.tableUsers, 
    where: '${DatabaseHelper.columnId} = ?', 
    whereArgs: [id]);
  }

}

class User {
  int? id;
  String nombre;
  String usuario;
  Blob imagen;
  User({
    this.id,
    required this.nombre, 
    required this.usuario, 
    required this.imagen,
  });

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId : id,
      DatabaseHelper.columnNombre : nombre,
      DatabaseHelper.columnUsuario : usuario,
      DatabaseHelper.columnImagen : imagen,
    };
  }

   factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map[DatabaseHelper.columnId],
      nombre: map[DatabaseHelper.columnNombre],
      usuario: map[DatabaseHelper.columnUsuario],
      imagen: map[DatabaseHelper.columnImagen],
    );
  }
}