import 'package:listgenius/src/screens/data_base/crud_actividades.dart';
// import 'package:listgenius/src/screens/data_base/crud_contactos.dart';
import 'package:listgenius/src/screens/data_base/crud_detalles.dart';
import 'package:listgenius/src/screens/data_base/crud_dias.dart';
import 'package:listgenius/src/screens/data_base/crud_notas.dart';
// import 'package:listgenius/src/screens/data_base/crud_preparativos.dart';
// import 'package:listgenius/src/screens/data_base/crud_viaje.dart';

class Remove{
  // public static void main(String[] args) {
  //   int arr[] = new int[]{1,2,3,4,5};
  //   System.out.println("Original array:");
  //   for (int i : arr){
  //     System.out.print(i + " ");
  //   }
  //   removeElement(arr, 3); //remove the element with value '3' from the array
  //   System.out.println("\nArray after removing '3':");
  //   for (int i : arr){
  //     System.out.print(i + " ");
  //   }
  // }

  // public static void removeElement(int[] arr, int val) {
    static void removeFromDatabase(actividad) {
      if(actividad.categoria == "Tarea"){
        ActividadesCRUD().deleteActividad(actividad.idActividad!);
        DetallesCRUD().deleteDetalle(actividad.idActividad!);
        NotasCRUD().deleteNota(actividad.idActividad!);
      }else if(actividad.categoria == "Evento"){
        ActividadesCRUD().deleteActividad(actividad.idActividad!);
        // ContactosCRUD().deleteContacto(actividad.idActividad);
        // PreparativosCRUD().deletePreparativo(actividad.idActividad);
        NotasCRUD().deleteNota(actividad.idActividad!);
      }
      else if(actividad.categoria == "Rutina"){
        ActividadesCRUD().deleteActividad(actividad.idActividad!);
        DetallesCRUD().deleteDetalle(actividad.idActividad!);
        DiasCRUD().deleteDia(actividad.idActividad);
        NotasCRUD().deleteNota(actividad.idActividad!);
      }
      else if(actividad.categoria == "Nota"){
        ActividadesCRUD().deleteActividad(actividad.idActividad!);
        // ViajesCRUD().deleteViaje(actividad.idActividad);
        // NotasCRUD().deleteNota(actividad.idActividad!);
      }
    }

}