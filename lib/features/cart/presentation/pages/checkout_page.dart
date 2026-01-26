import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors.dart';
import '../cubit/cart_cubit.dart';
import '../../../catalog/domain/entities/joya.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos el estado del carrito para mostrar total y productos
    final cartCubit = context.watch<CartCubit>();
    final total = cartCubit.total;
    final List<Joya> items = cartCubit.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('FINALIZAR COMPRA', style: TextStyle(fontFamily: 'Georgia')),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("RESUMEN DE TU PEDIDO", 
              style: TextStyle(color: BrillanzaColors.gold, letterSpacing: 2, fontWeight: FontWeight.bold)),
            const Divider(color: Colors.white24, height: 30),
            
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(items[index].nombre, style: const TextStyle(color: Colors.white70)),
                      Text('\$${items[index].precio}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),

            const Divider(color: Colors.white24, height: 30),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("TOTAL A PAGAR", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('\$$total', 
                  style: const TextStyle(fontSize: 22, color: BrillanzaColors.gold, fontWeight: FontWeight.bold)),
              ],
            ),
            
            const SizedBox(height: 40),
            
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: BrillanzaColors.gold),
                onPressed: () => _mostrarExito(context),
                child: const Text("CONFIRMAR PAGO", 
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarExito(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF111111),
        title: const Icon(Icons.check_circle_outline, color: BrillanzaColors.gold, size: 60),
        content: const Text(
          "¡Pago realizado con éxito!\nGracias por confiar en Brillanza.", 
          textAlign: TextAlign.center, 
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // --- EL CAMBIO CLAVE ESTÁ AQUÍ ---
              // 1. Vaciamos el carrito antes de salir
              context.read<CartCubit>().vaciarCarrito();
              
              // 2. Volvemos a la pantalla principal (Catálogo)
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text("VOLVER AL INICIO", style: TextStyle(color: BrillanzaColors.gold)),
          )
        ],
      ),
    );
  }
}