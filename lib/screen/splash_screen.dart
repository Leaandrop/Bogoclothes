import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/routes.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacementNamed(Routes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Cambia color de la barra de estado
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundLight,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          // Logo + texto centrado
          Transform.translate(
            offset: const Offset(0, -65),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Image.asset(
                    'assets/icons/app-logo.png',
                    width: 400,
                    height: 400,
                    fit: BoxFit.contain,
                  ),

                  Transform.translate(
                    offset: const Offset(0, -80), 
                    child: Text(
                      'Diseños con ritmo propio.',
                      style: const TextStyle(
                        fontFamily: 'RobotoSlab',
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Autor abajo a la derecha
          Positioned(
            right: 20,
            bottom: 20,
            child: Text(
              'D. Alejandro Jiménez Ramírez y David A. Rivera Raigoso',
              style: const TextStyle(
                fontFamily: 'RobotoSlab',
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
