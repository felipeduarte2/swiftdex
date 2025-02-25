import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/etiqueta_repository.dart';

abstract class DeleteEtiquetaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteEtiquetaRequested extends DeleteEtiquetaEvent {
  final int idEtiqueta;

  DeleteEtiquetaRequested({required this.idEtiqueta});

  @override
  List<Object?> get props => [idEtiqueta];
}

abstract class DeleteEtiquetaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteEtiquetaInitial extends DeleteEtiquetaState {}

class DeleteEtiquetaLoading extends DeleteEtiquetaState {}

class DeleteEtiquetaSuccess extends DeleteEtiquetaState {}

class DeleteEtiquetaFailure extends DeleteEtiquetaState {
  final String error;

  DeleteEtiquetaFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class DeleteEtiquetaBloc extends Bloc<DeleteEtiquetaEvent, DeleteEtiquetaState> {
  final EtiquetaRepository _etiquetaRepository;

  DeleteEtiquetaBloc({required EtiquetaRepository etiquetaRepository})
      : _etiquetaRepository = etiquetaRepository,
        super(DeleteEtiquetaInitial()) {
    on<DeleteEtiquetaRequested>(_onDeleteEtiquetaRequested);
  }

  Future<void> _onDeleteEtiquetaRequested(
      DeleteEtiquetaRequested event, Emitter<DeleteEtiquetaState> emit) async {
    emit(DeleteEtiquetaLoading());
    final response = await _etiquetaRepository.deleteEtiqueta(event.idEtiqueta);
    if (response['success']) {
      emit(DeleteEtiquetaSuccess());
    } else {
      emit(DeleteEtiquetaFailure(response['error']));
    }
  }
}
