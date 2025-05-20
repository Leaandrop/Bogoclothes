import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void validarYIngresar() {
    final correo = correoController.text.trim();
    final pass = passwordController.text.trim();

    if (correo.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor completa todos los campos.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pushReplacementNamed(context, Routes.welcome);
  }

  @override
  void dispose() {
    correoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, Routes.home);
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
              Navigator.pushReplacementNamed(context, Routes.home);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'assets/icons/app-logo.png',
                  width: 180,
                  height: 180,
                ),
                const SizedBox(height: 0.5),
                const Text(
                  'Parchate y sé tú mismx.',
                  style: TextStyle(
                    fontFamily: 'RobotoSlab',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Tu estilo, tu ritmo. Viste diferente con Bogoclothes.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'RobotoSlab',
                    fontSize: 16,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 30),

                // Correo
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.person, color: AppColors.textPrimary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: correoController,
                        decoration: InputDecoration(
                          hintText: 'Correo electrónico',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Contraseña
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.vpn_key, color: AppColors.textPrimary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Contraseña',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                OutlinedButton(
                  onPressed: validarYIngresar,
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
                    'Ingresar',
                    style: TextStyle(
                      fontFamily: 'RobotoSlab',
                      color: AppColors.secondary,
                      fontSize: 22,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.recover);
                  },
                  child: const Text(
                    'Recupera tu contraseña',
                    style: TextStyle(
                      fontFamily: 'RobotoSlab',
                      color: Colors.white,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Google Sign-In
                  },
                  icon: Image.asset(
                    'assets/icons/google.png',
                    width: 20,
                    height: 20,
                  ),
                  label: const Text(
                    'Ingresa con Google',
                    style: TextStyle(
                      fontFamily: 'RobotoSlab',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.black12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿No tienes cuenta? ',
                      style: TextStyle(
                        fontFamily: 'RobotoSlab',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.register);
                      },
                      child: const Text(
                        'Regístrate',
                        style: TextStyle(
                          fontFamily: 'RobotoSlab',
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
