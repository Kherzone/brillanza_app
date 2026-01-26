import '../../domain/entities/joya.dart';

abstract class CatalogState {}

class CatalogInitial extends CatalogState {}
class CatalogLoading extends CatalogState {}
class CatalogSuccess extends CatalogState {
  final List<Joya> joyas;
  CatalogSuccess(this.joyas);
}
class CatalogError extends CatalogState {
  final String message;
  CatalogError(this.message);
}