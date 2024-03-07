import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:listgenius/src/screens/data_base/crud_actividades.dart';
import 'package:listgenius/src/screens/data_base/crud_notas.dart';
// import 'package:listgenius/src/screens/data_base/crud_viaje.dart';

class ViajeDetails extends StatefulWidget {
  const ViajeDetails({super.key,});

  @override
  State<ViajeDetails> createState() => _ViajeDetailsState();
}

class _ViajeDetailsState extends State<ViajeDetails> {
  Actividad? _actividad;
  //Contacto? _contacto;
  //Preparativo? _preparativo;
  // Viaje? _viaje;
  // Nota? _nota;
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
    //Contacto? contacto = await ContactosCRUD().getContactoById(id);
    //Preparativo? preparativo = await PreparativosCRUD().getPreparativoById(id);
    // Viaje? viaje  = await ViajesCRUD().getViajeById(id);
    // Nota? nota = await NotasCRUD().getNotaById(id);
    if(mounted){
      setState(() {
      _actividad = actividad;
      //_contacto = contacto;
      //_preparativo = preparativo;
      // _viaje =  viaje;
      // _nota = nota;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NOTA"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: const Icon(IconlyLight.edit_square), onPressed: () => _edit(context)),
          IconButton(icon: const Icon(IconlyLight.delete), onPressed: () => _delete(context)),
        ],
      ),
      body: _verDetalles(context),
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
                    child: Image.asset("assets/images/notaimg.png"),
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
                    const Text("Nota:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    Text('${_actividad?.titulo}',style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 8),
                    // const Text("Descripción:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                    // Text('${_actividad?.descripcion}',style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                    // const SizedBox(height: 8),
                  ]),
                ),
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
    Navigator.of(context).pushNamed("/viaje",arguments: '$id');
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
                // ViajesCRUD().deleteViaje(id);
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

