import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/recordatorios_repository.dart';

abstract class UpdateRecordatorioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateRecordatorioRequested extends UpdateRecordatorioEvent {
  final int idRecordatorio;
  final String fechaRecordatorio;
  final bool activo;

  UpdateRecordatorioRequested({
    required this.idRecordatorio,
    required this.fechaRecordatorio,
    required this.activo,
  });

  @override
  List<Object?> get props => [idRecordatorio, fechaRecordatorio, activo];
}

abstract class UpdateRecordatorioState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateRecordatorioInitial extends UpdateRecordatorioState {}

class UpdateRecordatorioLoading extends UpdateRecordatorioState {}

class UpdateRecordatorioSuccess extends UpdateRecordatorioState {}

class UpdateRecordatorioFailure extends UpdateRecordatorioState {
  final String error;

  UpdateRecordatorioFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class UpdateRecordatorioBloc
    extends Bloc<UpdateRecordatorioEvent, UpdateRecordatorioState> {
  final RecordatoriosRepository _recordatoriosRepository;

  UpdateRecordatorioBloc({required RecordatoriosRepository recordatoriosRepository})
      : _recordatoriosRepository = recordatoriosRepository,
        super(UpdateRecordatorioInitial()) {
    on<UpdateRecordatorioRequested>(_onUpdateRecordatorioRequested);
  }

  Future<void> _onUpdateRecordatorioRequested(
      UpdateRecordatorioRequested event, Emitter<UpdateRecordatorioState> emit) async {
    emit(UpdateRecordatorioLoading());

    final response = await _recordatoriosRepository.updateRecordatorio(
      event.idRecordatorio,
      event.fechaRecordatorio,
      event.activo,
    );

    if (response['success']) {
      emit(UpdateRecordatorioSuccess());
    } else {
      emit(UpdateRecordatorioFailure(response['error']));
    }
  }
}
