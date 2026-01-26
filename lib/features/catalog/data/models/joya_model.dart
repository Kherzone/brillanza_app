// Usamos puntos para que no dependa del nombre del proyecto
import '../../domain/entities/joya.dart';

class JoyaModel extends Joya {
  JoyaModel({
    required super.id,
    required super.nombre,
    required super.descripcion,
    required super.precio,
    required super.imageUrl,
    super.modelo3dUrl,
    required super.categoria,
    // --- NUEVO: Pasamos el stock a la entidad padre ---
    required super.stock, 
  });

  factory JoyaModel.fromFirestore(Map<String, dynamic> data, String id) {
    return JoyaModel(
      id: id,
      nombre: data['nombre'] ?? '',
      descripcion: data['descripcion'] ?? '',
      precio: (data['precio'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      modelo3dUrl: data['modelo3dUrl'],
      categoria: data['categoria'] ?? 'General',
      // --- NUEVO: Extraemos el stock de Firebase ---
      // Usamos .toInt() por seguridad si en Firebase se guardó como double
      stock: (data['stock'] ?? 0).toInt(), 
    );
  }
}