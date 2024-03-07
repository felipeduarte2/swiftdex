import 'package:listgenius/src/screens/data_base/db_agenda.dart';
import 'package:sqflite/sqflite.dart';

class ActividadesCRUD {
  
  Future<int> insertActividad(Actividad actividad) async {
    Database database = await DatabaseHelper.instance.database;
    return await database.insert(DatabaseHelper.tableActividades, actividad.toMap());
  }

  Future<List<Actividad>> getAllActividades() async {
    Database database = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> actividadesMap = await database.query(DatabaseHelper.tableActividades);
    return actividadesMap.map((actividad) => Actividad.fromMap(actividad)).toList();
  }

  Future<Actividad?> getActividadById(int id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableActividades,
      where: '${DatabaseHelper.columnIdActividad} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Actividad.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateActividad(Actividad actividad) async {
    Database database = await DatabaseHelper.instance.database;
    return await database.update(DatabaseHelper.tableActividades, actividad.toMap(), where: '${DatabaseHelper.columnIdActividad} = ?', whereArgs: [actividad.idActividad]);
  }

  Future<int> deleteActividad(int idActividad) async {
    Database database = await DatabaseHelper.instance.database;
    return await database.delete(DatabaseHelper.tableActividades, where: '${DatabaseHelper.columnIdActividad} = ?', whereArgs: [idActividad]);
  }
}

class Actividad {
  int? idActividad;
  String categoria;
  String titulo;
  // String descripcion;
  String nivelDeImportancia;
  String realizado;
  String fecha;
  String hora;
  String lugar;
  String horario1;
  String horario2;
  int color;

  Actividad({
    this.idActividad,
    required this.categoria,
    required this.titulo,
    // required this.descripcion,
    required this.nivelDeImportancia,
    required this.realizado,
    this.fecha = '',
    this.hora = '',
    this.lugar = '',
    this.horario1 = '',
    this.horario2 = '',
    this.color = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnIdActividad: idActividad,
      DatabaseHelper.columnCategoria: categoria,
      DatabaseHelper.columnTitulo: titulo,
      // DatabaseHelper.columnDescripcion: descripcion,
      DatabaseHelper.columnNivelDeImportancia: nivelDeImportancia,
      DatabaseHelper.columnRealizado: realizado,
      DatabaseHelper.columnFecha: fecha,
      DatabaseHelper.columnHora: hora,
      DatabaseHelper.columnLugar: lugar,
      DatabaseHelper.columnHorario1: horario1,
      DatabaseHelper.columnHorario2: horario2,
      DatabaseHelper.columnColor: color,
    };
  }

  factory Actividad.fromMap(Map<String, dynamic> map) {
    return Actividad(
      idActividad: map[DatabaseHelper.columnIdActividad],
      categoria: map[DatabaseHelper.columnCategoria],
      titulo: map[DatabaseHelper.columnTitulo],
      // descripcion: map[DatabaseHelper.columnDescripcion],
      nivelDeImportancia: map[DatabaseHelper.columnNivelDeImportancia],
      realizado: map[DatabaseHelper.columnRealizado],
      fecha: map[DatabaseHelper.columnFecha],
      hora: map[DatabaseHelper.columnHora],
      lugar: map[DatabaseHelper.columnLugar],
      horario1: map[DatabaseHelper.columnHorario1],
      horario2: map[DatabaseHelper.columnHorario2],
      color: map[DatabaseHelper.columnColor],
    );
  }
}