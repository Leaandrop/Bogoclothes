import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/routes.dart';
import '../core/strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Spacer(),

          // Logo
          Image.asset(
            'assets/icons/app-logo.png',
            width: 300,
            height: 300,
            fit: BoxFit.contain,
          ),

          // Nombre de la App (más pegado)
          Transform.translate(
            offset: const Offset(0, -25), 
            child: Text(
              AppStrings.appName,
              style: const TextStyle(
                fontFamily: 'RobotoSlab',
                color: AppColors.textPrimary,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Descripción
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              AppStrings.splashTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'RobotoSlab',
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Botón "Comienza"
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(Routes.login);
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2),
            ),
            child: const Text(
              'Comienza',
              style: TextStyle(
                fontFamily: 'RobotoSlab',
                color: Colors.black,
                fontSize: 22,
              ),
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}
