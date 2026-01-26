import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../catalog/domain/entities/joya.dart'; 

class CartCubit extends Cubit<List<Joya>> {
  CartCubit() : super([]);

  void agregarAlCarrito(Joya joya) {
    // 1. Contamos cuántas unidades de ESTA joya específica ya hay en el carrito
    final unidadesEnCarrito = state.where((item) => item.id == joya.id).length;

    // 2. Validamos el límite: Máximo 10 Y que no supere el stock disponible
    if (unidadesEnCarrito < 10 && unidadesEnCarrito < joya.stock) {
      emit([...state, joya]);
    } else {
      // Si llega al límite, no emite nada nuevo (el botón no hará nada)
      print("Límite de disponibilidad alcanzado para: ${joya.nombre}");
    }
  }

  void quitarDelCarrito(Joya joya) {
    final nuevaLista = List<Joya>.from(state)..remove(joya);
    emit(nuevaLista);
  }

  // Limpia el joyero después de la compra exitosa
  void vaciarCarrito() => emit([]); 

  // Calcula el total sumando los precios de la lista
  double get total => state.fold(0, (sum, item) => sum + item.precio);
}