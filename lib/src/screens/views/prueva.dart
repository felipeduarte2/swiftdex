import 'package:flutter/material.dart';

// ignore: camel_case_types, must_be_immutable
class Secon_Page extends StatelessWidget {
  Secon_Page({super.key});

  late int id;

  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)?.settings.arguments;
    id = int.parse(name.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Otra Pantalla'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){},
          child: Text(id.toString()),
        ),
      ),
    );
  }
}

// INSERTAR UN REGISTRO 
// Actividad newActividad = Actividad(
//   categoria: 'Trabajo',
//   titulo: 'Reunión con el equipo de ventas',
//   descripcion: 'Revisar objetivos de venta del mes',
//   nivelDeImportancia: 'Alta',
//   realizado: 'No',
//   fecha: '2023-03-15',
//   hora: '10:00',
//   lugar: 'Sala de juntas',
//   horario1: '10:00 - 11:30',
//   horario2: '',
// );
// int rowsAffected = await ActividadesCRUD().insertActividad(newActividad);
// print('$rowsAffected rows were inserted');


// CONSULTAR TODOS LOS REGISTROS
// List<Actividad> actividades = await ActividadesCRUD().getAllActividades();
// actividades.forEach((actividad) {
//   print('${actividad.idActividad}: ${actividad.titulo}');
// });

//  CONSULTAR UN REGISTRO
// int idActividad = 1;
// Actividad actividad = await ActividadesCRUD().getActividadById(idActividad);
// print('Actividad: ${actividad.titulo}');

//  ACTUALIZAR
// Actividad updatedActividad = Actividad(
//   idActividad: 1,
//   categoria: 'Trabajo',
//   titulo: 'Reunión con el equipo de ventas',
//   descripcion: 'Revisar objetivos de venta del mes',
//   nivelDeImportancia: 'Alta',
//   realizado: 'Sí',
//   fecha: '2023-03-15',
//   hora: '10:00',
//   lugar: 'Sala de juntas',
//   horario1: '10:00 - 11:30',
//   horario2: '',
// );
// int rowsAffected = await ActividadesCRUD().updateActividad(updatedActividad);
// print('$rowsAffected rows were updated');


// ELIMINAR
// int idActividadToDelete = 1;
// int rowsAffected = await ActividadesCRUD().deleteActividad(idActividadToDelete);
// print('$rowsAffected rows were deleted');