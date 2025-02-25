import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/categoria_repository.dart';

abstract class CreateCategoriaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateCategoriaRequested extends CreateCategoriaEvent {
  final String nombreCategoria;

  CreateCategoriaRequested({required this.nombreCategoria});

  @override
  List<Object?> get props => [nombreCategoria];
}

abstract class CreateCategoriaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateCategoriaInitial extends CreateCategoriaState {}

class CreateCategoriaLoading extends CreateCategoriaState {}

class CreateCategoriaSuccess extends CreateCategoriaState {}

class CreateCategoriaFailure extends CreateCategoriaState {
  final String error;

  CreateCategoriaFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class CreateCategoriaBloc extends Bloc<CreateCategoriaEvent, CreateCategoriaState> {
  final CategoriaRepository _categoriaRepository;

  CreateCategoriaBloc({required CategoriaRepository categoriaRepository})
      : _categoriaRepository = categoriaRepository,
        super(CreateCategoriaInitial()) {
    on<CreateCategoriaRequested>(_onCreateCategoriaRequested);
  }

  Future<void> _onCreateCategoriaRequested(CreateCategoriaRequested event, Emitter<CreateCategoriaState> emit) async {
    emit(CreateCategoriaLoading());
    final response = await _categoriaRepository.createCategoria(event.nombreCategoria);
    if (response['success']) {
      emit(CreateCategoriaSuccess());
    } else {
      emit(CreateCategoriaFailure(response['error']));
    }
  }
}
