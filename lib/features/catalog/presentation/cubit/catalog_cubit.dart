import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/joyeria_repository.dart';
import 'catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {
  final JoyeriaRepository repository;

  CatalogCubit(this.repository) : super(CatalogInitial());

  Future<void> fetchCatalog() async {
    emit(CatalogLoading());
    try {
      final joyas = await repository.getCatalogo();
      emit(CatalogSuccess(joyas));
    } catch (e) {
      emit(CatalogError(e.toString()));
    }
  }
}