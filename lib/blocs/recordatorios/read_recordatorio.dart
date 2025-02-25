import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/recordatorio.dart';
import '../../repositories/recordatorios_repository.dart';

abstract class ReadRecordatorioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRecordatoriosRequested extends ReadRecordatorioEvent {}

abstract class ReadRecordatorioState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReadRecordatorioInitial extends ReadRecordatorioState {}

class ReadRecordatorioLoading extends ReadRecordatorioState {}

class ReadRecordatorioLoaded extends ReadRecordatorioState {
  final Recordatorio recordatorios;

  ReadRecordatorioLoaded(this.recordatorios);

  @override
  List<Object?> get props => [recordatorios];
}

class ReadRecordatorioFailure extends ReadRecordatorioState {
  final String error;

  ReadRecordatorioFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class ReadRecordatorioBloc
    extends Bloc<ReadRecordatorioEvent, ReadRecordatorioState> {
  final RecordatoriosRepository _recordatoriosRepository;

  ReadRecordatorioBloc({required RecordatoriosRepository recordatoriosRepository})
      : _recordatoriosRepository = recordatoriosRepository,
        super(ReadRecordatorioInitial()) {
    on<FetchRecordatoriosRequested>(_onFetchRecordatoriosRequested);
  }

  Future<void> _onFetchRecordatoriosRequested(
      FetchRecordatoriosRequested event, Emitter<ReadRecordatorioState> emit) async {
    emit(ReadRecordatorioLoading());
    final response = await _recordatoriosRepository.getRecordatorios();

    if (response['success']) {
      emit(ReadRecordatorioLoaded(Recordatorio.fromJson(response['data'])));
    } else {
      emit(ReadRecordatorioFailure(response['error']));
    }
  }
}
