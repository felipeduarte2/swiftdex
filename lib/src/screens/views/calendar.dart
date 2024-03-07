import 'package:flutter/material.dart';
import 'package:listgenius/src/screens/data_base/crud_actividades.dart';
import 'package:listgenius/src/screens/temas/removeact.dart';
import 'package:listgenius/src/screens/temas/taskitem.dart';
import 'package:table_calendar/table_calendar.dart';


class TableCalendarPage extends StatefulWidget {
  const TableCalendarPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TableCalendarPageState createState() => _TableCalendarPageState();
}

class _TableCalendarPageState extends State<TableCalendarPage> {
  List<Actividad>? _actividades;
  List<bool> boolList = [];

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  final List<DateTime> _selectedDays = [];
  @override
  void initState() {
    super.initState();
    _loadActividades();
    // _getFechas();
  }
  Future<void> _loadActividades() async {
    List<Actividad>? actividades = await ActividadesCRUD().getAllActividades();
    boolList= List<bool>.generate(actividades.length, (index) => false);
    _getFechas(actividades);
    if(mounted){
      setState(() {
      _actividades = actividades;
    });
    }
  }
  // DateTime? _selectedDay;
  // List<DateTime>? fechas;
  void _getFechas(List<Actividad> actividades){
    _selectedDays.clear();
     for(int i=0; i < actividades.length ; i++){
      String fecha = actividades[i].fecha;
      int year = int.parse(fecha.split("-")[0]);
      int month = int.parse(fecha.split("-")[1]);
      int day = int.parse(fecha.split("-")[2]);
      // int month = int.parse(fecha.substring(5,7));
      // int day = int.parse(fecha.substring(8,10));
      // DateTime.parse('$fecha''T05:00:00.000Z');
      // DateTime.utc(int.parse(fecha.substring(0,4)),int.parse(fecha.substring(5,7)),int.parse(fecha.substring(8,10)));
       _selectedDays.add(DateTime.utc(year,month,day));
     }
  }
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
     _focusedDay = selectedDay;
    if (!_selectedDays.contains(selectedDay)) {
            setState(() {
              _selectedDays.add(selectedDay);
            });
          } else {
            setState(() {
              _selectedDays.remove(selectedDay);
            });
          }
    // setState(() {
    //   // _selectedDay = selectedDay;
    //   _focusedDay = selectedDay;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(   

      body: ListView(
        // children: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child:
                Container(
                  decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.circular(10),
                    // color: Colors.grey
                  ),
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (details.delta.dy <= 0) {
                        // Deslizamiento hacia abajo
                        if (_calendarFormat == CalendarFormat.month) {
                          setState(() {
                            _calendarFormat = CalendarFormat.week;
                          });
                        }
                      }else {
                        // Deslizamiento hacia arriba
                      if (_calendarFormat == CalendarFormat.week) {
                        setState(() {
                          _calendarFormat = CalendarFormat.month;
                        });
                      }
                      } 
                    },
                    child: TableCalendar(
                      firstDay: DateTime.utc(2024,01,01),
                      lastDay: DateTime.utc(2025,01,01),
                  
                      calendarFormat: _calendarFormat,
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) {
                        //
                        // return isSameDay(day, _focusedDay);
                        return _selectedDays.contains(day);
                      },
                      onDaySelected: _onDaySelected,
                    //   calendarBuilders: CalendarBuilders(
                    //     markerBuilder: (context, date, events) {
                    //     final children = <Widget>[];
                    //     if (events.isNotEmpty) {
                    //       children.add(
                    //         Positioned(
                    //           bottom: 1,
                    //           child: Container(
                    //             width: 6,
                    //             height: 6,
                    //             decoration: const BoxDecoration(
                    //               color: Colors.red,
                    //               shape: BoxShape.circle,
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     }
                    //     return Stack(
                    //       children: children,
                    //     );
                    //   },
                    // ),
                      calendarStyle: const CalendarStyle(
                        // todayDecoration: BoxDecoration(
                        //   color: Colors.blue,
                        //   shape: BoxShape.circle,
                        // ),
                        selectedDecoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                    ),
                  ),
                ),
            ),
            Container(
              child: _actividades != null
              ? _showActividades(context)
              : _buttonCircular(context),
            ),
          ],
        // ),
      ),
    );
  }
  _buttonCircular(BuildContext context){
    return const Center(child: CircularProgressIndicator());
  }
  _showActividades(BuildContext context){
    _loadActividades();
    // _getFechas();
    if(_actividades!.isEmpty){
      return const Column(
        children: [
          Text("Sin Actividades",style: TextStyle(fontSize: 18)),
          // Center(child: Text("Sin Actividades",style: TextStyle(fontSize: 18))),
        ],
      );
    }else{
      return Column(
  children: _actividades!.map<Widget>((actividad) {
    final index = _actividades?.indexOf(actividad);
    if (actividad.realizado == "si") {
      boolList[index!] = true;
    }

    return Dismissible(
      key: Key(index.toString()),
      direction: DismissDirection.horizontal,
      background: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.delete, color: Colors.red, size: 35,),
          SizedBox(width: 8,),
          Text("Eliminar", style: TextStyle(color: Colors.red, fontSize: 24),)
        ]
      ),
      onDismissed: (_) {
        Remove.removeFromDatabase(actividad);
        if (mounted) {
          setState(() {
            _actividades?.removeAt(index);
            boolList[index] = false;
          });
        }
      },
      child: TaskItem(actividad: actividad , isCheck: boolList[index!],),
    );
  }).toList(),
);
    }
  }
}