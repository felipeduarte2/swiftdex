// import 'package:listgenius/src/screens/data_base/db_agenda.dart';
// import 'package:sqflite/sqflite.dart';

// class ViajesCRUD {
//   Future<int> insertViaje(Viaje viaje) async {
//     Database database = await DatabaseHelper.instance.database;
//     return await database.insert(DatabaseHelper.tableViaje, viaje.toMap());
//   }

//   Future<List<Viaje>> getAllViajes() async {
//     Database database = await DatabaseHelper.instance.database;
//     final List<Map<String, dynamic>> viajesMap = await database.query(DatabaseHelper.tableViaje);
//     return viajesMap.map((viaje) => Viaje.fromMap(viaje)).toList();
//   }

//   Future<Viaje?> getViajeById(int id) async {
//     Database db = await DatabaseHelper.instance.database;
//     List<Map<String, dynamic>> maps = await db.query(
//       DatabaseHelper.tableViaje,
//       where: '${DatabaseHelper.columnIdActividadViaje} = ?',
//       whereArgs: [id],
//     );
//     if (maps.isNotEmpty) {
//       return Viaje.fromMap(maps.first);
//     } else {
//       return null;
//     }
//   }

//   Future<int> updateViaje(Viaje viaje) async {
//     Database database = await DatabaseHelper.instance.database;
//     return await database.update(DatabaseHelper.tableViaje, viaje.toMap(), where: '${DatabaseHelper.columnIdViaje} = ?', whereArgs: [viaje.idViaje]);
//   }

//   Future<int> deleteViaje(int idViaje) async {
//     Database database = await DatabaseHelper.instance.database;
//     return await database.delete(DatabaseHelper.tableViaje, where: '${DatabaseHelper.columnIdActividadViaje} = ?', whereArgs: [idViaje]);
//   }
// }

// class Viaje {
//   int? idViaje;
//   int idActividad;
//   String itinerario;
//   String alojamiento;
//   String trasporte;
//   // String viaje;
//   // String realizado;

//   Viaje({
//     this.idViaje,
//     required this.idActividad,
//     required this.itinerario,
//     required this.alojamiento,
//     required this.trasporte,
//     // required this.viaje,
//     // required this.realizado,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       DatabaseHelper.columnIdViaje: idViaje,
//       DatabaseHelper.columnIdActividadViaje: idActividad,
//       DatabaseHelper.columnItinerario: itinerario,
//       DatabaseHelper.columnAlojamiento: alojamiento,
//       DatabaseHelper.columnTransporte: trasporte,
//       // DatabaseHelper.columnViaje: viaje,
//       // DatabaseHelper.columnRealizadoViaje: realizado,
//     };
//   }

//   factory Viaje.fromMap(Map<String, dynamic> map) {
//     return Viaje(
//       idViaje: map[DatabaseHelper.columnIdViaje],
//       idActividad: map[DatabaseHelper.columnIdActividadViaje],
//       itinerario: map[DatabaseHelper.columnItinerario],
//       alojamiento: map[DatabaseHelper.columnAlojamiento],
//       trasporte: map[DatabaseHelper.columnTransporte],
//       // viaje: map[DatabaseHelper.columnViaje],
//       // realizado: map[DatabaseHelper.columnRealizadoViaje],
//     );
//   }
// }