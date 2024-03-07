import 'package:listgenius/src/screens/data_base/db_agenda.dart';
import 'package:sqflite/sqflite.dart';

class NotasCRUD {
  Future<int> insertNota(Nota nota) async {
    Database database = await DatabaseHelper.instance.database;
    return await database.insert(DatabaseHelper.tableNotas, nota.toMap());
  }

  Future<List<Nota>> getAllNotas() async {
    Database database = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> notasMap = await database.query(DatabaseHelper.tableNotas);
    return notasMap.map((nota) => Nota.fromMap(nota)).toList();
  }

  Future<List<Nota>> getAllNotasById(int id) async {
    Database database = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> notasMap = await database.query(
      DatabaseHelper.tableNotas,
      where: '${DatabaseHelper.columnIdActividadNota} = ?',
      whereArgs: [id],
    );
    return notasMap.map((nota) => Nota.fromMap(nota)).toList();
  }

  Future<Nota?> getNotaById(int id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableNotas,
      where: '${DatabaseHelper.columnIdActividadNota} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Nota.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateNota(Nota nota) async {
    Database database = await DatabaseHelper.instance.database;
    return await database.update(DatabaseHelper.tableNotas, nota.toMap(), where: '${DatabaseHelper.columnIdNota} = ?', whereArgs: [nota.idNota]);
  }

  Future<int> deleteNota(int idNota) async {
    Database database = await DatabaseHelper.instance.database;
    return await database.delete(DatabaseHelper.tableNotas, where: '${DatabaseHelper.columnIdActividadNota} = ?', whereArgs: [idNota]);
  }
}

class Nota {
  int? idNota;
  int idActividad;
  String nota;
  //String realizado;

  Nota({
    this.idNota,
    required this.idActividad,
    required this.nota,
    //required this.realizado,
  });

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnIdNota: idNota,
      DatabaseHelper.columnIdActividadNota: idActividad,
      DatabaseHelper.columnNota: nota,
      //DatabaseHelper.columnRealizadoNota: realizado,
    };
  }

  factory Nota.fromMap(Map<String, dynamic> map) {
    return Nota(
      idNota: map[DatabaseHelper.columnIdNota],
      idActividad: map[DatabaseHelper.columnIdActividadNota],
      nota: map[DatabaseHelper.columnNota],
      //realizado: map[DatabaseHelper.columnRealizadoNota],
    );
  }
}