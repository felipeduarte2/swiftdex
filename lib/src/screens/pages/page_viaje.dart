import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:listgenius/src/screens/data_base/crud_actividades.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ViajePage extends StatefulWidget {
  const ViajePage({super.key});

  @override
  State<ViajePage> createState() => _ViajePageState();
}

class _ViajePageState extends State<ViajePage> {
  final _formKey = GlobalKey<FormState>();


  // obejeto pra la clase SpeechToText y el bool para el estado del microndelfo
  bool isListening = false;
  SpeechToText  speechRecognizer = SpeechToText();

  // Variable para el id de la tarea a editar o null si es nueva|
  int id = 0;

  //Controller para el titulo
  final _tituloController = TextEditingController();

  //Variables para los datos del viaje
  String _hora = "00:00";
  String nivelDeImportancia = "Normal";
  bool bandera=true;
  String boton="Guardar";
  int opcionColor=1;

  //Variables para las actualizaciones
  late Actividad actividad0;

  @override
  void initState() {
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
    final name = ModalRoute.of(context)?.settings.arguments;
    id = int.parse(name.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Nueva Nota'),
        centerTitle: true,
        actions: <Widget>[
           IconButton(icon: const Icon(IconlyLight.tick_square), onPressed: () async {
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
                                categoria: "Nota",
                                titulo:_tituloController.text,
                                nivelDeImportancia: nivelDeImportancia,
                                realizado: "no",
                                fecha: "2000-00-00",
                                hora: _hora,
                                lugar: "sin lugar",
                                horario1: "00:00",
                                horario2: "00:00",
                                color: opcionColor,
                              );
                              await ActividadesCRUD().insertActividad(actividad);
                            }else{
                              actividad0.titulo=_tituloController.text;
                              actividad0.nivelDeImportancia=nivelDeImportancia;
                              actividad0.fecha= "2000-00-00";
                              actividad0.hora=_hora;
                              actividad0.color=opcionColor;
                              await ActividadesCRUD().updateActividad(actividad0);
                            }
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
           }),
        ],
      ),
      body: _showActividad(context,),
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
    if(mounted){
      setState(() {
        actividad0 = actividad!;
        _tituloController.text=actividad.titulo;
        nivelDeImportancia=actividad.nivelDeImportancia;
        _hora=actividad.hora;
        bandera=false;
        boton = "Actualizar";
    });
    }
  }

    _showActividad(BuildContext context) {
      if (id != 0){
        if(bandera){
          _loadActividad();
        }
      }//
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 60, left: 60),
                child: SizedBox(          
                  child: Image.asset("assets/images/notaimg.png"),
                ),
              ),
              _colores(),
              Container(
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
                            labelText: 'Nota',
                            hintText: '¿Cual es su Nota?',
                            prefixIcon: Icon(IconlyLight.document),
                            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                            border: InputBorder.none, //OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Primero ingrese su Nota';
                            }
                              return null;
                          },
                            maxLines: null,
                        ),
                        const SizedBox(height: 10.0),
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

  @override
  void dispose() {
    _tituloController.dispose();
    super.dispose();
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
                    //
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
                    //
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
                    //
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
                    //
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
                    //
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
  
}