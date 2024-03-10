import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:listgenius/src/screens/data_base/crud_actividades.dart';
// import 'package:listgenius/src/screens/data_base/crud_contactos.dart';
import 'package:listgenius/src/screens/data_base/crud_notas.dart';
// import 'package:listgenius/src/screens/data_base/crud_preparativos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';

class EventoPage extends StatefulWidget {
  const EventoPage({super.key});

  @override
  State<EventoPage> createState() => _EventoPageState();
}

class _EventoPageState extends State<EventoPage> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _taskNotas = [];
  List<TextEditingController> notasControllers = [];


  bool isListening = false;
  SpeechToText  speechRecognizer = SpeechToText();
  
  int id = 0;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  final _tituloController = TextEditingController();
  final _lugarController = TextEditingController();
  // final _contactoController = TextEditingController();
  // final _preparativoController = TextEditingController();
  String _fecha = "0000/00/00";
  String _hora = "00:00";
  String nivelDeImportancia = "Normal";
  // final _notasController = TextEditingController();
  bool bandera=true;
  String boton="Guardar";
  int opcionColor=1;
  late Actividad actividad0;
  // late Contacto contacto0;
  // late Preparativo preparativo0;
  List<Nota> notas = [];
  // late Nota nota0;
  bool bandera2 = true;
  bool bandera3 = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final name = ModalRoute.of(context)?.settings.arguments;
    id = int.parse(name.toString());
      //if (id != 0) {id++;}else{id--;};
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)?.settings.arguments;
    id = int.parse(name.toString());
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xffa37437),
        title: const Text('Agregar Nuevo Evento'),
        centerTitle: true,
        actions: <Widget>[
           IconButton(icon: const Icon(Icons.save), onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                            if(id==0){
                              int id0 = 0;
                              String? id2 = '';
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              //.setString('ID', id2);
                              id2 = prefs.getString('ID');
                              id0 = int.parse(id2!);
                              id0++;
                              prefs.setString('ID', '$id0');
                              Actividad actividad = Actividad(
                                idActividad: id0,
                                categoria: "Evento",
                                titulo:_tituloController.text,
                                // descripcion: _descripcionController.text,
                                nivelDeImportancia: nivelDeImportancia,
                                realizado: "no",
                                fecha: _fecha,
                                hora: _hora,
                                lugar: _lugarController.text,
                                horario1: "00:00",
                                horario2: "00:00",
                                color: opcionColor,
                              );
                              await ActividadesCRUD().insertActividad(actividad);
                              for (TextEditingController controller in notasControllers) {
                                Nota  nota = Nota(
                                  nota: controller.text,
                                  idActividad: id0,
                                );
                                // await NotasCRUD().insertNota(nota);
                                if(controller.text.isNotEmpty){await NotasCRUD().insertNota(nota);}
                              }
                            }else{
                              actividad0.titulo=_tituloController.text;
                              // actividad0.descripcion=_descripcionController.text;
                              actividad0.nivelDeImportancia=nivelDeImportancia;
                              actividad0.fecha=_fecha;
                              actividad0.hora=_hora;
                              actividad0.lugar=_lugarController.text;
                              actividad0.color=opcionColor;
                              // contacto0.contacto="";//_contactoController.text;
                              // preparativo0.preparativo="";//_preparativoController.text;
                              // nota0.nota="";//_notasController.text;
                              await ActividadesCRUD().updateActividad(actividad0);
                              // await ContactosCRUD().updateContacto(contacto0);
                              // await PreparativosCRUD().updatePreparativo(preparativo0);
                              NotasCRUD().deleteNota(id);
                              for (TextEditingController controller in notasControllers) {
                                Nota  nota = Nota(
                                  nota: controller.text,
                                  idActividad: id,
                                );
                                if(controller.text.isNotEmpty){await NotasCRUD().insertNota(nota);}
                              }
                              // await NotasCRUD().updateNota(nota0);
                            }
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
           }),
        ],
      ),
      body: _showActividad(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        glowRadiusFactor: 4.0,
        animate: isListening,
        duration: const Duration(milliseconds: 2000),
        glowColor: Colors.blue,
        repeat: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if(!isListening){
              bool available = await speechRecognizer.initialize();
              if(available){
                setState(() {
                  isListening = true;bandera2=false;bandera3=false;
                  speechRecognizer.listen(
                    onResult: (result) {
                      // _text = result.recognizedWords;
                      _tituloController.text=result.recognizedWords;
                    }
                  );
                });
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              isListening = false;
            });
            speechRecognizer.stop();
          },
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 30,
            child: Icon(!isListening ? Icons.mic : Icons.stop,color: Colors.white,),
            ),
        ),
      ),

    );
  }


  @override
  void dispose() {
    _tituloController.dispose();
    for (TextEditingController controller in notasControllers) {
      controller.dispose();
    }
    _lugarController.dispose();
    super.dispose();
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
      actividad0 = actividad!;
      // contacto0 = contacto!;
      // preparativo0 = preparativo!;
      notas=nota2;
      // nota0 = nota!;
      _tituloController.text=actividad.titulo;
      // _descripcionController.text=actividad.descripcion;
      nivelDeImportancia=actividad.nivelDeImportancia;
      _fecha=actividad.fecha;
      _hora=actividad.hora;
      _lugarController.text=actividad.lugar;
      // _contactoController.text=contacto.contacto;
      // _preparativoController.text=preparativo.preparativo;
      // _notasController.text=nota.nota;
      _selectedDate=DateTime.parse('$_fecha''T05:00:00.000Z');
      _selectedTime = TimeOfDay(hour:int.parse(_hora.split(":")[0]),minute: int.parse(_hora.split(":")[1]));
      bandera=false;
      boton = "Actualizar";
    });
    }
  }
  
 _notas(BuildContext context){
  if(id==0){
        for (int i = 0; i < _taskNotas.length + 1; i++) {
          TextEditingController notasController = TextEditingController();
          notasControllers.add(notasController);
        }
    return Container(
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
          for (int i = 0; i < _taskNotas.length+ 1; i++) ...[
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: notasControllers[i],
                      decoration: InputDecoration(
                        labelText: 'Nota ${i + 1}',
                      ),
                    ),
                  ),
                  IconButton(
                    // ignore: prefer_const_constructors
                    icon: i == _taskNotas.length ? Icon(Icons.add) : Icon(Icons.close_outlined),
                    onPressed: () {
                      if(i == _taskNotas.length){
                        setState(() {
                          _taskNotas.add('');
                          notasControllers.add(TextEditingController());
                        });
                      }else{
                        setState(() {
                          _taskNotas.remove(_taskNotas[i]);
                          notasControllers.removeAt(i);
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          ],  
        ],
      ),
    );}
    else{
      if(bandera3){
      for (int i = 0; i < notas.length +1; i++){
        TextEditingController notasController = TextEditingController();
        if(i != notas.length){_taskNotas.add(''); notasController.text=notas[i].nota;}
        notasControllers.add(notasController);
      }
      notasControllers.removeAt(0);
      TextEditingController notasController = TextEditingController();
      notasControllers.add(notasController);
      }
      return Container(
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
          for (int i = 0; i < _taskNotas.length+ 1; i++) ...[
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: notasControllers[i],
                      decoration: InputDecoration(
                        labelText: 'Nota ${i + 1}',
                      ),
                    ),
                  ),
                  IconButton(
                    // ignore: prefer_const_constructors
                    icon: i == _taskNotas.length ? Icon(Icons.add) : Icon(Icons.close_outlined),
                    onPressed: () {
                      if(i == _taskNotas.length){
                        setState(() {
                          bandera2=false;bandera3=false;
                          _taskNotas.add('');
                          notasControllers.add(TextEditingController());
                        });
                      }else{
                        setState(() {
                          bandera2=false;bandera3=false;
                          _taskNotas.remove(_taskNotas[i]);
                          notasControllers.removeAt(i);
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          ],  
        ],
      ),
    );
    }
  }


  _showActividad(BuildContext context) {
    if (id != 0){
      if(bandera){
        _loadActividad();
      }
    }
    _fecha=_selectedDate.toString();
    _fecha=_fecha.substring(0,10);
    _hora=_selectedTime.toString();
    _hora=_hora.substring(10,15);
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(right: 60, left: 60),
                child: SizedBox(          
                  child: Image.asset("assets/images/eventoimg.png"),
                ),
              ),
            _colores(),
            Container(
              // margin: const EdgeInsets.all(60),
              margin: const EdgeInsets.only(right: 60, left: 60,top: 10),
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
              child: Form(
                key: _formKey,
                // child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: _tituloController,
                          decoration: const InputDecoration(
                            labelText: 'Evento',
                            // hintStyle: TextStyle(color: Colors.black),
                            hintText: '¿Cuál es su Evento?',
                            //prefixIcon: Icon(Icons.title),
                            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.blue),
                            )
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Primero ingrese el nombre del su evento';
                            }
                              return null;
                          },
                            //maxLines: null,
                        ),
                        const SizedBox(height: 10.0),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Nivel de importancia',
                            // hintStyle: TextStyle(color: Colors.black),
                             contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.blue),
                              )
                          ),
                          value: 'Normal',                
                          // DropdownButton(items: [DropdownMenuItem(child: child)]),
                          items: const [
                            DropdownMenuItem(
                              value: 'Normal',
                              child: Text('Normal'),
                            ),
                            DropdownMenuItem(
                              value: 'Alto',
                              child: Text('Alto'),
                            ),
                            DropdownMenuItem(
                              value: 'Crítico',
                              child: Text('Crítico'),
                            ),
                          ], 
                          onChanged: (String? value) {
                            setState(() {
                              nivelDeImportancia = value!;bandera2=false;bandera3=false;
                            });
                          },
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ElevatedButton(
                              style: const ButtonStyle(
                                padding: MaterialStatePropertyAll(EdgeInsets.only(right: 20, left: 20)),
                              ),
                              onPressed: () async {
                                DateTime? date = await showDatePicker(
                                  context: context,
                                  initialDate: _selectedDate,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030),
                                );
                                if (date != null) {
                                  setState(() {
                                    _selectedDate = date;bandera2=false;bandera3=false;
                                    // _fecha=_selectedDate.toString();
                                    // _fecha=_fecha.substring(0,10);
                                  });
                                }
                              },
                              child: Text(
                                _fecha
                              ),
                            ),
                            ElevatedButton(
                              style: const ButtonStyle(
                                padding: MaterialStatePropertyAll(EdgeInsets.only(right: 40, left: 40)),
                              ),
                              onPressed: () async {
                                TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: _selectedTime,
                                );
                                if (time != null) {
                                  setState(() {
                                    _selectedTime = time;bandera2=false;bandera3=false;
                                    // _hora=_selectedTime.toString();
                                    // _hora=_hora.substring(10,15);
                                    //_hora='${_selectedTime.hour}:${_selectedTime.minute}';
                                  });
                                }
                              },
                              child: Text(
                                _hora
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: _lugarController,
                          decoration: const InputDecoration(
                            labelText: 'Lugar',
                            // hintStyle: TextStyle(color: Colors.black),
                            hintText: '¿Cuál es el lugar de su Evento?',
                            //prefixIcon: Icon(Icons.title),
                            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.blue),
                            )
                          ),
                          maxLines: null,
                        ),
                        const SizedBox(height: 10.0),
                        _notas(context),                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: <Widget>[
                        //     ElevatedButton(
                        //       style: const ButtonStyle(
                        //         padding: MaterialStatePropertyAll(EdgeInsets.only(right: 10, left: 10)),
                        //       ),
                        //       onPressed: () async {                        
            
                        //       },
                        //       child: Text(boton),
                        //     ),
                        //     ElevatedButton(
                        //       style: const ButtonStyle(
                        //         padding: MaterialStatePropertyAll(EdgeInsets.only(right:10, left: 10)),
                        //       ),
                        //       onPressed: () async {
                        //         Navigator.pop(context);
                        //       },
                        //       child: const Text('Cancelar'),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                // ),
              ),
            ),
          ],
        ),
      );
  }

  _colores() {
    return Container(
      margin: const EdgeInsets.only(right: 60, left: 60),
                // decoration: const BoxDecoration(
                //             // color: Color(0xff63d3ff),
                //             borderRadius:  BorderRadius.all(Radius.circular(10)), 
                //             border: Border(
                //               bottom: BorderSide(color: Colors.blue),
                //               right: BorderSide(color: Colors.blue),
                //               left: BorderSide(color: Colors.blue),
                //               top: BorderSide(color: Colors.blue),
                //             ),
                //           ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          opcionColor = 1;bandera2=false;bandera3=false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff59D5E0),//blue
                          shape: BoxShape.circle,
                          border: Border.all(color:  Colors.blue, width: 1)
                        ),
                        child: Icon(
                          Icons.check,
                          color: opcionColor == 1 ? Colors.white : Colors.transparent,
                        ),
                      ),
                    ),
                    //
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          opcionColor = 2;bandera2=false;bandera3=false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff15F5BA),//menta
                          shape: BoxShape.circle,
                          border: Border.all(color:  Colors.blue, width: 1)
                        ),
                        child: Icon(
                          Icons.check,
                          color: opcionColor == 2 ? Colors.white : Colors.transparent,
                        ),
                      ),
                    ),
                    //
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          opcionColor = 3;bandera2=false;bandera3=false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff9BCF53),//green
                          shape: BoxShape.circle,
                          border: Border.all(color:  Colors.blue, width: 1)
                        ),
                        child: Icon(
                          Icons.check,
                          color: opcionColor == 3 ? Colors.white : Colors.transparent,
                        ),
                      ),
                    ),
                    //
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          opcionColor = 4;bandera2=false;bandera3=false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffF5DD61),//yellow
                          shape: BoxShape.circle,
                          border: Border.all(color:  Colors.blue, width: 1)
                        ),
                        child: Icon(
                          Icons.check,
                          color: opcionColor == 4 ? Colors.white : Colors.transparent,
                        ),
                      ),
                    ),
                    //
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          opcionColor = 5;bandera2=false;bandera3=false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffFF8080),
                          shape: BoxShape.circle,
                          border: Border.all(color:  Colors.blue, width: 1)
                        ),
                        child: Icon(
                          Icons.check,
                          color: opcionColor == 5 ? Colors.white : Colors.transparent,
                        ),
                      ),
                    ),
                    //
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          opcionColor = 6;bandera2=false;bandera3=false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffAD88C6),
                          shape: BoxShape.circle,
                          border: Border.all(color:  Colors.blue, width: 1)
                        ),
                        child: Icon(
                          Icons.check,
                          color: opcionColor == 6 ? Colors.white : Colors.transparent,
                        ),
                      ),
                    ),
                  ]
                ),
    );
  }
  
}