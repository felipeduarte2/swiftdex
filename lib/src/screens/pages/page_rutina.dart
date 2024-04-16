import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:listgenius/src/screens/data_base/crud_actividades.dart';
import 'package:listgenius/src/screens/data_base/crud_detalles.dart';
import 'package:listgenius/src/screens/data_base/crud_dias.dart';
import 'package:listgenius/src/screens/data_base/crud_notas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';


class RutinaPage extends StatefulWidget {
  const RutinaPage({super.key});

  @override
  State<RutinaPage> createState() => _RutinaPageState();
}

class _RutinaPageState extends State<RutinaPage> {
  final _formKey = GlobalKey<FormState>();

  // Listas de string para las subtares y las notas
  final List<String> _taskList = [];
  final List<String> _taskNotas = [];

  // Listas de controladores para los controllers de las subtareas y las notas
  List<TextEditingController> textControllers = [];
  List<TextEditingController> notasControllers = [];

  // obejeto pra la clase SpeechToText y el bool para el estado del microndelfo
  bool isListening = false;
  SpeechToText  speechRecognizer = SpeechToText();

  // Variables para las hora
  TimeOfDay _selectedTime1 = TimeOfDay.now();
  TimeOfDay _selectedTime2 = TimeOfDay.now();

  // Variable para el id de la tarea a editar o null si es nueva
  int id = 0;

  //Controller para el titulo  
  final _tituloController = TextEditingController();

  //Variables para los datos compartidos entre las pantallas
  String nivelDeImportancia = "Normal";
  String _hora1 = "00:00";
  String _hora2 = "00:00";
  String lunes = "no";
  String martes = "no";
  String miercoles = "no";
  String jueves = "no";
  String viernes = "no";
  String sabado = "no";
  String domingo = "no";
  bool lu = false;
  bool ma = false;
  bool mi = false;
  bool ju = false;
  bool vi = false;
  bool sa = false;
  bool dom = false;
  bool bandera=true;
  String boton="Guardar";
  int opcionColor=1;

  //Variables para las actualizaciones
  late Actividad actividad0;

  // variables para el focusnode, que nos permite manejar el foco de los campos
  FocusNode titulo = FocusNode();
  FocusNode nivel = FocusNode();
  List<FocusNode> focusNodes = [];
  List<FocusNode> notasNodes = [];

  // Variables para el contador del texto en cada campo
  int contador = 1;

  //Variables para los detalles de las notas
  List<Detalle> detalles = [];
  List<Nota> notas = [];
 
