import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/etiqueta_repository.dart';

abstract class CreateEtiquetaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateEtiquetaRequested extends CreateEtiquetaEvent {
  final String nombreEtiqueta;

  CreateEtiquetaRequested({required this.nombreEtiqueta});

  @override
  List<Object?> get props => [nombreEtiqueta];
}

abstract class CreateEtiquetaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateEtiquetaInitial extends CreateEtiquetaState {}

class CreateEtiquetaLoading extends CreateEtiquetaState {}

class CreateEtiquetaSuccess extends CreateEtiquetaState {}

class CreateEtiquetaFailure extends CreateEtiquetaState {
  final String error;

  CreateEtiquetaFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class CreateEtiquetaBloc extends Bloc<CreateEtiquetaEvent, CreateEtiquetaState> {
  final EtiquetaRepository _etiquetaRepository;

  CreateEtiquetaBloc({required EtiquetaRepository etiquetaRepository})
      : _etiquetaRepository = etiquetaRepository,
        super(CreateEtiquetaInitial()) {
    on<CreateEtiquetaRequested>(_onCreateEtiquetaRequested);
  }

  Future<void> _onCreateEtiquetaRequested(
      CreateEtiquetaRequested event, Emitter<CreateEtiquetaState> emit) async {
    emit(CreateEtiquetaLoading());
    final response = await _etiquetaRepository.createEtiqueta(event.nombreEtiqueta);
    if (response['success']) {
      emit(CreateEtiquetaSuccess());
    } else {
      emit(CreateEtiquetaFailure(response['error']));
    }
  }
}
