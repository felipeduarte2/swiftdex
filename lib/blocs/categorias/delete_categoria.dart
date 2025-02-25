import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/categoria_repository.dart';

abstract class DeleteCategoriaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteCategoriaRequested extends DeleteCategoriaEvent {
  final int idCategoria;

  DeleteCategoriaRequested({required this.idCategoria});

  @override
  List<Object?> get props => [idCategoria];
}

abstract class DeleteCategoriaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteCategoriaInitial extends DeleteCategoriaState {}

class DeleteCategoriaLoading extends DeleteCategoriaState {}

class DeleteCategoriaSuccess extends DeleteCategoriaState {}

class DeleteCategoriaFailure extends DeleteCategoriaState {
  final String error;

  DeleteCategoriaFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class DeleteCategoriaBloc extends Bloc<DeleteCategoriaEvent, DeleteCategoriaState> {
  final CategoriaRepository _categoriaRepository;

  DeleteCategoriaBloc({required CategoriaRepository categoriaRepository})
      : _categoriaRepository = categoriaRepository,
        super(DeleteCategoriaInitial()) {
    on<DeleteCategoriaRequested>(_onDeleteCategoriaRequested);
  }

  Future<void> _onDeleteCategoriaRequested(DeleteCategoriaRequested event, Emitter<DeleteCategoriaState> emit) async {
    emit(DeleteCategoriaLoading());
    final response = await _categoriaRepository.deleteCategoria(event.idCategoria);
    if (response['success']) {
      emit(DeleteCategoriaSuccess());
    } else {
      emit(DeleteCategoriaFailure(response['error']));
    }
  }
}
