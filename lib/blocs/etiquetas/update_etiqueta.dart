import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/etiqueta_repository.dart';

abstract class UpdateEtiquetaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateEtiquetaRequested extends UpdateEtiquetaEvent {
  final int idEtiqueta;
  final String nombreEtiqueta;

  UpdateEtiquetaRequested({required this.idEtiqueta, required this.nombreEtiqueta});

  @override
  List<Object?> get props => [idEtiqueta, nombreEtiqueta];
}

abstract class UpdateEtiquetaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateEtiquetaInitial extends UpdateEtiquetaState {}

class UpdateEtiquetaLoading extends UpdateEtiquetaState {}

class UpdateEtiquetaSuccess extends UpdateEtiquetaState {}

class UpdateEtiquetaFailure extends UpdateEtiquetaState {
  final String error;

  UpdateEtiquetaFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class UpdateEtiquetaBloc extends Bloc<UpdateEtiquetaEvent, UpdateEtiquetaState> {
  final EtiquetaRepository _etiquetaRepository;

  UpdateEtiquetaBloc({required EtiquetaRepository etiquetaRepository})
      : _etiquetaRepository = etiquetaRepository,
        super(UpdateEtiquetaInitial()) {
    on<UpdateEtiquetaRequested>(_onUpdateEtiquetaRequested);
  }

  Future<void> _onUpdateEtiquetaRequested(
      UpdateEtiquetaRequested event, Emitter<UpdateEtiquetaState> emit) async {
    emit(UpdateEtiquetaLoading());
    final response = await _etiquetaRepository.updateEtiqueta(
      event.idEtiqueta,
      event.nombreEtiqueta,
    );
    if (response['success']) {
      emit(UpdateEtiquetaSuccess());
    } else {
      emit(UpdateEtiquetaFailure(response['error']));
    }
  }
}
