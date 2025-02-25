import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/tarea_repository.dart';

abstract class DeleteTareaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteTareaRequested extends DeleteTareaEvent {
  final int idTarea;

  DeleteTareaRequested({required this.idTarea});

  @override
  List<Object?> get props => [idTarea];
}

abstract class DeleteTareaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteTareaInitial extends DeleteTareaState {}

class DeleteTareaLoading extends DeleteTareaState {}

class DeleteTareaSuccess extends DeleteTareaState {}

class DeleteTareaFailure extends DeleteTareaState {
  final String error;

  DeleteTareaFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class DeleteTareaBloc extends Bloc<DeleteTareaEvent, DeleteTareaState> {
  final TareaRepository _tareaRepository;

  DeleteTareaBloc({required TareaRepository tareaRepository})
      : _tareaRepository = tareaRepository,
        super(DeleteTareaInitial()) {
    on<DeleteTareaRequested>(_onDeleteTareaRequested);
  }

  Future<void> _onDeleteTareaRequested(DeleteTareaRequested event, Emitter<DeleteTareaState> emit) async {
    emit(DeleteTareaLoading());
    final response = await _tareaRepository.deleteTarea(event.idTarea);
    if (response['success']) {
      emit(DeleteTareaSuccess());
    } else {
      emit(DeleteTareaFailure(response['error']));
    }
  }
}
