import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/joya.dart';
import '../../domain/repositories/joyeria_repository.dart';
import '../models/joya_model.dart';

class JoyeriaRepositoryImpl implements JoyeriaRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Joya>> getCatalogo() async {
    try {
      // 1. Apuntamos a la colección "joyas" en Firebase
      final querySnapshot = await _firestore.collection('joyas').get();

      // 2. Convertimos cada documento en nuestro modelo JoyaModel
      return querySnapshot.docs.map((doc) {
        return JoyaModel.fromFirestore(doc.data(), doc.id);
      }).toList();
      
    } catch (e) {
      // Si algo falla, lanzamos el error para manejarlo en la UI
      throw Exception('Error al cargar el catálogo de Brillanza: $e');
    }
  }
}