import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/tarea_repository.dart';

abstract class CreateTareaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateTareaRequested extends CreateTareaEvent {
  final String titulo;
  final String descripcion;
  final DateTime fechaVencimiento;
  final int idCategoria;
  final String estado;
  final String prioridad;

  CreateTareaRequested({
    required this.titulo,
    required this.descripcion,
    required this.fechaVencimiento,
    required this.idCategoria,
    required this.estado,
    required this.prioridad
  });

  @override
  List<Object?> get props => [titulo, descripcion, fechaVencimiento, idCategoria, estado, prioridad];
}

abstract class CreateTareaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateTareaInitial extends CreateTareaState {}

class CreateTareaLoading extends CreateTareaState {}

class CreateTareaSuccess extends CreateTareaState {}

class CreateTareaFailure extends CreateTareaState {
  final String error;

  CreateTareaFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class CreateTareaBloc extends Bloc<CreateTareaEvent, CreateTareaState> {
  final TareaRepository _tareaRepository;

  CreateTareaBloc({required TareaRepository tareaRepository})
      : _tareaRepository = tareaRepository,
        super(CreateTareaInitial()) {
    on<CreateTareaRequested>(_onCreateTareaRequested);
  }

  Future<void> _onCreateTareaRequested(CreateTareaRequested event, Emitter<CreateTareaState> emit) async {
    emit(CreateTareaLoading());
    final response = await _tareaRepository.createTarea(
      {
        'titulo':event.titulo,
        'descripcion':event.descripcion,
        'fecha_vencimiento':event.fechaVencimiento,
        'estado':event.estado,
        'prioridad': event.prioridad,
        'id_categoria':event.idCategoria
      }
    );
    if (response['success']) {
      emit(CreateTareaSuccess());
    } else {
      emit(CreateTareaFailure(response['error']));
    }
  }
}
