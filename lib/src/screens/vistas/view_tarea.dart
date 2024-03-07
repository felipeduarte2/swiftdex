import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:listgenius/src/screens/data_base/crud_actividades.dart';
import 'package:listgenius/src/screens/data_base/crud_detalles.dart';
import 'package:listgenius/src/screens/data_base/crud_notas.dart';

class TareaDetails extends StatefulWidget {
  const TareaDetails({super.key,});

  @override
  State<TareaDetails> createState() => _TareaDetailsState();
}

class _TareaDetailsState extends State<TareaDetails> {
  Actividad? _actividad;
  // Detalle? _detalle;
  List<Detalle> detalles = [];
  // List<bool>? boolList;
  List<Nota> notas = [];
  // Nota? _nota;
  int id = 0;

  @override
  void initState() {
    //_loadActividad();
    super.initState();
  }

  Future<void> _loadActividad() async {
    final name = ModalRoute.of(context)?.settings.arguments;
    id = int.parse(name.toString());
    
    Actividad? actividad = await ActividadesCRUD().getActividadById(id);
    // Detalle? detalle = await DetallesCRUD().getDetalleById(id);
    List<Detalle> detalle2 = await DetallesCRUD().getAllDetallesById(id);
    List<Nota> nota2 = await  NotasCRUD().getAllNotasById(id);
    // boolList= List<bool>.generate(detalle2.length, (index) => false);
    // Nota? nota = await NotasCRUD().getNotaById(id);
    if(mounted){
      setState(() {
      _actividad = actividad;
      // _detalle  = detalle;
      detalles =detalle2;
      notas=nota2;
      // _nota = nota;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TAREA"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: const Icon(IconlyLight.edit_square), onPressed: () => _edit(context)),
          IconButton(icon: const Icon(IconlyLight.delete), onPressed: () => _delete(context)),
        ],
      ),
      body: _verDetalles(context),
    );
  }

