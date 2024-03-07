import 'package:listgenius/src/screens/data_base/db_agenda.dart';
import 'package:sqflite/sqflite.dart';

class DiasCRUD {
  Future<int> insertDia(Dia dia) async {
    Database database = await DatabaseHelper.instance.database;
    return await database.insert(DatabaseHelper.tableDias, dia.toMap());
  }

  Future<List<Dia>> getAllDias() async {
    Database database = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> diasMap = await database.query(DatabaseHelper.tableDias);
    return diasMap.map((dia) => Dia.fromMap(dia)).toList();
  }

  Future<Dia?> getDiaById(int id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableDias,
      where: '${DatabaseHelper.columnIdActividadDia} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Dia.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateDia(Dia dia) async {
    Database database = await DatabaseHelper.instance.database;
    return await database.update(DatabaseHelper.tableDias, dia.toMap(), where: '${DatabaseHelper.columnIdDia} = ?', whereArgs: [dia.idDia]);
  }

  Future<int> deleteDia(int idDia) async {
    Database database = await DatabaseHelper.instance.database;
    return await database.delete(DatabaseHelper.tableDias, where: '${DatabaseHelper.columnIdActividadDia} = ?', whereArgs: [idDia]);
  }
}

class Dia {
  int? idDia;
  int idActividad;
  String lunes;
  String martes;
  String miercoles;
  String jueves;
  String viernes;
  String sabado;
  String domingo;
  //
  //String dia;
  //String realizado;

  Dia({
    this.idDia,
    required this.idActividad,
    required this.lunes,
    required this.martes,
    required this.miercoles,
    required this.jueves,
    required this.viernes,
    required this.sabado,
    required this.domingo,
  });

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnIdDia: idDia,
      DatabaseHelper.columnIdActividadDia: idActividad,
      DatabaseHelper.columnLunes: lunes,
      DatabaseHelper.columnMartes: martes,
      DatabaseHelper.columnMiercoles: miercoles,
      DatabaseHelper.columnJueves: jueves,
      DatabaseHelper.columnViernes: viernes,
      DatabaseHelper.columnSabado: sabado,
      DatabaseHelper.columnDomingo: domingo,
      // DatabaseHelper.columnDia: dia,
      // DatabaseHelper.columnRealizadoDia: realizado,
    };
  }

  factory Dia.fromMap(Map<String, dynamic> map) {
    return Dia(
      idDia: map[DatabaseHelper.columnIdDia],
      idActividad: map[DatabaseHelper.columnIdActividadDia],
      lunes: map[DatabaseHelper.columnLunes] ?? '',
      martes: map[DatabaseHelper.columnMartes] ?? '',
      miercoles: map[DatabaseHelper.columnMiercoles] ?? '',
      jueves: map[DatabaseHelper.columnJueves] ?? '',
      viernes: map[DatabaseHelper.columnViernes] ?? '',
      sabado: map[DatabaseHelper.columnSabado],
      domingo: map[DatabaseHelper.columnDomingo],
      // dia: map[DatabaseHelper.columnDia],
      // realizado: map[DatabaseHelper.columnRealizadoDia],
    );
  }
}