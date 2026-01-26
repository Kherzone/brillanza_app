import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart'; 
import 'core/colors.dart';

// Repositorios y Cubits del Catálogo
import 'features/catalog/data/repositories/joyeria_repository_impl.dart';
import 'features/catalog/presentation/cubit/catalog_cubit.dart';

// --- NUEVOS IMPORTS DE AUTENTICACIÓN ---
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/pages/login_page.dart'; 

// --- IMPORT DEL CARRITO (AÑADIDO) ---
import 'features/cart/presentation/cubit/cart_cubit.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CatalogCubit(JoyeriaRepositoryImpl())..fetchCatalog(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(AuthRepository()),
        ),
        // --- REGISTRO DEL CARRITO (AÑADIDO) ---
        BlocProvider(
          create: (context) => CartCubit(),
        ),
      ],
      child: const BrillanzaApp(),
    ),
  );
}

class BrillanzaApp extends StatelessWidget {
  const BrillanzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brillanza Jewelry',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: BrillanzaColors.deepBlack, 
        primaryColor: BrillanzaColors.gold,
        fontFamily: 'Georgia', 
      ),
      home: const LoginPage(),
    );
  }
}