import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/routes.dart';

class RecoverScreen extends StatelessWidget {
  const RecoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController correoController = TextEditingController();

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
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset('assets/icons/app-logo.png', width: 160, height: 160),

              const SizedBox(height: 20),

              const Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Escribe tu correo y te enviaremos un enlace para restablecer tu contraseña.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: correoController,
                decoration: InputDecoration(
                  hintText: 'Correo electrónico',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              OutlinedButton(
                onPressed: () {
                  final correo = correoController.text.trim();

                  if (correo.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('El campo no puede estar vacío.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Si el correo está registrado, ya debió llegarte un enlace para restablecer la contraseña.',
                        ),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );

                    Future.delayed(const Duration(seconds: 4), () {
                      Navigator.pushReplacementNamed(context, Routes.login);
                    });
                  }
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Enviar enlace',
                  style: TextStyle(
                    fontFamily: 'RobotoSlab',
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
