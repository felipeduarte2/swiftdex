import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/recordatorios_repository.dart';

abstract class CreateRecordatorioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddRecordatorioRequested extends CreateRecordatorioEvent {
  final int idTarea;
  final String fechaRecordatorio;

  AddRecordatorioRequested({
    required this.idTarea,
    required this.fechaRecordatorio,
  });

  @override
  List<Object?> get props => [idTarea, fechaRecordatorio];
}

abstract class CreateRecordatorioState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateRecordatorioInitial extends CreateRecordatorioState {}

class CreateRecordatorioLoading extends CreateRecordatorioState {}

class CreateRecordatorioSuccess extends CreateRecordatorioState {}

class CreateRecordatorioFailure extends CreateRecordatorioState {
  final String error;

  CreateRecordatorioFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class CreateRecordatorioBloc
    extends Bloc<CreateRecordatorioEvent, CreateRecordatorioState> {
  final RecordatoriosRepository _recordatoriosRepository;

  CreateRecordatorioBloc({required RecordatoriosRepository recordatoriosRepository})
      : _recordatoriosRepository = recordatoriosRepository,
        super(CreateRecordatorioInitial()) {
    on<AddRecordatorioRequested>(_onAddRecordatorioRequested);
  }

  Future<void> _onAddRecordatorioRequested(
      AddRecordatorioRequested event, Emitter<CreateRecordatorioState> emit) async {
    emit(CreateRecordatorioLoading());
    final response = await _recordatoriosRepository.createRecordatorio(
      event.idTarea,
      event.fechaRecordatorio,
    );

    if (response['success']) {
      emit(CreateRecordatorioSuccess());
    } else {
      emit(CreateRecordatorioFailure(response['error']));
    }
  }
}
