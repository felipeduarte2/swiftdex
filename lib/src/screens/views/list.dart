// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listgenius/src/screens/data_base/crud_actividades.dart';
// import 'package:listgenius/src/screens/data_base/crud_contactos.dart';
// import 'package:listgenius/src/screens/data_base/crud_detalles.dart';
// import 'package:listgenius/src/screens/data_base/crud_dias.dart';
// import 'package:listgenius/src/screens/data_base/crud_notas.dart';
// import 'package:listgenius/src/screens/data_base/crud_preparativos.dart';
// import 'package:listgenius/src/screens/data_base/crud_viaje.dart';
import 'package:listgenius/src/screens/temas/removeact.dart';
import 'package:listgenius/src/screens/temas/taskitem.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  List<Actividad>? _actividades;
  // List<Actividad>? _filteredActividades;
  // late List<Actividad> _filteredActividades;
  List<bool>? boolList;
  // final _searchQuery = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadActividades();
    // _filteredActividades = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _loadActividades() async {
    List<Actividad>? actividades = await ActividadesCRUD().getAllActividades();
    boolList= List<bool>.generate(actividades.length, (index) => false);
    if(mounted){
      setState(() {
      _actividades = actividades;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: CupertinoSearchTextField(
      //     controller: _searchQuery,
      //     onSubmitted: (value) {
      //       _filterActividades(value);
      //     },
      //   ),
      // ),
      body: _actividades != null
          ? _showActividades(context)
          : _buttonCircular(context),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        _ShowDialog(context);
        },
        child: const Icon(Icons.add,color: Colors.white),
      ),
    );
  }

  _buttonCircular(BuildContext context){
    return const Center(child: CircularProgressIndicator());
  }

  _showActividades(BuildContext context){
    _loadActividades();
    if(_actividades!.isEmpty){
      return const Center(child: Text("Sin Actividades",style: TextStyle(fontSize: 18)));
    }else{
      return ListView.builder(
              itemCount: _actividades!.length,
              // itemCount: _filteredActividades.length,
              itemBuilder: (BuildContext context, int index) {
                Actividad actividad = _actividades![index];
                // Actividad actividad = _filteredActividades[index];
                if(actividad.realizado=="si"){boolList?[index] = true;}
                return Dismissible(
                  // key: Key(index.toString()),
                  key: Key(actividad.idActividad.toString()),
                  direction: DismissDirection.horizontal,
                  background: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete,color: Colors.red,size: 35,),
                      SizedBox(width: 8,),
                      Text("Eliminar", style: TextStyle(color: Colors.red,fontSize: 24),)
                    ]
                  ),
                  onDismissed: (direction) {
                    Remove.removeFromDatabase(actividad);
                    if(mounted){
                      setState(() {
                        _actividades?.removeAt(index);
                        boolList?.removeAt(index);
                        // _actividades?.removeAt(index);
                        // _actividades?.remove(_actividades?[index]);
                      // _actividades = actividades;
                      // boolList= List<bool>.generate(actividades.length, (index) => false);
                      });
                    }
                  },
                  child: TaskItem(actividad: actividad , isCheck: boolList?[index] ?? false,),
                ); 
              },
            );
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> _ShowDialog(BuildContext context) async {
    await showDialog(
      context: context, 
      builder: (BuildContext context){
        // var ocultar2 = ocultar(context);
        return SimpleDialog(
          // title: const Text(
          //   'SELECCIONE UNA OPCIÓN',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(fontWeight: FontWeight.bold)
          // ),
          // alignment:  Alignment.center,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          // alignment: Alignment.bottomRight,
          // backgroundColor: const Color(0xffa37437),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => {
                          //ocultar(context),
                          _irTarea(context),
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xff63d3ff),
                            borderRadius: BorderRadius.all(Radius.circular(10)), 
                          ),
                          // height: 50,
                          padding: const EdgeInsets.all(8.0,),
                          child: const Column(
                            children: <Widget>[
                              // SizedBox(width: 70),
                              Icon(Icons.assignment, size: 90,color: Colors.black87,),
                              Text("TAREA",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black87 )
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => {
                          //Navigator.pop(context),
                          _irEvento(context),
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xff63d3ff),
                            borderRadius: BorderRadius.all(Radius.circular(10)), 
                          ),
                          // height: 50,
                          padding: const EdgeInsets.all(8.0),
                          child: const Column(
                            children: <Widget>[
                              // SizedBox(width: 65),
                              Icon(Icons.event, size: 90,color: Colors.black87),
                              Text("EVENTO", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black87)
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => {
                          _irRutina(context),
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xff63d3ff),
                            borderRadius: BorderRadius.all(Radius.circular(10)), 
                          ),
                          // height: 50,
                          padding: const EdgeInsets.all(8.0),
                          child: const Column(
                            children: <Widget>[
                              // SizedBox(width: 65),
                              Icon(Icons.directions_run, size: 90,color: Colors.black87),
                              Text("RUTINA", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black87)
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => {
                          //Navigator.pop(context),
                          // print("object"),
                          _irViaje(context),
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xff63d3ff),
                            borderRadius: BorderRadius.all(Radius.circular(10)), 
                          ),
                          // height: 60,
                          // width: 120,
                          padding: const EdgeInsets.all(10.0),
                          child: const Column(
                            children: <Widget>[
                              // SizedBox(width: 70),
                              Icon(Icons.note_alt_outlined, size: 90,color: Colors.black87),
                              Text("Nota",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black87)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]
              ),
            ),
          ],
        );
      },
    );
    
  }

  // ocultar(BuildContext context) {
  _irViaje(BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context).pushNamed("/viaje",arguments: "0");
  }

  _irRutina(BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context).pushNamed("/rutina",arguments: "0");
  }

  _irTarea(BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context).pushNamed("/tarea",arguments: "0");
  }

  _irEvento(BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context).pushNamed("/evento",arguments: "0");
  }

  // void _filterActividades(String query) {
  //   List<Actividad>? results = [];
  //   if (query.isEmpty) {
  //     results = _actividades;
  //   } else {
  //     results = _actividades
  //         ?.where((actividad) =>
  //             actividad.titulo.toLowerCase().contains(query.toLowerCase()))
  //         .toList();
  //   }
  //   setState(() {
  //     _filteredActividades = results!;
  //   });
  // }
}
