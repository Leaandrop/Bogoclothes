import 'package:flutter/material.dart';
import 'package:proyecto7/screen/personal_info_screen.dart';

import '../core/routes.dart';
import 'screen/home_screen.dart';
import 'screen/splash_screen.dart';
import 'screen/login_screen.dart';
import 'screen/register_screen.dart';
import 'screen/recover_screen.dart';
import 'screen/welcome_screen.dart';
import 'screen/profile_screen.dart';
import 'screen/clothes_screen.dart';
import 'screen/perfumes_screen.dart';
import 'screen/accessories_screen.dart';
import 'screen/store_screen.dart';
import 'screen/product_detail_screen.dart';
import 'screen/cart_screen.dart';
import 'screen/favorites_screen.dart';
import 'screen/help_screen.dart';
import 'screen/terms_screen.dart';
import 'screen/privacy_screen.dart';

import '../models/product_model.dart'; // <-- necesario para arguments en detalle

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bogoclothes',
      initialRoute: Routes.splash,
      routes: {
        Routes.splash: (context) => const SplashScreen(),
        Routes.home: (context) => const HomeScreen(),
        Routes.login: (context) => const LoginScreen(),
        Routes.register: (context) => const RegisterScreen(),
        Routes.recover: (context) => const RecoverScreen(),
        Routes.welcome: (context) => const WelcomeScreen(),
        Routes.profile: (context) => const ProfileScreen(),
        Routes.clothes: (context) => const ClothesScreen(),
        Routes.perfumes: (context) => const PerfumesScreen(),
        Routes.accessories: (context) => const AccessoriesScreen(),
        Routes.store: (context) => const StoreScreen(),
        Routes.cart: (context) => const CartScreen(),
        Routes.favorites: (context) => const FavoritesScreen(),
        Routes.help: (context) => const HelpScreen(),
        Routes.terms: (context) => const TermsScreen(),
        Routes.privacy: (context) => const PrivacyScreen(),
        Routes.personal: (context) => const PersonalInfoScreen(),
      },
      // Agrega onGenerateRoute para pasar argumentos (detalle producto)
      onGenerateRoute: (settings) {
        if (settings.name == '/productDetail') {
          final product = settings.arguments as Product;
          return MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          );
        }
        return null; // ruta no encontrada
      },
    );
  }
}
