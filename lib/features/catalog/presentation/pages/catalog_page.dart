import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors.dart';
import '../../domain/entities/joya.dart';
import '../cubit/catalog_cubit.dart';
import '../cubit/catalog_state.dart';

// --- NUEVOS IMPORTS ---
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/presentation/pages/cart_page.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BRILLANZA', 
          style: TextStyle(
            color: BrillanzaColors.gold, 
            fontWeight: FontWeight.bold, 
            letterSpacing: 2
          )
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        // --- BOTÓN DE CARRITO CON NOTIFICACIÓN ---
        actions: [
          BlocBuilder<CartCubit, List<Joya>>(
            builder: (context, items) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_bag_outlined, color: BrillanzaColors.gold),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartPage()),
                    ),
                  ),
                  if (items.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                        child: Text(
                          '${items.length}',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CatalogCubit, CatalogState>(
        builder: (context, state) {
          if (state is CatalogLoading) {
            return const Center(child: CircularProgressIndicator(color: BrillanzaColors.gold));
          } else if (state is CatalogSuccess) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65, // Ajustado para que quepa el botón de agregar
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.joyas.length,
              itemBuilder: (context, index) {
                return _JoyaCard(joya: state.joyas[index]);
              },
            );
          } else if (state is CatalogError) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _JoyaCard extends StatelessWidget {
  final Joya joya; // Cambiado de dynamic a Joya para mayor seguridad
  const _JoyaCard({required this.joya});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(15),
        // Corregido withOpacity por withValues para evitar advertencias
        border: Border.all(color: BrillanzaColors.gold.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: joya.imageUrl.isNotEmpty 
                ? Image.network(joya.imageUrl, fit: BoxFit.cover, width: double.infinity)
                : const Center(child: Icon(Icons.image, color: Colors.grey)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  joya.nombre, 
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14), 
                  maxLines: 1, 
                  overflow: TextOverflow.ellipsis
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${joya.precio}', 
                  style: const TextStyle(color: BrillanzaColors.gold, fontSize: 16, fontWeight: FontWeight.bold)
                ),
                const SizedBox(height: 8),
                // --- BOTÓN DE AGREGAR AL CARRITO ---
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                    ),
                    onPressed: () {
                      context.read<CartCubit>().agregarAlCarrito(joya);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${joya.nombre} agregada al joyero'),
                          duration: const Duration(seconds: 1),
                          backgroundColor: BrillanzaColors.gold,
                        ),
                      );
                    },
                    child: const Icon(Icons.add_shopping_cart, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}