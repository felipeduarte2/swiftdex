import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/recordatorios_repository.dart';

abstract class DeleteRecordatorioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteRecordatorioRequested extends DeleteRecordatorioEvent {
  final int idRecordatorio;

  DeleteRecordatorioRequested({required this.idRecordatorio});

  @override
  List<Object?> get props => [idRecordatorio];
}

abstract class DeleteRecordatorioState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteRecordatorioInitial extends DeleteRecordatorioState {}

class DeleteRecordatorioLoading extends DeleteRecordatorioState {}

class DeleteRecordatorioSuccess extends DeleteRecordatorioState {}

class DeleteRecordatorioFailure extends DeleteRecordatorioState {
  final String error;

  DeleteRecordatorioFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class DeleteRecordatorioBloc
    extends Bloc<DeleteRecordatorioEvent, DeleteRecordatorioState> {
  final RecordatoriosRepository _recordatoriosRepository;

  DeleteRecordatorioBloc({required RecordatoriosRepository recordatoriosRepository})
      : _recordatoriosRepository = recordatoriosRepository,
        super(DeleteRecordatorioInitial()) {
    on<DeleteRecordatorioRequested>(_onDeleteRecordatorioRequested);
  }

  Future<void> _onDeleteRecordatorioRequested(
      DeleteRecordatorioRequested event, Emitter<DeleteRecordatorioState> emit) async {
    emit(DeleteRecordatorioLoading());
    final response = await _recordatoriosRepository.deleteRecordatorio(
      event.idRecordatorio,
    );

    if (response['success']) {
      emit(DeleteRecordatorioSuccess());
    } else {
      emit(DeleteRecordatorioFailure(response['error']));
    }
  }
}
