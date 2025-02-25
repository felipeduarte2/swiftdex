import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/categoria.dart';
import '../../repositories/categoria_repository.dart';

abstract class ReadCategoriaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCategorias extends ReadCategoriaEvent {}

abstract class ReadCategoriaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReadCategoriaInitial extends ReadCategoriaState {}

class ReadCategoriaLoading extends ReadCategoriaState {}

class ReadCategoriaSuccess extends ReadCategoriaState {
  final Categoria categorias;

  ReadCategoriaSuccess(this.categorias);

  @override
  List<Object?> get props => [categorias];
}

class ReadCategoriaFailure extends ReadCategoriaState {
  final String error;

  ReadCategoriaFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class ReadCategoriaBloc extends Bloc<ReadCategoriaEvent, ReadCategoriaState> {
  final CategoriaRepository _categoriaRepository;

  ReadCategoriaBloc({required CategoriaRepository categoriaRepository})
      : _categoriaRepository = categoriaRepository,
        super(ReadCategoriaInitial()) {
    on<FetchCategorias>(_onFetchCategorias);
  }

  Future<void> _onFetchCategorias(FetchCategorias event, Emitter<ReadCategoriaState> emit) async {
    emit(ReadCategoriaLoading());
    final response = await _categoriaRepository.getCategorias();
    if (response['success']) {
      emit(ReadCategoriaSuccess(Categoria.fromJson(response['data'])));
    } else {
      emit(ReadCategoriaFailure(response['error']));
    }
  }
}
