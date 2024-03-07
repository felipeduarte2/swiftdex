import 'package:listgenius/src/screens/data_base/db_agenda.dart';
import 'package:sqflite/sqflite.dart';

class DetallesCRUD {
  Future<int> insertDetalle(Detalle detalle) async {
    Database database = await DatabaseHelper.instance.database;
    return await database.insert(DatabaseHelper.tableDetalles, detalle.toMap());
  }

  

  Future<List<Detalle>> getAllDetalles() async {
    Database database = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> detallesMap = await database.query(DatabaseHelper.tableDetalles);
    return detallesMap.map((detalle) => Detalle.fromMap(detalle)).toList();
  }

  Future<List<Detalle>> getAllDetallesById(int id) async {
    Database database = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> detallesMap = await database.query(
      DatabaseHelper.tableDetalles,
      where: '${DatabaseHelper.columnIdActividadDetalle} = ?',
      whereArgs: [id],
    );
    return detallesMap.map((detalle) => Detalle.fromMap(detalle)).toList();
  }

  Future<Detalle?> getDetalleById(int id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableDetalles,
      where: '${DatabaseHelper.columnIdActividadDetalle} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Detalle.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateDetalle(Detalle detalle) async {
    Database database = await DatabaseHelper.instance.database;
    return await database.update(DatabaseHelper.tableDetalles, detalle.toMap(), where: '${DatabaseHelper.columnIdDetalle} = ?', whereArgs: [detalle.idDetalle]);
  }

  Future<int> deleteDetalle(int idDetalle) async {
    Database database = await DatabaseHelper.instance.database;
    return await database.delete(DatabaseHelper.tableDetalles, where: '${DatabaseHelper.columnIdActividadDetalle} = ?', whereArgs: [idDetalle]);
  }
}

class Detalle {
  int? idDetalle;
  int idActividad;
  String detalle;
  String realizado;

  Detalle({
    this.idDetalle,
    required this.idActividad,
    required this.detalle,
    required this.realizado,
  });

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnIdDetalle: idDetalle,
      DatabaseHelper.columnIdActividadDetalle: idActividad,
      DatabaseHelper.columnDetalle: detalle,
      DatabaseHelper.columnRealizadoDetalle: realizado,
    };
  }

  factory Detalle.fromMap(Map<String, dynamic> map) {
    return Detalle(
      idDetalle: map[DatabaseHelper.columnIdDetalle],
      idActividad: map[DatabaseHelper.columnIdActividadDetalle],
      detalle: map[DatabaseHelper.columnDetalle],
      realizado: map[DatabaseHelper.columnRealizadoDetalle],
    );
  }
}