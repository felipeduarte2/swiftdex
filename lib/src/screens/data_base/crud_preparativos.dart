// import 'package:listgenius/src/screens/data_base/db_agenda.dart';
// import 'package:sqflite/sqflite.dart';

// class PreparativosCRUD {
//   Future<int> insertPreparativo(Preparativo preparativo) async {
//     Database database = await DatabaseHelper.instance.database;
//     return await database.insert(DatabaseHelper.tablePreparativos, preparativo.toMap());
//   }

//   Future<List<Preparativo>> getAllPreparativo() async {
//     Database database = await DatabaseHelper.instance.database;
//     final List<Map<String, dynamic>> preparativoMap = await database.query(DatabaseHelper.tablePreparativos);
//     return preparativoMap.map((preparativo) => Preparativo.fromMap(preparativo)).toList();
//   }

//   Future<Preparativo?> getPreparativoById(int id) async {
//     Database db = await DatabaseHelper.instance.database;
//     List<Map<String, dynamic>> maps = await db.query(
//       DatabaseHelper.tablePreparativos,
//       where: '${DatabaseHelper.columnIdActividadPreparativo} = ?',
//       whereArgs: [id],
//     );
//     if (maps.isNotEmpty) {
//       return Preparativo.fromMap(maps.first);
//     } else {
//       return null;
//     }
//   }

//   Future<int> updatePreparativo(Preparativo preparativo) async {
//     Database database = await DatabaseHelper.instance.database;
//     return await database.update(DatabaseHelper.tablePreparativos, preparativo.toMap(), where: '${DatabaseHelper.columnIdPreparativo} = ?', 
//     whereArgs: [preparativo.idPreparativo]);
//   }

//   Future<int> deletePreparativo(int idPreparativo) async {
//     Database database = await DatabaseHelper.instance.database;
//     return await database.delete(DatabaseHelper.tablePreparativos, where: '${DatabaseHelper.columnIdActividadPreparativo} = ?', 
//     whereArgs: [idPreparativo]);
//   }
// }

// class Preparativo {
//   int? idPreparativo;
//   int idActividad;
//   String preparativo;
//   String realizado;

//   Preparativo({
//     this.idPreparativo,
//     required this.idActividad,
//     required this.preparativo,
//     required this.realizado,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       DatabaseHelper.columnIdPreparativo: idPreparativo,
//       DatabaseHelper.columnIdActividadPreparativo: idActividad,
//       DatabaseHelper.columnPreparativo: preparativo,
//       DatabaseHelper.columnRealizadoPreparativo: realizado,
//     };
//   }

//   factory Preparativo.fromMap(Map<String, dynamic> map) {
//     return Preparativo(
//       idPreparativo: map[DatabaseHelper.columnIdPreparativo],
//       idActividad: map[DatabaseHelper.columnIdActividadPreparativo],
//       preparativo: map[DatabaseHelper.columnPreparativo],
//       realizado: map[DatabaseHelper.columnRealizadoPreparativo],
//     );
//   }
// }