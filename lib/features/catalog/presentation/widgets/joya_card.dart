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
        border: Border.all(color: BrillanzaColors.gold.withValues(alpha: 0.3)), // Flutter moderno
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(joya.imageUrl, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(joya.nombre, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text('\$${joya.precio}', style: const TextStyle(color: BrillanzaColors.gold)),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    context.read<CartCubit>().agregarAlCarrito(joya); // Conexión al cerebro
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${joya.nombre} añadida'), duration: const Duration(seconds: 1)),
                    );
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