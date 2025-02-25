import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/tarea_etiqueta.dart';
import '../../repositories/tarea_etiqueta_repository.dart';

abstract class ReadTareaEtiquetaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTareaEtiquetasRequested extends ReadTareaEtiquetaEvent {
  final int idTarea;

  FetchTareaEtiquetasRequested({required this.idTarea});

  @override
  List<Object?> get props => [idTarea];
}

abstract class ReadTareaEtiquetaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReadTareaEtiquetaInitial extends ReadTareaEtiquetaState {}

class ReadTareaEtiquetaLoading extends ReadTareaEtiquetaState {}

class ReadTareaEtiquetaSuccess extends ReadTareaEtiquetaState {
  final List<TareaEtiqueta> etiquetas;

  ReadTareaEtiquetaSuccess(this.etiquetas);

  @override
  List<Object?> get props => [etiquetas];
}

class ReadTareaEtiquetaFailure extends ReadTareaEtiquetaState {
  final String error;

  ReadTareaEtiquetaFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class ReadTareaEtiquetaBloc extends Bloc<ReadTareaEtiquetaEvent, ReadTareaEtiquetaState> {
  final TareaEtiquetaRepository _tareaEtiquetaRepository;

  ReadTareaEtiquetaBloc({required TareaEtiquetaRepository tareaEtiquetaRepository})
      : _tareaEtiquetaRepository = tareaEtiquetaRepository,
        super(ReadTareaEtiquetaInitial()) {
    on<FetchTareaEtiquetasRequested>(_onFetchTareaEtiquetasRequested);
  }

  Future<void> _onFetchTareaEtiquetasRequested(
      FetchTareaEtiquetasRequested event, Emitter<ReadTareaEtiquetaState> emit) async {
    emit(ReadTareaEtiquetaLoading());
    final response = await _tareaEtiquetaRepository.getTareaEtiquetas();

    if (response['success']) {
      emit(ReadTareaEtiquetaSuccess(response['etiquetas'].map((json) => TareaEtiqueta.fromJson(json)).toList()));
    } else {
      emit(ReadTareaEtiquetaFailure(response['error']));
    }
  }
}
