class Joya {
  final String id;
  final String nombre;
  final String descripcion;
  final double precio;
  final String imageUrl;
  final String? modelo3dUrl;
  final String categoria;
  // --- CAMBIO AQUÍ: Añadimos el stock ---
  final int stock; 

  Joya({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.imageUrl,
    this.modelo3dUrl,
    required this.categoria,
    // --- CAMBIO AQUÍ: Requerimos el stock en el constructor ---
    required this.stock, 
  });
}