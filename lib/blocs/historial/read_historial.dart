import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/historial.dart';
import '../../repositories/historial_repository.dart';

abstract class ReadHistorialEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchHistorialRequested extends ReadHistorialEvent {
  final int idTarea;

  FetchHistorialRequested({required this.idTarea});

  @override
  List<Object?> get props => [idTarea];
}

abstract class ReadHistorialState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReadHistorialInitial extends ReadHistorialState {}

class ReadHistorialLoading extends ReadHistorialState {}

class ReadHistorialLoaded extends ReadHistorialState {
  final Historial historial;

  ReadHistorialLoaded(this.historial);

  @override
  List<Object?> get props => [historial];
}

class ReadHistorialFailure extends ReadHistorialState {
  final String error;

  ReadHistorialFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class ReadHistorialBloc extends Bloc<ReadHistorialEvent, ReadHistorialState> {
  final HistorialRepository _historialRepository;

  ReadHistorialBloc({required HistorialRepository historialRepository})
      : _historialRepository = historialRepository,
        super(ReadHistorialInitial()) {
    on<FetchHistorialRequested>(_onFetchHistorialRequested);
  }

  Future<void> _onFetchHistorialRequested(
      FetchHistorialRequested event, Emitter<ReadHistorialState> emit) async {
    emit(ReadHistorialLoading());
    final response = await _historialRepository.getHistorialByTarea(event.idTarea);

    if (response['success']) {
      emit(ReadHistorialLoaded(Historial.fromJson(response['data'])));
    } else {
      emit(ReadHistorialFailure(response['error']));
    }
  }
}
