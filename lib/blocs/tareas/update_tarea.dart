import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/tarea_repository.dart';

abstract class UpdateTareaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateTareaRequested extends UpdateTareaEvent {
  final int idTarea;
  final String titulo;
  final String descripcion;
  final DateTime fechaVencimiento;
  final int idCategoria;
  final String estado;
  final String prioridad;

  UpdateTareaRequested({
    required this.idTarea,
    required this.titulo,
    required this.descripcion,
    required this.fechaVencimiento,
    required this.idCategoria,
    required this.estado,
    required this.prioridad
  });

  @override
  List<Object?> get props => [idTarea, titulo, descripcion, fechaVencimiento, idCategoria];
}

abstract class UpdateTareaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateTareaInitial extends UpdateTareaState {}

class UpdateTareaLoading extends UpdateTareaState {}

class UpdateTareaSuccess extends UpdateTareaState {}

class UpdateTareaFailure extends UpdateTareaState {
  final String error;

  UpdateTareaFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class UpdateTareaBloc extends Bloc<UpdateTareaEvent, UpdateTareaState> {
  final TareaRepository _tareaRepository;

  UpdateTareaBloc({required TareaRepository tareaRepository})
      : _tareaRepository = tareaRepository,
        super(UpdateTareaInitial()) {
    on<UpdateTareaRequested>(_onUpdateTareaRequested);
  }

  Future<void> _onUpdateTareaRequested(UpdateTareaRequested event, Emitter<UpdateTareaState> emit) async {
    emit(UpdateTareaLoading());
    final response = await _tareaRepository.updateTarea(
      event.idTarea,
      {'titulo':event.titulo,
        'descripcion':event.descripcion,
        'fecha_vencimiento':event.fechaVencimiento,
        'estado':event.estado,
        'prioridad': event.prioridad,
        'id_categoria':event.idCategoria
      }
    );
    if (response['success']) {
      emit(UpdateTareaSuccess());
    } else {
      emit(UpdateTareaFailure(response['error']));
    }
  }
}
