import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/tarea_etiqueta_repository.dart';

abstract class DeleteTareaEtiquetaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RemoveEtiquetaFromTareaRequested extends DeleteTareaEtiquetaEvent {
  final int idTarea;
  final int idEtiqueta;

  RemoveEtiquetaFromTareaRequested({required this.idTarea, required this.idEtiqueta});

  @override
  List<Object?> get props => [idTarea, idEtiqueta];
}

abstract class DeleteTareaEtiquetaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteTareaEtiquetaInitial extends DeleteTareaEtiquetaState {}

class DeleteTareaEtiquetaLoading extends DeleteTareaEtiquetaState {}

class DeleteTareaEtiquetaSuccess extends DeleteTareaEtiquetaState {}

class DeleteTareaEtiquetaFailure extends DeleteTareaEtiquetaState {
  final String error;

  DeleteTareaEtiquetaFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class DeleteTareaEtiquetaBloc extends Bloc<DeleteTareaEtiquetaEvent, DeleteTareaEtiquetaState> {
  final TareaEtiquetaRepository _tareaEtiquetaRepository;

  DeleteTareaEtiquetaBloc({required TareaEtiquetaRepository tareaEtiquetaRepository})
      : _tareaEtiquetaRepository = tareaEtiquetaRepository,
        super(DeleteTareaEtiquetaInitial()) {
    on<RemoveEtiquetaFromTareaRequested>(_onRemoveEtiquetaFromTareaRequested);
  }

  Future<void> _onRemoveEtiquetaFromTareaRequested(
      RemoveEtiquetaFromTareaRequested event, Emitter<DeleteTareaEtiquetaState> emit) async {
    emit(DeleteTareaEtiquetaLoading());
    final response = await _tareaEtiquetaRepository.deleteTareaEtiqueta(
      event.idTarea,
      event.idEtiqueta,
    );
    if (response['success']) {
      emit(DeleteTareaEtiquetaSuccess());
    } else {
      emit(DeleteTareaEtiquetaFailure(response['error']));
    }
  }
}
