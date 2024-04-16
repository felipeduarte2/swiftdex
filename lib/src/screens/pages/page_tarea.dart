import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
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

  // Listas de string para las subtares y las notas
  final List<String> _taskList = [];
  final List<String> _taskNotas = [];

  // Listas de controladores para los controllers de las subtareas y las notas
  List<TextEditingController> textControllers = [];
  List<TextEditingController> notasControllers = [];

  // obejeto pra la clase SpeechToText y el bool para el estado del microndelfo
  SpeechToText  speechRecognizer = SpeechToText();
  bool isListening = false;

  // Variables para la fecha y hora
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  // Variable para el id de la tarea a editar o null si es nueva
  int id = 0;

  //Controller para el titulo  
  final _tituloController = TextEditingController(); 

  //Variables para los datos
  String _fecha = "0000/00/00"; 
  String _hora = "00:00";
  String nivelDeImportancia = "Normal"; 
  bool bandera=true;
  String boton="Guardar"; int opcionColor=1;

  //Variables para las actualizaciones
  late Actividad actividad0;
  // late  Nota nota0;


  bool bandera2 = true;
  bool bandera3 = true;
  
  //Variables para los detalles de las notas
  List<Detalle> detalles = [];
  List<Nota> notas = [];

  // variables para el focusnode, que nos permite manejar el foco de los campos
  FocusNode titulo = FocusNode();
  FocusNode nivel = FocusNode();
  List<FocusNode> focusNodes = [];
  List<FocusNode> notasNodes = [];


  // Variables para el contador del texto en cada campo
  int contador = 1;
  // TextEditingController selectedFieldController = TextEditingController();
  // FocusNode currentFocusNode = FocusNode();


  @override
  void initState() {
    // currentFocusNode = titulo;
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   final name = ModalRoute.of(context)?.settings.arguments;
  //   id = int.parse(name.toString());
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    
    //obetner el id de la tarea a editar si es que hay alguna
    final name = ModalRoute.of(context)?.settings.arguments;
    id = int.parse(name.toString());

    return Scaffold(

      // AppBar
      appBar: AppBar(
        title: const Text('Agregar Nueva Tarea'),
        centerTitle: true,
        actions: <Widget>[

          // Icono para agregar una nueva tarea o actualiza
          IconButton(
            icon: const Icon(IconlyLight.tick_square),

            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if(id==0){
                  int id0 = 0;
                  String? id2 = '';
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  id2 = prefs.getString('ID');
                  id0 = int.parse(id2!);
                  id0++;
                  prefs.setString('ID', '$id0');

                  Actividad actividad = Actividad(
                    idActividad: id0,
                    categoria: "Tarea",
                    titulo:_tituloController.text,
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

                }
                else{

                  actividad0.titulo=_tituloController.text;
                  actividad0.nivelDeImportancia=nivelDeImportancia;
                  actividad0.fecha=_fecha;
                  actividad0.hora=_hora;
                  actividad0.color= opcionColor;
                  await ActividadesCRUD().updateActividad(actividad0);

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
            }
          ),
        ],
      ),


      // Body
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
                       _tituloController.text+=result.recognizedWords;
                      // if(contador==1){
                      //   _tituloController.text+=result.recognizedWords;
                      // }else if(contador>1 && contador<textControllers.length+2){
                      //   textControllers[contador-2].text+=result.recognizedWords;
                      // }else {
                      //   notasControllers[contador-2-textControllers.length].text+=result.recognizedWords;
                      // }
                      //selectedFieldController.text+=result.recognizedWords;
                      // _moveToNextField(selectedFieldController);
                      // _text = result.recognizedWords;
                      // if(contador==1){
                      //   _tituloController.text+=" ${result.recognizedWords}";
                      // }
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

    if(mounted){
      setState(() {
      actividad0 = actividad!;
      detalles =detalle2;
      notas=nota2;
      // nota0 = nota!;
      _tituloController.text=actividad.titulo;
      nivelDeImportancia=actividad.nivelDeImportancia;
      _fecha=actividad.fecha;
      _hora=actividad.hora;
      _selectedDate=DateTime.parse('$_fecha''T05:00:00.000Z');
      _selectedTime = TimeOfDay(hour:int.parse(_hora.split(":")[0]),minute: int.parse(_hora.split(":")[1]));
      bandera=false;
      boton = "Actualizar";
    });
    }

  }

  Container _subtareas(BuildContext context) {

    if(id==0){

    if(_taskList.isEmpty){
      for (int i = 0; i < _taskList.length + 1; i++) {
        TextEditingController textController = TextEditingController();
        textControllers.add(textController);
      }
      focusNodes = List<FocusNode>.generate(_taskList.length + 1, (index) =>  FocusNode());
    }

    return Container(


      decoration: const BoxDecoration(
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
                      focusNode: focusNodes[i],
                      controller: textControllers[i],
                      onTap: () {
                        contador = i +2;
                        // setState(() {
                        //   selectedFieldController = textControllers[i];
                        // });
                      },
                      decoration: InputDecoration(
                        labelText: 'Subtarea ${i + 1}',
                        prefixIcon: const Icon(IconlyLight.bookmark),
                      ),
                      onEditingComplete: (){
                        contador ++;
                        if(i != focusNodes.length - 1){requestFocus(context, focusNodes[i+1]);}
                        else{requestFocus(context, notasNodes[0]);}
                      },
                    ),
                  ),


                  IconButton(
                    // ignore: prefer_const_constructors
                    icon: i == _taskList.length ? Icon(IconlyLight.plus) : Icon(IconlyLight.close_square),
                    onPressed: () {
                      if(i == _taskList.length){
                        setState(() {
                          _taskList.add('');
                          textControllers.add(TextEditingController());
                          focusNodes.add(FocusNode());
                        });
                      }else{
                        setState(() {
                          _taskList.remove(_taskList[i]);
                          textControllers.removeAt(i).dispose();
                          focusNodes.removeAt(i).dispose();
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
    else{

      if(_taskList.isEmpty && bandera2 == true){
        for (int i = 0; i < detalles.length +1; i++){
          TextEditingController textController = TextEditingController();
          if(i != detalles.length){_taskList.add(''); textController.text=detalles[i].detalle;}
          textControllers.add(textController);
        }
        focusNodes = List<FocusNode>.generate(_taskList.length + 1, (index) =>  FocusNode());
        textControllers.removeAt(0);
        focusNodes.removeAt(0);
        textControllers.add(TextEditingController());
        focusNodes.add(FocusNode());
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
                      focusNode: focusNodes[i],
                      decoration: InputDecoration(
                        labelText: 'Subtarea ${i + 1}',
                        prefixIcon: const Icon(IconlyLight.bookmark),
                      ),
                      onEditingComplete: (){
                        if(i != focusNodes.length - 1){requestFocus(context, focusNodes[i+1]);}
                        else{requestFocus(context, notasNodes[0]);}
                      },
                    ),
                  ),


                  IconButton(
                    // ignore: prefer_const_constructors
                    icon: i == _taskList.length ? Icon(IconlyLight.plus) : Icon(IconlyLight.close_square),
                    onPressed: () {
                      if(i == _taskList.length){
                        setState(() {
                          _taskList.add('');
                          textControllers.add(TextEditingController());
                          focusNodes.add(FocusNode());
                        });
                      }else{
                        setState(() {
                          _taskList.remove(_taskList[i]);
                          textControllers.removeAt(i).dispose();
                          focusNodes.removeAt(i).dispose();
                          bandera2 = false;
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

  Container _notas(BuildContext context){
    if(id==0){

      if(_taskNotas.isEmpty){
        for (int i = 0; i < _taskNotas.length + 1; i++) {
          TextEditingController notasController = TextEditingController();
          notasControllers.add(notasController);
        }
        notasNodes = List<FocusNode>.generate(_taskNotas.length + 1, (index) =>  FocusNode());
      }


    return Container(

      decoration: const BoxDecoration(
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
                      focusNode: notasNodes[i],
                      onTap: () {
                        contador = i + 2 + textControllers.length;
                        // setState(() {
                        //   selectedFieldController = notasControllers[i];
                        // });
                      },
                      decoration: InputDecoration(
                        labelText: 'Nota ${i + 1}',
                        prefixIcon: const Icon(IconlyLight.paper),
                      ),
                      onEditingComplete: (){
                        contador++;
                        if(i != notasNodes.length - 1){requestFocus(context, notasNodes[i+1]);}
                      },
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
                          notasNodes.add(FocusNode());
                        });
                      }else{
                        setState(() {
                          _taskNotas.remove(_taskNotas[i]);
                          notasControllers.removeAt(i).dispose();
                          notasNodes.removeAt(i).dispose();
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
    
    else{

      if(_taskNotas.isEmpty && bandera3 == true){
        for (int i = 0; i < notas.length +1; i++){
          TextEditingController notasController = TextEditingController();
          if(i != notas.length){_taskNotas.add(''); notasController.text=notas[i].nota;}
          notasControllers.add(notasController);
        }
        notasNodes = List<FocusNode>.generate(_taskNotas.length + 1, (index) =>  FocusNode());
        notasControllers.removeAt(0);
        notasControllers.add(TextEditingController());
        // notasNodes.removeAt(0);
        // notasNodes.add(FocusNode());
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
                      focusNode: notasNodes[i],
                      decoration: InputDecoration(
                        labelText: 'Nota ${i + 1}',
                        prefixIcon: const Icon(IconlyLight.paper),
                      ),
                      onEditingComplete: (){
                        if(i != notasNodes.length - 1){requestFocus(context, notasNodes[i+1]);}
                      },
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
                          notasNodes.add(FocusNode());
                        });
                      }else{
                        setState(() {
                          _taskNotas.remove(_taskNotas[i]);
                          notasControllers.removeAt(i).dispose();
                          notasNodes.removeAt(i).dispose();
                          bandera3 = false;
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
              margin: const EdgeInsets.only(right: 30, left: 30,top: 10),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [

                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: _tituloController,
                          focusNode: titulo,
                          onTap: () {
                            contador =1;
                            // setState(() {
                            //   selectedFieldController = _tituloController;
                            // });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Tarea',
                            prefixIcon: Icon(IconlyLight.document),
                            hintText: '¿Cuál es su Tarea?',
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
                          onEditingComplete: (){requestFocus(context, focusNodes[0]); contador++;},
                          // onTap: () { contador = 2;},
                          // maxLines: null,
                        ),



                        const SizedBox(height: 10.0),
                        DropdownButtonFormField<String>(
                          focusNode: nivel,
                          decoration: const InputDecoration(
                            labelText: 'Nivel de importancia',
                            prefixIcon: Icon(IconlyLight.category),
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
                            ),
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
                              nivelDeImportancia = value!;
                              //requestFocus(context, focusNodes[0]);
                            });
                          },
                        ),



                        const SizedBox(height: 10.0),
                        const Text("Fecha y Hora",style: TextStyle(fontSize: 18)),
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
                                    _selectedDate = date;
                                  });
                                }
                              },
                              child: Text(
                                _fecha
                              ),
                            ),


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
                                    _selectedTime = time;
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

          GestureDetector(
            onTap: (){
              setState(() {
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
          

          GestureDetector(
            onTap: (){
              setState(() {
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
          

          GestureDetector(
            onTap: (){
              setState(() {
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
          

          GestureDetector(
            onTap: (){
              setState(() {
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
          

          GestureDetector(
            onTap: (){
              setState(() {
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
          

          GestureDetector(
            onTap: (){
              setState(() {
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

  void requestFocus(BuildContext context, FocusNode node){
    FocusScope.of(context).requestFocus(node);
    // setState(() {
    //   currentFocusNode = node;
    //   FocusScope.of(context).requestFocus(node);
    // });
  }


//   void _moveToNextField(TextEditingController currentController) {
//   if (currentController == _tituloController) {
//     FocusScope.of(context).requestFocus(focusNodes[0]);
//   }else{
//     for(int i = 0; i < textControllers.length; ++i){
//       if(i != textControllers.length-1){
//         if(currentController == textControllers[i]){
//           FocusScope.of(context).requestFocus(focusNodes[i+1]);
//         }
//       }else{
//         if(currentController == textControllers[i]){
//           FocusScope.of(context).requestFocus(notasNodes[0]);
//         }
//       }
//     }
//     for(int i = 0; i < notasControllers.length; ++i){
//       if(i != notasControllers.length-1){
//         if(currentController == notasControllers[i]){
//           FocusScope.of(context).requestFocus(focusNodes[i+1]);
//         }
//       }
//     }
//   }
// }


  @override
  void dispose() {
    _tituloController.dispose();

    for (TextEditingController controller in textControllers) {
      controller.dispose();
    }

    for (TextEditingController controller in notasControllers) {
      controller.dispose();
    }

    for (FocusNode focus in focusNodes){
      focus.dispose();
    }

    for(FocusNode focus in notasNodes){
      focus.dispose();
    }
    
    titulo.dispose();
    nivel.dispose();
    super.dispose();
  }
}

