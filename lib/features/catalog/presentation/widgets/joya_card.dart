import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../domain/entities/joya.dart';

class JoyaCard extends StatelessWidget {
  final Joya joya;
  const JoyaCard({super.key, required this.joya});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: BrillanzaColors.gold.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack( // Stack para poner el texto de "Agotado" encima
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    joya.imageUrl, 
                    fit: BoxFit.cover, 
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                // --- MENSAJE DE AGOTADO ---
                if (joya.stock == 0)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: Text(
                        "¡AGOTADO!",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(joya.nombre, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text('\$${joya.precio}', style: const TextStyle(color: BrillanzaColors.gold)),
                
                // --- INDICADOR DE STOCK ---
                Text(
                  joya.stock > 0 ? 'Disponibles: ${joya.stock}' : 'Sin existencias',
                  style: TextStyle(
                    color: joya.stock < 3 ? Colors.redAccent : Colors.grey,
                    fontSize: 12,
                  ),
                ),
                
                const SizedBox(height: 5),
                ElevatedButton(
                  // Desactivamos el botón si no hay stock
                  onPressed: joya.stock == 0 ? null : () {
                    final cart = context.read<CartCubit>();
                    // Contamos cuántas unidades de esta joya ya hay en el carrito
                    final enCarrito = cart.state.where((item) => item.id == joya.id).length;

                    if (enCarrito < joya.stock && enCarrito < 10) {
                      cart.agregarAlCarrito(joya);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${joya.nombre} añadida al joyero'),
                          backgroundColor: BrillanzaColors.gold,
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    } else {
                      // Mensaje de límite alcanzado
                      String msg = enCarrito >= 10 ? 'Límite de 10 unidades' : 'No hay más stock';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(msg), backgroundColor: Colors.redAccent),
                      );
                    }
                  },
                  child: const Icon(Icons.add_shopping_cart),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}