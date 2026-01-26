import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors.dart';
import '../cubit/auth_cubit.dart';
import '../../../catalog/presentation/pages/catalog_page.dart'; // Importamos el catálogo

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos BlocListener para reaccionar a los cambios de estado
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          // Si el SHA-1 es correcto y el usuario entra, lo mandamos al catálogo
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const CatalogPage()),
          );
        } else if (state is AuthError) {
          // Si hay un error (ej. canceló el login), mostramos un mensaje
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error de autenticación: ${state.message}')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: BrillanzaColors.deepBlack,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'BRILLANZA',
                  style: TextStyle(
                    color: BrillanzaColors.gold,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                    fontFamily: 'Georgia',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'FINE JEWELRY',
                  style: TextStyle(color: Colors.white70, letterSpacing: 2, fontSize: 12),
                ),
                const SizedBox(height: 80),
                
                // Usamos BlocBuilder solo para el botón para mostrar carga
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator(color: BrillanzaColors.gold);
                    }
                    
                    return OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: BrillanzaColors.gold, width: 1.5),
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                      ),
                      icon: const Icon(Icons.login, color: Colors.white),
                      label: const Text(
                        'CONTINUAR CON GOOGLE',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        // ¡Aquí se activa la magia del SHA-1!
                        context.read<AuthCubit>().loginWithGoogle();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}