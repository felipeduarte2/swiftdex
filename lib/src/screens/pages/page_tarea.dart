import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:listgenius/src/screens/data_base/crud_actividades.dart';
import 'package:listgenius/src/screens/data_base/crud_detalles.dart';
import 'package:listgenius/src/screens/data_base/crud_notas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TareaPage extends StatefulWidget {
  const TareaPage({super.key});

  @override
  State<TareaPage> createState() => _TareaPageState();
}

class _TareaPageState extends State<TareaPage> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _taskList = [];
  List<TextEditingController> textControllers = [];
  final List<String> _taskNotas = [];
  List<TextEditingController> notasControllers = [];

  SpeechToText  speechRecognizer = SpeechToText();
  bool isListening = false;
  int id = 0;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final _tituloController = TextEditingController();    
  String _fecha = "0000/00/00";
  String _hora = "00:00";
  String nivelDeImportancia = "Normal";
  bool bandera=true;
  String boton="Guardar";
  int opcionColor=1;
  late Actividad actividad0;
  // late Detalle  detalle0;
  bool bandera2 = true;
  bool bandera3 = true;
  late  Nota nota0;
  List<Detalle> detalles = [];
  List<Nota> notas = [];

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
      // backgroundColor: const Color(0xffede0da),
      appBar: AppBar(
        // backgroundColor: const Color(0xffa37437),
        title: const Text('Agregar Nueva Tarea'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save), 
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                             if(id==0){
                              int id0 = 0;
                              String? id2 = '';
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              //prefs.setString('ID', id);
                              id2 = prefs.getString('ID');
                              id0 = int.parse(id2!);
                              id0++;
                              prefs.setString('ID', '$id0');
                              Actividad actividad = Actividad(
                                idActividad: id0,
                                categoria: "Tarea",
                                titulo:_tituloController.text,
                                // descripcion: _descripcionController.text,
                                nivelDeImportancia: nivelDeImportancia,
                                realizado: "no",
                                fecha: _fecha,
                                hora: _hora,
                                lugar: "sin lugar",
                                horario1: "00:00",
                                horario2: "00:00",
                                color: opcionColor,
                              );
                              await ActividadesCRUD().insertActividad(actividad);
                              for (TextEditingController controller in textControllers) {
                                Detalle detalle =  Detalle(
                                  detalle: controller.text,
                                  realizado: "no",
                                  idActividad: id0,
                                );
                                if(controller.text.isNotEmpty){await DetallesCRUD().insertDetalle(detalle);}
                                // await DetallesCRUD().insertDetalle(detalle);
                              }
                              for (TextEditingController controller in notasControllers) {
                                Nota  nota = Nota(
                                  nota: controller.text,
                                  idActividad: id0,
                                );
                                if(controller.text.isNotEmpty){await NotasCRUD().insertNota(nota);}
                              }
                            }else{
                              actividad0.titulo=_tituloController.text;
                              actividad0.nivelDeImportancia=nivelDeImportancia;
                              actividad0.fecha=_fecha;
                              actividad0.hora=_hora;
                              actividad0.color= opcionColor;
                              await ActividadesCRUD().updateActividad(actividad0);
                              // detalle0.detalle= "";//_detallesController.text;
                              nota0.nota="";//_notasController.text;
                              DetallesCRUD().deleteDetalle(id);
                              for (TextEditingController controller in textControllers) {
                                Detalle detalle =  Detalle(
                                  detalle: controller.text,
                                  realizado: "no",
                                  idActividad: id,
                                );
                                if(controller.text.isNotEmpty){await DetallesCRUD().insertDetalle(detalle);}
                                // await DetallesCRUD().insertDetalle(detalle);
                              }
                              NotasCRUD().deleteNota(id);
                              for (TextEditingController controller in notasControllers) {
                                Nota  nota = Nota(
                                  nota: controller.text,
                                  idActividad: id,
                                );
                                if(controller.text.isNotEmpty){await NotasCRUD().insertNota(nota);}
                              }
                              // await DetallesCRUD().updateDetalle(detalle0);
                              // await NotasCRUD().updateNota(nota0);
                            }
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
              }
            }
          ),
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
                  isListening = true;
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

  Future<void> _loadActividad() async {
    final name = ModalRoute.of(context)?.settings.arguments;
    id = int.parse(name.toString());
    Actividad? actividad = await ActividadesCRUD().getActividadById(id);
    List<Detalle> detalle2 = await DetallesCRUD().getAllDetallesById(id);
    List<Nota> nota2 = await  NotasCRUD().getAllNotasById(id);
    // Detalle? detalle = await  DetallesCRUD().getDetalleById(id);
    Nota? nota = await NotasCRUD().getNotaById(id);
    if(mounted){
      setState(() {
      actividad0 = actividad!;
      detalles =detalle2;
      notas=nota2;
      // detalle0 =detalle!;
      nota0 = nota!;
      _tituloController.text=actividad.titulo;
      // _descripcionController.text=actividad.descripcion;
      nivelDeImportancia=actividad.nivelDeImportancia;
      _fecha=actividad.fecha;
      _hora=actividad.hora;
      // _detallesController.text=detalle.detalle;
      // _notasController.text=nota.nota;
      _selectedDate=DateTime.parse('$_fecha''T05:00:00.000Z');
      _selectedTime = TimeOfDay(hour:int.parse(_hora.split(":")[0]),minute: int.parse(_hora.split(":")[1]));
      bandera=false;
      boton = "Actualizar";
    });
    }
  }

  _subtareas(BuildContext context) {
    if(id==0){
    for (int i = 0; i < _taskList.length + 1; i++) {
      TextEditingController textController = TextEditingController();
      textControllers.add(textController);
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
          const Text('Subtareas',style: TextStyle(fontSize: 18) ),
          for (int i = 0; i < _taskList.length+ 1; i++) ...[
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: textControllers[i],
                      decoration: InputDecoration(
                        labelText: 'Subtarea ${i + 1}',
                      ),
                    ),
                  ),
                  IconButton(
                    // ignore: prefer_const_constructors
                    icon: i == _taskList.length ? Icon(Icons.add) : Icon(Icons.close_outlined),
                    onPressed: () {
                      if(i == _taskList.length){
                        setState(() {
                          _taskList.add('');
                          textControllers.add(TextEditingController());
                        });
                      }else{
                        setState(() {
                          _taskList.remove(_taskList[i]);
                          textControllers.removeAt(i);
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
    }else{
      if(bandera2){
      for (int i = 0; i < detalles.length +1; i++){
        TextEditingController textController = TextEditingController();
        if(i != detalles.length){_taskList.add(''); textController.text=detalles[i].detalle;}
        textControllers.add(textController);
      }
      textControllers.removeAt(0);
      TextEditingController textController = TextEditingController();
      textControllers.add(textController);
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
          const Text('Subtareas',style: TextStyle(fontSize: 18) ),
          for (int i = 0; i < _taskList.length+ 1; i++) ...[
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: textControllers[i],
                      decoration: InputDecoration(
                        labelText: 'Subtarea ${i + 1}',
                      ),
                    ),
                  ),
                  IconButton(
                    // ignore: prefer_const_constructors
                    icon: i == _taskList.length ? Icon(Icons.add) : Icon(Icons.close_outlined),
                    onPressed: () {
                      if(i == _taskList.length){
                        setState(() {
                          bandera2=false;bandera3=false;
                          _taskList.add('');
                          textControllers.add(TextEditingController());
                        });
                      }else{
                        setState(() {
                          bandera2=false;bandera3=false;
                          _taskList.remove(_taskList[i]);
                          textControllers.removeAt(i);
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
    );
    }else{
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
                child: Image.asset("assets/images/tareaimg.png"),
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
                            labelText: 'Tarea',
                            // hintStyle: TextStyle(color: Colors.black),
                            hintText: '¿Cuál es su Tarea?',
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
                              return 'Primero ingrese el nombre de su Tarea';
                            }
                              return null;
                          },
                          // maxLines: null,
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
                              bandera2=false;bandera3=false;
                              nivelDeImportancia = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 10.0),
                        const Text("Fecha y Hora",style: TextStyle(fontSize: 18)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            // const SizedBox(width: 80,),
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
                                    bandera2=false;bandera3=false;
                                    _selectedDate = date;
                                    // _fecha=_selectedDate.toString();
                                    // _fecha=_fecha.substring(0,10);
                                  });
                                }
                              },
                              child: Text(
                                _fecha
                              ),
                            ),
                            // const SizedBox(width: 80,),
                            ElevatedButton(
                              style: const ButtonStyle(
                                padding: MaterialStatePropertyAll(EdgeInsets.only(right: 45, left: 45)),
                              ),
                              onPressed: () async {
                                TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: _selectedTime,
                                );
                                if (time != null) {
                                  setState(() {
                                    bandera2=false;bandera3=false;
                                    _selectedTime = time;
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
                        _subtareas(context),
                        const SizedBox(height: 10.0),
                        _notas(context)
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
                          bandera2=false;bandera3=false;
                          opcionColor = 1;
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
                          bandera2=false;bandera3=false;
                          opcionColor = 2;
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
                          bandera2=false;bandera3=false;
                          opcionColor = 3;
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
                          bandera2=false;bandera3=false;
                          opcionColor = 4;
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
                          bandera2=false;bandera3=false;
                          opcionColor = 5;
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
                          bandera2=false;bandera3=false;
                          opcionColor = 6;
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
  

  @override
  void dispose() {
    _tituloController.dispose();
    for (TextEditingController controller in textControllers) {
      controller.dispose();
    }
    for (TextEditingController controller in notasControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

