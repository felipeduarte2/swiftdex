import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/tarea.dart';
import '../../repositories/tarea_repository.dart';

abstract class ReadTareaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTareasRequested extends ReadTareaEvent {}

abstract class ReadTareaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReadTareaInitial extends ReadTareaState {}

class ReadTareaLoading extends ReadTareaState {}

class ReadTareaSuccess extends ReadTareaState {
  final List<Tarea> tareas;

  ReadTareaSuccess(this.tareas);

  @override
  List<Object?> get props => [tareas];
}

class ReadTareaFailure extends ReadTareaState {
  final String error;

  ReadTareaFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class ReadTareaBloc extends Bloc<ReadTareaEvent, ReadTareaState> {
  final TareaRepository _tareaRepository;

  ReadTareaBloc({required TareaRepository tareaRepository})
      : _tareaRepository = tareaRepository,
        super(ReadTareaInitial()) {
    on<FetchTareasRequested>(_onFetchTareasRequested);
  }

  Future<void> _onFetchTareasRequested(FetchTareasRequested event, Emitter<ReadTareaState> emit) async {
    emit(ReadTareaLoading());
    final response = await _tareaRepository.getTareas();
    if (response['success']) {
      emit(ReadTareaSuccess(response['data'].map((json) => Tarea.fromJson(json)).toList()));
    } else {
      emit(ReadTareaFailure(response['error']));
    }
  }
}
