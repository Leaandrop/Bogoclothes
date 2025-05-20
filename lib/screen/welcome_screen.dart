import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, Routes.login);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundLight,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.login);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, Routes.profile);
              },
              tooltip: 'Perfil',
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                '¡Te damos la bienvenida!',
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Encuentra lo que necesitas con estilo propio.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              // Imagen principal del banner de bienvenida
              Image.asset(
                'assets/icons/app-logo.png',
                height: 180,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 30),
              const Text(
                'Explora nuestras categorías destacadas:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoSlab',
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Sección de categorías
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, Routes.clothes),
                    child: _categoryIcon(
                      'assets/images/categoria_ropa.png',
                      'Ropa',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, Routes.perfumes),
                    child: _categoryIcon(
                      'assets/images/categoria_perfumes.png',
                      'Perfumes',
                    ),
                  ),
                  GestureDetector(
                    onTap:
                        () => Navigator.pushNamed(context, Routes.accessories),
                    child: _categoryIcon(
                      'assets/images/categoria_accesorios.png',
                      'Accesorios',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.store);
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Ir a la tienda',
                  style: TextStyle(
                    fontFamily: 'RobotoSlab',
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                '¡Haz tu pedido en minutos!',
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontSize: 16,
                  color: AppColors.textPrimary,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Íconos de categorías con imagen y texto
  Widget _categoryIcon(String imagePath, String label) {
    return Column(
      children: [
        Image.asset(imagePath, width: 70, height: 70),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontFamily: 'RobotoSlab'),
        ),
      ],
    );
  }
}
