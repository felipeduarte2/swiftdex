import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:listgenius/src/screens/data_base/crud_actividades.dart';
// import 'package:listgenius/src/screens/data_base/crud_contactos.dart';
import 'package:listgenius/src/screens/data_base/crud_notas.dart';
// import 'package:listgenius/src/screens/data_base/crud_preparativos.dart';

class EventoDetails extends StatefulWidget {
  const EventoDetails({super.key,});

  @override
  State<EventoDetails> createState() => _EventoDetailsState();
}

class _EventoDetailsState extends State<EventoDetails> {
  Actividad? _actividad;
  // Contacto? _contacto;
  // Preparativo? _preparativo;
  List<Nota> notas = [];
  // Nota? _nota;
  int id = 0;
  //final argumento = ModalRoute.of(widget.context)!.settings.arguments as String;


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
    // Contacto? contacto = await ContactosCRUD().getContactoById(id);
    // Preparativo? preparativo = await PreparativosCRUD().getPreparativoById(id);
    List<Nota> nota2 = await  NotasCRUD().getAllNotasById(id);
    // Nota? nota = await NotasCRUD().getNotaById(id);
    if(mounted){
      setState(() {
      _actividad = actividad;
      // _contacto = contacto;
      // _preparativo = preparativo;
      notas=nota2;
      // _nota = nota;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xffa37437),
        title: const Text("EVENTO"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: const Icon(IconlyLight.edit_square), onPressed: () => _edit(context)),
          IconButton(icon: const Icon(IconlyLight.delete), onPressed: () => _delete(context)),
        ],
      ),
      body: _verDetalles(context),
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
                    child: Image.asset("assets/images/eventoimg.png"),
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
                    const Text("Evento:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    Text('${_actividad?.titulo}',style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 8),
                    // const Text("Descripción:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                    // Text('${_actividad?.descripcion}',style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                    // const SizedBox(height: 8),
                  ]),
                ),
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
                //           const Text("Fecha:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                //           Text('${_actividad?.fecha}',style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
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
                //           const Text("Hora:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                //           Text('${_actividad?.hora}',style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                //           const SizedBox(height: 8),
                //         ]),
                //       ),
                //     ],
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
                    const Text("Lugar:",style: TextStyle(fontSize: 20)),
                    Text('${_actividad?.lugar}',style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 8),
                    // const Text("Descripción:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                    // Text('${_actividad?.descripcion}',style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                    // const SizedBox(height: 8),
                  ]),
                ),
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
                //       const Text("Lugar:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                //       Text('${_actividad?.lugar}',style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                //       const SizedBox(height: 8),
                //     ]),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
                //   child: Container(
                //     width: double.infinity,
                //     decoration: const BoxDecoration(
                //       color: Color(0xff63d3ff),
                //       borderRadius:  BorderRadius.all(Radius.circular(10)), 
                //     ),
                //     child: const Column(children: [
                //       SizedBox(height: 8),
                //       Text("Contactos:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                //       // Text('${_contacto?.contacto}',style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                //       // const SizedBox(height: 8),
                //     ]),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
                //   child: Container(
                //     width: double.infinity,
                //     decoration: const BoxDecoration(
                //       color: Color(0xff63d3ff),
                //       borderRadius:  BorderRadius.all(Radius.circular(10)), 
                //     ),
                //     child: const Column(children: [
                //       SizedBox(height: 8),
                //       Text("Preparativos:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                //       // Text('${_preparativo?.preparativo}',style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                //       // const SizedBox(height: 8),
                //     ]),
                //   ),
                // ),
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
    Navigator.of(context).pushNamed("/evento",arguments: '$id');
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
                // ContactosCRUD().deleteContacto(id);
                // PreparativosCRUD().deletePreparativo(id);
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

