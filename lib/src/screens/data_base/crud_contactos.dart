// import 'package:listgenius/src/screens/data_base/db_agenda.dart';
// import 'package:sqflite/sqflite.dart';

// class ContactosCRUD {
//   Future<int> insertContacto(Contacto contacto) async {
//     Database database = await DatabaseHelper.instance.database;
//     return await database.insert(DatabaseHelper.tableContactos, contacto.toMap());
//   }

//   Future<List<Contacto>> getAllContactos() async {
//     Database database = await DatabaseHelper.instance.database;
//     final List<Map<String, dynamic>> contactosMap = await database.query(DatabaseHelper.tableContactos);
//     return contactosMap.map((contacto) => Contacto.fromMap(contacto)).toList();
//   }

//   Future<Contacto?> getContactoById(int id) async {
//     Database db = await DatabaseHelper.instance.database;
//     List<Map<String, dynamic>> maps = await db.query(
//       DatabaseHelper.tableContactos,
//       where: '${DatabaseHelper.columnIdActividadContacto} = ?',
//       whereArgs: [id],
//     );
//     if (maps.isNotEmpty) {
//       return Contacto.fromMap(maps.first);
//     } else {
//       return null;
//     }
//   }

//   Future<int> updateContacto(Contacto contacto) async {
//     Database database = await DatabaseHelper.instance.database;
//     return await database.update(DatabaseHelper.tableContactos, contacto.toMap(), where: '${DatabaseHelper.columnIdContacto} = ?', whereArgs: [contacto.idContacto]);
//   }

//   Future<int> deleteContacto(int idContacto) async {
//     Database database = await DatabaseHelper.instance.database;
//     return await database.delete(DatabaseHelper.tableContactos, where: '${DatabaseHelper.columnIdActividadContacto} = ?', whereArgs: [idContacto]);
//   }
// }

// class Contacto {
//   int? idContacto;
//   int idActividad;
//   String contacto;
//   String realizado;

//   Contacto({
//     this.idContacto,
//     required this.idActividad,
//     required this.contacto,
//     required this.realizado,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       DatabaseHelper.columnIdContacto: idContacto,
//       DatabaseHelper.columnIdActividadContacto: idActividad,
//       DatabaseHelper.columnContacto: contacto,
//       DatabaseHelper.columnRealizadoContacto: realizado,
//     };
//   }

//   factory Contacto.fromMap(Map<String, dynamic> map) {
//     return Contacto(
//       idContacto: map[DatabaseHelper.columnIdContacto],
//       idActividad: map[DatabaseHelper.columnIdActividadContacto],
//       contacto: map[DatabaseHelper.columnContacto],
//       realizado: map[DatabaseHelper.columnRealizadoContacto],
//     );
//   }
// }