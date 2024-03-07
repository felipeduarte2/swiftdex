import 'package:flutter/material.dart';
import 'package:listgenius/src/screens/data_base/crud_actividades.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.actividad, 
    required this.isCheck,
  });

  final Actividad actividad;
  final bool  isCheck;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  _getIcon(Actividad actividad) {
    if(actividad.categoria=="Tarea"){
      return Icons.assignment;
    }else  if(actividad.categoria=="Nota"){
      return Icons.note_alt_outlined;
    }else if(actividad.categoria=="Rutina"){
      return Icons.directions_run;
    }else if(actividad.categoria=="Evento"){
      return Icons.event;
      // return const Icon(Icons.assignment,);s
    }else{
      return null;
    }
  }
  _selectColor(Actividad actividad) {
      switch (actividad.color){
        case 1: return const Color(0xff59D5E0);//blue
        case 2: return const Color(0xff15F5BA);//menta
        case 3: return const Color(0xff9BCF53);//green
        case 4: return const Color(0xffF5DD61);//yellow
        case 5: return const Color(0xffFF8080);
        case 6: return const Color(0xffAD88C6);
       default: return Colors.blue;
  }
    // if(actividad.categoria=="Tarea"){
    //   return const Color(0xff63d3ff);
    // }
    // else  if(actividad.categoria=="Viaje"){
    //   return const Color(0xffffc994);
    // }else if(actividad.categoria=="Rutina"){
    //   return const Color(0xfffff07f);
    // }else if(actividad.categoria=="Evento"){
    //   return const Color(0xff06a336);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(widget.actividad.categoria == "Evento"){
          int? id= widget.actividad.idActividad;
          Navigator.of(context).pushNamed("/viewevento",arguments: '$id');
        }
        if(widget.actividad.categoria == "Rutina"){
          int? id= widget.actividad.idActividad;
          Navigator.of(context).pushNamed("/viewrutina",arguments: '$id');
        }
        if(widget.actividad.categoria == "Nota"){
          int? id= widget.actividad.idActividad;
          Navigator.of(context).pushNamed("/viewviaje",arguments: '$id');
        }
        if(widget.actividad.categoria == "Tarea"){
           int? id= widget.actividad.idActividad;
           Navigator.of(context).pushNamed("/viewtarea",arguments: '$id');
        }                      
      },
    
      child: AnimatedContainer(
        margin: const  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        duration: const Duration(milliseconds: 600),
        decoration: BoxDecoration(color: _selectColor(widget.actividad), borderRadius: BorderRadius.circular(10)),
        child: ListTile(
      
          //Checbox
          leading: GestureDetector(
            onTap: (){
              setState((){
                if(widget.isCheck!=true){widget.actividad.realizado="si";}else{widget.actividad.realizado="no";}
                ActividadesCRUD().updateActividad(widget.actividad);
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
                color: widget.isCheck == true ? Colors.white: Colors.transparent,
                // color: Colors.white,
              ),
            ),
          ),
      
          //Titulo
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 3),
            child: Text(
              widget.actividad.titulo, 
              style: TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.w500, 
                decoration: widget.isCheck == true ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
          ),
      
          //Descripcion
          // subtitle: Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       "widget.actividad.descripcion",
          //       style: TextStyle(
          //         color: Colors.black, 
          //         fontWeight: FontWeight.w500, 
          //         decoration: widget.isCheck == true ? TextDecoration.lineThrough : TextDecoration.none,
          //       ),
          //     ),
          //   ],
          // ),

          trailing: Icon(_getIcon(widget.actividad), color: Colors.black,),
        ),
      ),
    );
  }
}