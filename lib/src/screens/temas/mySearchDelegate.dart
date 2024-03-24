import 'package:flutter/material.dart';
import 'package:listgenius/src/screens/data_base/crud_actividades.dart';

class SearchActivityDelegate extends SearchDelegate<Actividad>{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [Center()];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Center();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center();
  }

}


// ignore: duplicate_ignore
// ignore_for_file: file_names
// import 'package:flutter/material.dart';

// class MySearchDelegate extends SearchDelegate<String> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     // Acciones de búsqueda, como limpiar la búsqueda actual
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     // Botón de retroceso, para volver a la pantalla anterior
//     return IconButton(
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//       ),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // Implementa la lógica de búsqueda y construye los resultados de búsqueda
//     final suggestions = query.isEmpty
//         ? _actividades
//         : _actividades
//             .where((actividad) =>
//                 actividad.nombre.toLowerCase().contains(query.toLowerCase()))
//             .toList();

//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(suggestions[index].nombre),
//           onTap: () {
//             close(context, suggestions[index].nombre);
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // Implementa la lógica de sugerencias de búsqueda
//     final suggestions = query.isEmpty
//         ? _actividades
//         : _actividades
//             .where((actividad) =>
//                 actividad.nombre.toLowerCase().contains(query.toLowerCase()))
//             .toList();

//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(suggestions[index].nombre),
//           onTap: () {
//             close(context, suggestions[index].nombre);
//           },
//         );
//       },
//     );
//   }
// }