import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/categoria_repository.dart';

abstract class UpdateCategoriaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateCategoriaRequested extends UpdateCategoriaEvent {
  final int idCategoria;
  final String nombreCategoria;

  UpdateCategoriaRequested({required this.idCategoria, required this.nombreCategoria});

  @override
  List<Object?> get props => [idCategoria, nombreCategoria];
}

abstract class UpdateCategoriaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateCategoriaInitial extends UpdateCategoriaState {}

class UpdateCategoriaLoading extends UpdateCategoriaState {}

class UpdateCategoriaSuccess extends UpdateCategoriaState {}

class UpdateCategoriaFailure extends UpdateCategoriaState {
  final String error;

  UpdateCategoriaFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class UpdateCategoriaBloc extends Bloc<UpdateCategoriaEvent, UpdateCategoriaState> {
  final CategoriaRepository _categoriaRepository;

  UpdateCategoriaBloc({required CategoriaRepository categoriaRepository})
      : _categoriaRepository = categoriaRepository,
        super(UpdateCategoriaInitial()) {
    on<UpdateCategoriaRequested>(_onUpdateCategoriaRequested);
  }

  Future<void> _onUpdateCategoriaRequested(UpdateCategoriaRequested event, Emitter<UpdateCategoriaState> emit) async {
    emit(UpdateCategoriaLoading());
    final response = await _categoriaRepository.updateCategoria(event.idCategoria, event.nombreCategoria);
    if (response['success']) {
      emit(UpdateCategoriaSuccess());
    } else {
      emit(UpdateCategoriaFailure(response['error']));
    }
  }
}
