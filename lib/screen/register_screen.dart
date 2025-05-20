import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController identificacionController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  DateTime? fechaNacimiento;

  @override
  void dispose() {
    nombreController.dispose();
    correoController.dispose();
    passwordController.dispose();
    identificacionController.dispose();
    direccionController.dispose();
    telefonoController.dispose();
    super.dispose();
  }

  void validarYRegistrar() {
    final nombre = nombreController.text.trim();
    final correo = correoController.text.trim();
    final pass = passwordController.text.trim();
    final identificacion = identificacionController.text.trim();
    final direccion = direccionController.text.trim();
    final telefono = telefonoController.text.trim();

    if (nombre.isEmpty || correo.isEmpty || pass.isEmpty || identificacion.isEmpty || direccion.isEmpty || telefono.isEmpty || fechaNacimiento == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Todos los campos son obligatorios.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registro exitoso. Ya puedes iniciar sesión.'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Routes.login);
    });
  }

  Future<void> _selectFechaNacimiento() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        fechaNacimiento = picked;
      });
    }
  }

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
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset('assets/icons/app-logo.png', width: 180, height: 180),
                const SizedBox(height: 0.5),
                const Text(
                  '¡Crea tu cuenta!',
                  style: TextStyle(
                    fontFamily: 'RobotoSlab',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Parchate con nosotros y lleva tu estilo más allá.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'RobotoSlab',
                    fontSize: 16,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 30),

                // Nombre
                TextField(
                  controller: nombreController,
                  decoration: _inputDecoration('Nombre completo', Icons.person),
                ),
                const SizedBox(height: 20),

                // Identificación
                TextField(
                  controller: identificacionController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration('Identificación', Icons.credit_card),
                ),
                const SizedBox(height: 20),

                // Correo
                TextField(
                  controller: correoController,
                  decoration: _inputDecoration('Correo electrónico', Icons.email),
                ),
                const SizedBox(height: 20),

                // Contraseña
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: _inputDecoration('Contraseña', Icons.lock),
                ),
                const SizedBox(height: 20),

                // Dirección
                TextField(
                  controller: direccionController,
                  decoration: _inputDecoration('Dirección', Icons.home),
                ),
                const SizedBox(height: 20),

                // Teléfono
                TextField(
                  controller: telefonoController,
                  keyboardType: TextInputType.phone,
                  decoration: _inputDecoration('Teléfono', Icons.phone),
                ),
                const SizedBox(height: 20),

                // Fecha de nacimiento
                InkWell(
                  onTap: _selectFechaNacimiento,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(
                      fechaNacimiento == null
                          ? 'Fecha de nacimiento'
                          : 'Nacimiento: ${fechaNacimiento!.day}/${fechaNacimiento!.month}/${fechaNacimiento!.year}',
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Botón
                OutlinedButton(
                  onPressed: validarYRegistrar,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(
                      fontFamily: 'RobotoSlab',
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText, IconData icon) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black),
      ),
    );
  }
}