  _subtareas(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 60, left: 60),
      decoration: const BoxDecoration(
                          // color: Color(0xff63d3ff),
                          borderRadius:  BorderRadius.all(Radius.circular(10)), 
                          border: Border(
                            bottom: BorderSide(color: Colors.blue),
                            right: BorderSide(color: Colors.blue),
                            left: BorderSide(color: Colors.blue),
                            top: BorderSide(color: Colors.blue),
                          ),
                        ),
      child: Column(
        children: [
          const Text('Subtareas',style: TextStyle(fontSize: 18) ),          
          for (int i = 0; i < detalles.length; i++) ...[
            AnimatedContainer(
              margin: const  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              duration: const Duration(milliseconds: 600),
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                //
                leading: GestureDetector(
                  onTap: (){
                    setState((){
                      if(detalles[i].realizado=="no"){detalles[i].realizado="si";}else{detalles[i].realizado="no";}
                      // ActividadesCRUD().updateActividad(widget.actividad);
                      DetallesCRUD().updateDetalle(detalles[i]);
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color:  Colors.black, width: 2)
                    ),
                    child: Icon(
                      Icons.check,
                      color: detalles[i].realizado == "si" ? Colors.white: Colors.transparent,
                      // color: Colors.white,
                    ),
                  ),
                ),
                title: Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 3),
            child: Text(
              detalles[i].detalle, 
              style: TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.w500, 
                decoration: detalles[i].realizado=="si" ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
          ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  _notas(BuildContext context){
     return Container(
      margin: const EdgeInsets.only(right: 60, left: 60),
      decoration: const BoxDecoration(
                          // color: Color(0xff63d3ff),
                          borderRadius:  BorderRadius.all(Radius.circular(10)), 
                          border: Border(
                            bottom: BorderSide(color: Colors.blue),
                            right: BorderSide(color: Colors.blue),
                            left: BorderSide(color: Colors.blue),
                            top: BorderSide(color: Colors.blue),
                          ),
                        ),
      child: Column(
        children: [
          const Text('Notas',style: TextStyle(fontSize: 18) ),
          for (int i = 0; i < notas.length; i++) ...[
            Text(notas[i].nota,style: const TextStyle(fontSize: 18)),
          ],
        ]
      )
     );
   }

  _verDetalles(BuildContext context) {
    _loadActividad();
    return Padding(
      padding: const EdgeInsets.all(1.0),
    child: _actividad != null
          ?  ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 60, left: 60),
                  child: SizedBox(          
                    child: Image.asset("assets/images/tareaimg.png"),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(right: 60, left: 60,top: 5,bottom: 5),
                  decoration: const BoxDecoration(
                    // color: Color(0xff63d3ff),
                    borderRadius:  BorderRadius.all(Radius.circular(10)), 
                    border: Border(top: BorderSide(color: Colors.blue),bottom:  BorderSide(color: Colors.blue),left:  BorderSide(color: Colors.blue),right:  BorderSide(color: Colors.blue),)
                  ),
                  child: Column(children: [
                    const SizedBox(height: 8),
                    const Text("Tarea:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    Text('${_actividad?.titulo}',style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 8),
                    // const Text("Descripción:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                    // Text('${_actividad?.descripcion}',style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                    // const SizedBox(height: 8),
                  ]),
                ),
                // const SizedBox(height: 8),
                // Container(
                //   width: double.infinity,
                //   margin: const EdgeInsets.only(right: 60, left: 60,top: 5,bottom: 5),
                //   decoration: const BoxDecoration(
                //     // color: Color(0xff63d3ff),
                //     borderRadius:  BorderRadius.all(Radius.circular(10)),
                //     border: Border(top: BorderSide(color: Colors.blue),bottom:  BorderSide(color: Colors.blue),left:  BorderSide(color: Colors.blue),right:  BorderSide(color: Colors.blue),)
                //   ),
                //   child: Column(children: [
                //     const SizedBox(height: 8),
                //     const Text("Nivel de importancia:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                //     Text('${_actividad?.nivelDeImportancia}',style: const TextStyle(fontSize: 20)),
                //     const SizedBox(height: 8),
                //   ]),
                // ),
                // Container(
                //   width: double.infinity,
                //   margin: const EdgeInsets.only(right: 60, left: 60,top: 5,bottom: 5),
                //   decoration: const BoxDecoration(
                //     // color: Color(0xff63d3ff),
                //     borderRadius:  BorderRadius.all(Radius.circular(10)),
                //     border: Border(top: BorderSide(color: Colors.blue),bottom:  BorderSide(color: Colors.blue),left:  BorderSide(color: Colors.blue),right:  BorderSide(color: Colors.blue),)
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       Column(children: [
                //         const SizedBox(height: 8),
                //         const Text("Fecha:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                //         Text('${_actividad?.fecha}',style: const TextStyle(fontSize: 20)),
                //         const SizedBox(height: 8),
                //       ]),
                //       Column(children: [
                //         const SizedBox(height: 8),
                //         const Text("Hora:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                //         Text('${_actividad?.hora}',style: const TextStyle(fontSize: 20)),
                //         const SizedBox(height: 8),
                //       ]),
                //     ],
                //   ),
                // ),
                // Container(
                //   width: double.infinity,
                //   margin: const EdgeInsets.only(right: 60, left: 60,top: 5,bottom: 5),
                //   decoration: const BoxDecoration(
                //     // color: Color(0xff63d3ff),
                //     borderRadius:  BorderRadius.all(Radius.circular(10)), 
                //     border: Border(top: BorderSide(color: Colors.blue),bottom:  BorderSide(color: Colors.blue),left:  BorderSide(color: Colors.blue),right:  BorderSide(color: Colors.blue),)
                //   ),
                //   child: Column(children: [
                //     const SizedBox(height: 8),
                //     const Text("Subtareas:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                //     Text('${_detalle?.detalle}',style: const TextStyle(fontSize: 20)),
                //     const SizedBox(height: 8),
                //   ]),
                // ),
                _subtareas(context),
                _notas(context),
                // Container(
                //   width: double.infinity,
                //   margin: const EdgeInsets.only(right: 60, left: 60,top: 5,bottom: 5),
                //   decoration: const BoxDecoration(
                //     // color: Color(0xff63d3ff),
                //     borderRadius:  BorderRadius.all(Radius.circular(10)),
                //      border: Border(top: BorderSide(color: Colors.blue),bottom:  BorderSide(color: Colors.blue),left:  BorderSide(color: Colors.blue),right:  BorderSide(color: Colors.blue),) 
                //   ),
                //   child: Column(children: [
                //     const SizedBox(height: 8),
                //     const Text("Notas:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                //     Text('${_nota?.nota}',style: const TextStyle(fontSize: 20)),
                //     const SizedBox(height: 8),
                //   ]),
                // ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }

  _edit(BuildContext context) {
    Navigator.of(context).pushNamed("/tarea",arguments: '$id');
  }
  
  _delete(BuildContext context) {
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          content: const Text("¿Seguro desea eliminar la actividad?",style: TextStyle(fontSize: 20)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text('No',style: TextStyle(fontSize: 20))
            ),
            ElevatedButton(
              onPressed: () {
                ActividadesCRUD().deleteActividad(id);
                DetallesCRUD().deleteDetalle(id);
                NotasCRUD().deleteNota(id);
                Navigator.pop(context);
                Navigator.pop(context);
              }, 
              child: const Text('Si',style: TextStyle(fontSize: 20))
            ),
          ],
        ); 
      },
    );
    //Navigator.pop(context);
  }
}

