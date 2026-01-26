import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors.dart';
import '../../../catalog/domain/entities/joya.dart';
import '../cubit/cart_cubit.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MI JOYERO', style: TextStyle(color: BrillanzaColors.gold)),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<CartCubit, List<Joya>>(
        builder: (context, items) {
          if (items.isEmpty) return const Center(child: Text("Tu joyero está vacío"));
          
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: Image.network(items[index].imageUrl, width: 50),
                    title: Text(items[index].nombre, style: const TextStyle(color: Colors.white)),
                    subtitle: Text('\$${items[index].precio}', style: const TextStyle(color: BrillanzaColors.gold)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => context.read<CartCubit>().quitarDelCarrito(items[index]),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("TOTAL: \$${context.read<CartCubit>().total}", 
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutPage())),
                      child: const Text("PAGAR"),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}