import '../entities/joya.dart';

abstract class JoyeriaRepository {
  // Promesa de que devolveremos una lista de joyas
  Future<List<Joya>> getCatalogo();
}