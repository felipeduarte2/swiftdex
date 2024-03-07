import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:listgenius/src/screens/data_base/crud_actividades.dart';
import 'package:listgenius/src/screens/data_base/crud_detalles.dart';
import 'package:listgenius/src/screens/data_base/crud_dias.dart';
import 'package:listgenius/src/screens/data_base/crud_notas.dart';

class RutinaDetails extends StatefulWidget {
  const RutinaDetails({super.key,});

  @override
  State<RutinaDetails> createState() => _RutinaDetailsState();
}

class _RutinaDetailsState extends State<RutinaDetails> {
  Actividad? _actividad;
  // Detalle? _detalle;
  Dia? _dias;
  // Nota? _nota;
  List<Detalle> detalles = [];
  List<Nota> notas = [];
  int id = 0;

  @override
  void initState() {
    //_loadActividad();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_loadActividad();
    // Se puede usar el argumento aquí
    //_argumento = ModalRoute.of(context)!.settings.arguments as String;
  }

  Future<void> _loadActividad() async {
    final name = ModalRoute.of(context)?.settings.arguments;
    id = int.parse(name.toString());

    Actividad? actividad = await ActividadesCRUD().getActividadById(id);
    // Detalle? detalle =  await DetallesCRUD().getDetalleById(id);
    Dia? dia = await DiasCRUD().getDiaById(id);
    // Nota? nota = await NotasCRUD().getNotaById(id);
    List<Detalle> detalle2 = await DetallesCRUD().getAllDetallesById(id);
    List<Nota> nota2 = await  NotasCRUD().getAllNotasById(id);
    if(mounted){
      setState(() {
      _actividad = actividad;
      // _detalle = detalle;
      _dias = dia;
      // _nota = nota;
      detalles =detalle2;
      notas=nota2;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xffa37437),
        title: const Text("RUTINA"),
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
          const Text('Detalles',style: TextStyle(fontSize: 18) ),          
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
                    child: Image.asset("assets/images/rutinaimg.png"),
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
                    const Text("Rutina:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    Text('${_actividad?.titulo}',style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 8),
                    // const Text("Descripción:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                    // Text('${_actividad?.descripcion}',style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                    // const SizedBox(height: 8),
                  ]),
                ),
                // const SizedBox(height: 8),
                // Padding(
                //   padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
                //   child: Container(
                //     width: double.infinity,
                //     decoration: const BoxDecoration(
                //       color: Color(0xff63d3ff),
                //       borderRadius:  BorderRadius.all(Radius.circular(10)), 
                //     ),
                //     child: Column(children: [
                //       const SizedBox(height: 8),
                //       const Text("Nivel de importancia:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                //       Text('${_actividad?.nivelDeImportancia}',style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                //       const SizedBox(height: 8),
                //     ]),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       Container(
                //         width: 200,
                //         // height: 100,
                //         // height: double.infinity,
                //         decoration: const BoxDecoration(
                //           color: Color(0xff63d3ff),
                //           borderRadius: BorderRadius.all(Radius.circular(10)), 
                //         ),
                //         child: Column(children: [
                //           const SizedBox(height: 8),
                //           const Text("Horario inicio:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                //           Text('${_actividad?.horario1}',style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                //           const SizedBox(height: 8),
                //         ]),
                //       ),
                //       Container(
                //         width: 200,
                //         // height: 100,
                //         // height: double.infinity,
                //         decoration: const BoxDecoration(
                //           color: Color(0xff63d3ff),
                //           borderRadius: BorderRadius.all(Radius.circular(10)), 
                //         ),
                //         child: Column(children: [
                //           const SizedBox(height: 8),
                //           const Text("Horario fin:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                //           Text('${_actividad?.horario2}',style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                //           const SizedBox(height: 8),
                //         ]),
                //       ),
                //     ],
                //   ),
                // ),
                _subtareas(context),
                // Padding(
                //   padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
                //   child: Container(
                //     width: double.infinity,
                //     decoration: const BoxDecoration(
                //       color: Color(0xff63d3ff),
                //       borderRadius:  BorderRadius.all(Radius.circular(10)), 
                //     ),
                //     child: Column(children: [
                //       const SizedBox(height: 8),
                //       const Text("Detalles:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                //       Text('${_detalle?.detalle}',style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                //       const SizedBox(height: 8),
                //     ]),
                //   ),
                // ),
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
                    const Text("Dias:",style: TextStyle(fontSize: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            // borderRadius:  const BorderRadius.all(Radius.circular(10)), 
                            shape: BoxShape.circle,
                            border: Border.all(color:  Colors.blue, width: 2),
                            color: _dias?.lunes == "si" ? Colors.blue : Colors.transparent,
                          ),
                          child: const Text('Lu',style: TextStyle(fontSize: 16),),
                        ),
                        Container(padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            // borderRadius:  const BorderRadius.all(Radius.circular(10)), 
                            shape: BoxShape.circle,
                            border: Border.all(color:  Colors.blue, width: 2),
                            color: _dias?.martes == "si" ? Colors.blue : Colors.transparent,
                          ),
                          child: const Text('Ma',style: TextStyle(fontSize: 16),),
                        ),
                        // const SizedBox(width: 8),
                        Container(padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            // borderRadius:  const BorderRadius.all(Radius.circular(10)), 
                            shape: BoxShape.circle,
                            border: Border.all(color:  Colors.blue, width: 2),
                            color: _dias?.miercoles == "si" ? Colors.blue : Colors.transparent,
                          ),
                          child: const Text('Mi',style: TextStyle(fontSize: 16),),
                        ),
                        Container(padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            // borderRadius:  const BorderRadius.all(Radius.circular(10)), 
                            shape: BoxShape.circle,
                            border: Border.all(color:  Colors.blue, width: 2),
                            color: _dias?.jueves == "si" ? Colors.blue : Colors.transparent,
                          ),
                          child: const Text('Ju',style: TextStyle(fontSize: 16),),
                        ),
                        Container(padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            // borderRadius:  const BorderRadius.all(Radius.circular(10)), 
                            shape: BoxShape.circle,
                            border: Border.all(color:  Colors.blue, width: 2),
                            color: _dias?.viernes == "si" ? Colors.blue : Colors.transparent,
                          ),
                          child: const Text('Vi',style: TextStyle(fontSize: 16),),
                        ),
                        Container(padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            // borderRadius:  const BorderRadius.all(Radius.circular(10)), 
                            shape: BoxShape.circle,
                            border: Border.all(color:  Colors.blue, width: 2),
                            color: _dias?.sabado == "si" ? Colors.blue : Colors.transparent,
                          ),
                          child: const Text('Sa',style: TextStyle(fontSize: 16),),
                        ),
                        Container(padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            // borderRadius:  const BorderRadius.all(Radius.circular(10)), 
                            shape: BoxShape.circle,
                            border: Border.all(color:  Colors.blue, width: 2),
                            color: _dias?.domingo == "si" ? Colors.blue : Colors.transparent,
                          ),
                          child: const Text('Do',style: TextStyle(fontSize: 16),),
                        ),
                        // const SizedBox(width: 8),
                      ]
                    ),
                    // Text('${_detalle?.detalle}',style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                  ]),
                ),   
                _notas(context),         
                // Padding(
                //   padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
                //   child: Container(
                //     width: double.infinity,
                //     decoration: const BoxDecoration(
                //       color: Color(0xff63d3ff),
                //       borderRadius:  BorderRadius.all(Radius.circular(10)), 
                //     ),
                //     child: Column(children: [
                //       const SizedBox(height: 8),
                //       const Text("Notas:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                //       Text('${_nota?.nota}',style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                //       const SizedBox(height: 8),
                //     ]),
                //   ),
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
    Navigator.of(context).pushNamed("/rutina",arguments: '$id');
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
                DiasCRUD().deleteDia(id);
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

