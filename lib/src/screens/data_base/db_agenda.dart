// ignore: file_names, depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "actividades.db";
  static const _databaseVersion = 1;

  //ACTIVIDADES
  static const tableActividades = "actividades";
  static const columnIdActividad = "id_actividad";
  static const columnCategoria = "categoria";
  static const columnTitulo = "titulo";
  // static const columnDescripcion = "descripcion";
  static const columnNivelDeImportancia = "nivel_de_importancia";
  static const columnRealizado = "realizado";
  static const columnFecha = "fecha";
  static const columnHora = "hora";
  static const columnLugar = "lugar";
  static const columnHorario1 = "horario1";
  static const columnHorario2 = "horario2";
  static const columnColor = "color";

  // CONTACTOS
  // static const tableContactos = "contactos";
  // static const columnIdContacto = "id_contacto";
  // static const columnContacto = "contacto";
  // static const columnRealizadoContacto = "realizado";
  // static const columnIdActividadContacto = "id_actividad";

  // PREPARATIVOS
  // static const tablePreparativos = "preparativos";
  // static const columnIdPreparativo = "id_preparativo";
  // static const columnPreparativo = "preparativo";
  // static const columnRealizadoPreparativo = "realizado";
  // static const columnIdActividadPreparativo = "id_actividad";

  // DETALLES
  static const tableDetalles = "detalles";
  static const columnIdDetalle = "id_detalle";
  static const columnDetalle = "detalle";
  static const columnRealizadoDetalle = "realizado";
  static const columnIdActividadDetalle = "id_actividad";

  //DIAS
  static const tableDias = "dias";
  static const columnIdDia = "id_dia";
  static const columnLunes = "lunes";
  static const columnMartes = "martes";
  static const columnMiercoles = "miercoles";
  static const columnJueves = "jueves";
  static const columnViernes = "viernes";
  static const columnSabado = "sabado";
  static const columnDomingo = "domingo";
  static const columnIdActividadDia = "id_actividad";

  //INFORMACION VIAJE
  // static const tableViaje = "informacion_viaje";
  // static const columnIdViaje = "id_inf";
  // static const columnItinerario = "itinerario";
  // static const columnAlojamiento = "alojamiento";
  // static const columnTransporte = "transporte";
  // static const columnIdActividadViaje = "id_actividad";

  //NOTAS
  static const tableNotas = "notas";
  static const columnIdNota = "id_nota";
  static const columnNota = "nota";
  static const columnRealizadoNota = "realizado";
  static const columnIdActividadNota = "id_actividad";

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableActividades (
        $columnIdActividad INTEGER PRIMARY KEY,
        $columnCategoria VARCHAR(20) NOT NULL,
        $columnTitulo TEXT NOT NULL,
        $columnNivelDeImportancia VARCHAR(20) NOT NULL,
        $columnRealizado VARCHAR(2) NOT NULL,
        $columnFecha VARCHAR(20),
        $columnHora VARCHAR(20),
        $columnLugar TEXT,
        $columnHorario1 VARCHAR(20),
        $columnHorario2 VARCHAR(20),
        $columnColor INTEGER
      )
    ''');
    // await db.execute('''
    //   CREATE TABLE $tableContactos (
    //     $columnIdContacto INTEGER PRIMARY KEY AUTOINCREMENT,
    //     $columnContacto TEXT NOT NULL,
    //     $columnRealizadoContacto VARCHAR(2) NOT NULL,
    //     $columnIdActividadContacto INTEGER REFERENCES $tableActividades($columnIdActividad)
    //   )
    // ''');
    // await db.execute('''
    //   CREATE TABLE $tablePreparativos (
    //     $columnIdPreparativo INTEGER PRIMARY KEY AUTOINCREMENT,
    //     $columnPreparativo TEXT NOT NULL,
    //     $columnRealizadoPreparativo VARCHAR(2) NOT NULL,
    //     $columnIdActividadPreparativo INTEGER REFERENCES $tableActividades($columnIdActividad)
    //   )
    // ''');
    await db.execute('''
      CREATE TABLE $tableDetalles (
        $columnIdDetalle INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnDetalle TEXT NOT NULL,
        $columnRealizadoDetalle VARCHAR(2) NOT NULL,
        $columnIdActividadDetalle INTEGER REFERENCES $tableActividades($columnIdActividad)
      )
    ''');
    await db.execute('''
      CREATE TABLE $tableDias (
        $columnIdDia INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnLunes VARCHAR(2) NOT NULL,
        $columnMartes VARCHAR(2) NOT NULL,
        $columnMiercoles VARCHAR(2) NOT NULL,
        $columnJueves VARCHAR(2) NOT NULL,
        $columnViernes VARCHAR(2) NOT NULL,
        $columnSabado VARCHAR(2) NOT NULL,
        $columnDomingo VARCHAR(2) NOT NULL,
        $columnIdActividadDia INTEGER REFERENCES $tableActividades($columnIdActividad)
      )
    ''');
    // await db.execute('''
    //   CREATE TABLE $tableViaje (
    //     $columnIdViaje INTEGER PRIMARY KEY AUTOINCREMENT,
    //     $columnItinerario TEXT NOT NULL,
    //     $columnAlojamiento TEXT NOT NULL,
    //     $columnTransporte TEXT NOT NULL,
    //     $columnIdActividadViaje INTEGER REFERENCES $tableActividades($columnIdActividad)
    //   )
    // ''');
    await db.execute('''
      CREATE TABLE $tableNotas (
        $columnIdNota INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnNota TEXT NOT NULL,
        $columnIdActividadNota INTEGER REFERENCES $tableActividades($columnIdActividad)
      )
    ''');
  }

  Future<void> close() async {
    await _database?.close();
  }
}