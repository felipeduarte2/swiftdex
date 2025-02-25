import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/tarea_etiqueta_repository.dart';

abstract class CreateTareaEtiquetaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddEtiquetaToTareaRequested extends CreateTareaEtiquetaEvent {
  final int idTarea;
  final int idEtiqueta;

  AddEtiquetaToTareaRequested({required this.idTarea, required this.idEtiqueta});

  @override
  List<Object?> get props => [idTarea, idEtiqueta];
}

abstract class CreateTareaEtiquetaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateTareaEtiquetaInitial extends CreateTareaEtiquetaState {}

class CreateTareaEtiquetaLoading extends CreateTareaEtiquetaState {}

class CreateTareaEtiquetaSuccess extends CreateTareaEtiquetaState {}

class CreateTareaEtiquetaFailure extends CreateTareaEtiquetaState {
  final String error;

  CreateTareaEtiquetaFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class CreateTareaEtiquetaBloc extends Bloc<CreateTareaEtiquetaEvent, CreateTareaEtiquetaState> {
  final TareaEtiquetaRepository _tareaEtiquetaRepository;

  CreateTareaEtiquetaBloc({required TareaEtiquetaRepository tareaEtiquetaRepository})
      : _tareaEtiquetaRepository = tareaEtiquetaRepository,
        super(CreateTareaEtiquetaInitial()) {
    on<AddEtiquetaToTareaRequested>(_onAddEtiquetaToTareaRequested);
  }

  Future<void> _onAddEtiquetaToTareaRequested(
      AddEtiquetaToTareaRequested event, Emitter<CreateTareaEtiquetaState> emit) async {
    emit(CreateTareaEtiquetaLoading());
    final response = await _tareaEtiquetaRepository.createTareaEtiqueta(
      event.idTarea,
      event.idEtiqueta,
    );
    if (response['success']) {
      emit(CreateTareaEtiquetaSuccess());
    } else {
      emit(CreateTareaEtiquetaFailure(response['error']));
    }
  }
}