  late Dia dia0;
  bool bandera2 = true;
  bool bandera3 = true;

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   final name = ModalRoute.of(context)?.settings.arguments;
  //   id = int.parse(name.toString());
  //     //if (id != 0) {id++;}else{id--;};
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)?.settings.arguments;
    id = int.parse(name.toString());
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xffa37437),
        title: const Text('Agregar Nueva Rutina'),
        centerTitle: true,
        actions: <Widget>[
           IconButton(icon: const Icon(IconlyLight.tick_square), onPressed: () async {
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
                                categoria: "Rutina",
                                titulo:_tituloController.text,
                                nivelDeImportancia: nivelDeImportancia,
                                realizado: "no",
                                fecha: "2000-00-00",
                                hora: "00:00",
                                lugar:"" "sin lugar",
                                horario1: _hora1,
                                horario2: _hora2,
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
                              }
                              Dia dia = Dia(
                                idActividad: id0,
                                lunes: lunes,
                                martes: martes,
                                miercoles: miercoles,
                                jueves: jueves,
                                viernes: viernes,
                                sabado: sabado,
                                domingo: domingo,
                              );
                              await DiasCRUD().insertDia(dia);
                              for (TextEditingController controller in notasControllers) {
                                Nota  nota = Nota(
                                  nota: controller.text,
                                  idActividad: id0,
                                );
                                if(controller.text.isNotEmpty){await NotasCRUD().insertNota(nota);}
                              }
                            }
                            else{
                              actividad0.titulo=_tituloController.text;
                              actividad0.nivelDeImportancia=nivelDeImportancia;
                              actividad0.horario1=_hora1;
                              actividad0.horario2=_hora2;
                              actividad0.color=opcionColor;
                              dia0.lunes=lunes;
                              dia0.martes=martes;
                              dia0.miercoles=miercoles;
                              dia0.jueves=jueves;
                              dia0.viernes=viernes;
                              dia0.sabado=sabado;
                              dia0.domingo=domingo;
                              await ActividadesCRUD().updateActividad(actividad0);
                              await DiasCRUD().updateDia(dia0);
                              DetallesCRUD().deleteDetalle(id);
                              for (TextEditingController controller in textControllers) {
                                Detalle detalle =  Detalle(
                                  detalle: controller.text,
                                  realizado: "no",
                                  idActividad: id,
                                );
                                if(controller.text.isNotEmpty){await DetallesCRUD().insertDetalle(detalle);}
                              }
                              NotasCRUD().deleteNota(id);
                              for (TextEditingController controller in notasControllers) {
                                Nota  nota = Nota(
                                  nota: controller.text,
                                  idActividad: id,
                                );
                                if(controller.text.isNotEmpty){await NotasCRUD().insertNota(nota);}
                              }
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
    for (TextEditingController controller in textControllers) {
      controller.dispose();
    }
    for (TextEditingController controller in notasControllers) {
      controller.dispose();
    }
    // _detallesController.dispose();
    // _notasController.dispose();
    super.dispose();
  }

  Future<void> _loadActividad() async {
    final name = ModalRoute.of(context)?.settings.arguments;
    id = int.parse(name.toString());

    Actividad? actividad = await ActividadesCRUD().getActividadById(id);
    List<Detalle> detalle2 = await DetallesCRUD().getAllDetallesById(id);
    List<Nota> nota2 = await  NotasCRUD().getAllNotasById(id);

    // Detalle? detalle  = await DetallesCRUD().getDetalleById(id);
    Dia? dia = await DiasCRUD().getDiaById(id);
    // Nota? nota = await NotasCRUD().getNotaById(id);
    if(mounted){
      setState(() {
        actividad0 = actividad!;
        dia0  = dia!;
        detalles =detalle2;
        notas=nota2;
        _tituloController.text=actividad.titulo;
        nivelDeImportancia=actividad.nivelDeImportancia;
        _hora1=actividad.horario1;
        _hora2=actividad.horario2;
        _selectedTime1== TimeOfDay(hour:int.parse(_hora1.split(":")[0]),minute: int.parse(_hora1.split(":")[1]));
        _selectedTime2== TimeOfDay(hour:int.parse(_hora2.split(":")[0]),minute: int.parse(_hora2.split(":")[1]));
        if(dia.lunes=="si"){lu=true;lunes="si";}
        if(dia.martes=="si"){lu=true;martes="si";}
        if(dia.miercoles=="si"){mi=true;miercoles="si";}
        if(dia.jueves=="si"){ju=true;jueves="si";}
        if(dia.viernes=="si"){vi=true;viernes="si";}
        if(dia.sabado=="si"){sa=true;sabado="si";}
        if(dia.domingo=="si"){dom=true;domingo="si";}
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
          const Text('Detalles',style: TextStyle(fontSize: 18) ),
          for (int i = 0; i < _taskList.length+ 1; i++) ...[
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: textControllers[i],
                      decoration: InputDecoration(
                        labelText: 'Detalle ${i + 1}',
                        prefixIcon: const Icon(IconlyLight.bookmark),
                      ),
                    ),
                  ),
                  IconButton(
                    // ignore: prefer_const_constructors
                    icon: i == _taskList.length ?  Icon(IconlyLight.plus) : Icon(IconlyLight.close_square),
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
    );}
    else{
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
                        prefixIcon: const Icon(IconlyLight.bookmark),
                      ),
                    ),
                  ),
                  IconButton(
                    // ignore: prefer_const_constructors
                    icon: i == _taskList.length ?  Icon(IconlyLight.plus) : Icon(IconlyLight.close_square),
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
                        prefixIcon: const Icon(IconlyLight.paper),
                      ),
                    ),
                  ),
                  IconButton(
                    // ignore: prefer_const_constructors
                    icon: i == _taskNotas.length ? Icon(IconlyLight.plus) : Icon(IconlyLight.close_square),
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
                        prefixIcon: const Icon(IconlyLight.paper),
                      ),
                    ),
                  ),
                  IconButton(
                    // ignore: prefer_const_constructors
                    icon: i == _taskNotas.length ? Icon(IconlyLight.plus) : Icon(IconlyLight.close_square),
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
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 60, left: 60),
              child: SizedBox(          
                child: Image.asset("assets/images/rutinaimg.png"),
              ),
            ),
            _colores(),
            Container(
              margin: const EdgeInsets.only(right: 30, left: 30,top: 10),
              decoration: const BoxDecoration(
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: _tituloController,
                          decoration: const InputDecoration(
                            labelText: 'Rutina',
                            hintText: '¿Cual es su Rutina?',
                            prefixIcon: Icon(IconlyLight.document),
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
                              return 'Por favor ingrese un título';
                            }
                              return null;
                          },
                            //maxLines: null,
                        ),
                        const SizedBox(height: 10.0),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Nivel de importancia',
                            prefixIcon: Icon(IconlyLight.category),
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
                        const Text("Horario",style: TextStyle(fontSize: 18)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ElevatedButton(
                              style: const ButtonStyle(
                                padding: MaterialStatePropertyAll(EdgeInsets.only(right: 20, left: 20)),
                              ),
                              onPressed: () async {
                                TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: _selectedTime1,
                                );
                                if (time != null) {
                                  setState(() {
                                    _selectedTime1 = time;bandera2=false;bandera3=false;
                                    _hora1=_selectedTime1.toString();
                                    _hora1=_hora1.substring(10,15);
                                    //_hora='${_selectedTime.hour}:${_selectedTime.minute}';
                                  });
                                }
                              },
                              child: Text(_hora1 ),
                            ),
                            ElevatedButton(
                              style: const ButtonStyle(
                                padding: MaterialStatePropertyAll(EdgeInsets.only(right: 20, left: 20)),
                              ),
                              onPressed: () async {
                                TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: _selectedTime2,
                                );
                                if (time != null) {
                                  setState(() {
                                    _selectedTime2 = time;bandera2=false;bandera3=false;
                                    _hora2=_selectedTime2.toString();
                                    _hora2=_hora2.substring(10,15);
                                    //_hora='${_selectedTime.hour}:${_selectedTime.minute}';
                                  });
                                }
                              },
                              child: Text(_hora2),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        _subtareas(context),
                        const Text("Dias",style: TextStyle(fontSize: 18)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: lu, 
                                      autofocus: true,
                                      onChanged: (value) {setState(() {lu  = value!;if(value == true){lunes="si";}else{lunes= "no";bandera2=false;bandera3=false;}});},
                                    ),
                                    const Text("Lunes      "),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: mi, 
                                      onChanged: (value) {setState(() {mi  = value!;if(value == true){miercoles="si";}else{miercoles= "no";bandera2=false;bandera3=false;}});},
                                    ),
                                    const Text("Miércoles"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: vi, 
                                      onChanged: (value) {setState(() {vi  = value!;if(value == true){viernes="si";}else{viernes= "no";bandera2=false;bandera3=false;}});},
                                    ),
                                    const Text("Viernes   "),
                                  ],
                                ),
                                 Row(
                                  children: [
                                     Checkbox(
                                      value: dom, 
                                      onChanged: (value) {setState(() {dom = value!;if(value == true){domingo="si";}else{domingo= "no";bandera2=false;bandera3=false;}});},
                                    ),
                                    const Text("Domingo"),
                                  ],
                                ),
                              ],
                            ),
                            Column(
            
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    //
                                    Checkbox(
                                      value: ma, 
                                      onChanged: (value) {setState(() {ma  = value!;if(value == true){martes="si";}else{martes= "no";bandera2=false;bandera3=false;}});},
                                    ),
                                    const Text("Martes  "),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: ju, 
                                      onChanged: (value) {setState(() {ju  = value!; if(value == true){jueves="si";}else{jueves= "no";bandera2=false;bandera3=false;}});},
                                    ),
                                    const Text("Jueves "),
                                  ],
                                ),
                                 Row(
                                  children: [
                                    Checkbox(
                                      value: sa, 
                                      onChanged: (value) {setState(() {sa  = value!;if(value == true){sabado="si";}else{sabado= "no";bandera2=false;bandera3=false;}});},
                                    ),
                                    const Text("Sabado"),
                                  ],
                                ),
                                const SizedBox(height: 50,)
                              ],
                            ),                      
                            // const SizedBox(width: 10.0,),
                            
                          ]
                        ),
                        const SizedBox(height: 10.0),
                        _notas(context),
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