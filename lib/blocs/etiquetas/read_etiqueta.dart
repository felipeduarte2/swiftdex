import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/etiqueta.dart';
import '../../repositories/etiqueta_repository.dart';

abstract class ReadEtiquetaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchEtiquetasRequested extends ReadEtiquetaEvent {}

abstract class ReadEtiquetaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReadEtiquetaInitial extends ReadEtiquetaState {}

class ReadEtiquetaLoading extends ReadEtiquetaState {}

class ReadEtiquetaSuccess extends ReadEtiquetaState {
  final Etiqueta etiquetas;

  ReadEtiquetaSuccess(this.etiquetas);

  @override
  List<Object?> get props => [etiquetas];
}

class ReadEtiquetaFailure extends ReadEtiquetaState {
  final String error;

  ReadEtiquetaFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class ReadEtiquetaBloc extends Bloc<ReadEtiquetaEvent, ReadEtiquetaState> {
  final EtiquetaRepository _etiquetaRepository;

  ReadEtiquetaBloc({required EtiquetaRepository etiquetaRepository})
      : _etiquetaRepository = etiquetaRepository,
        super(ReadEtiquetaInitial()) {
    on<FetchEtiquetasRequested>(_onFetchEtiquetasRequested);
  }

  Future<void> _onFetchEtiquetasRequested(
      FetchEtiquetasRequested event, Emitter<ReadEtiquetaState> emit) async {
    emit(ReadEtiquetaLoading());
    final response = await _etiquetaRepository.getEtiquetas();
    if (response['success']) {
      emit(ReadEtiquetaSuccess(Etiqueta.fromJson(response['data'])));
    } else {
      emit(ReadEtiquetaFailure(response['error']));
    }
  }
}
