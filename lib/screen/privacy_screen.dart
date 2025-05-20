import 'package:flutter/material.dart';
import '../core/colors.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Política de Privacidad'),
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Política de Privacidad',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.green,
                  fontFamily: 'RobotoSlab',
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Consejos de Seguridad',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
              ),
              const SizedBox(height: 6),
              const Text(
                'Para garantizar una experiencia segura y proteger tu información personal mientras usas Bogoclothes, te recomendamos seguir las siguientes buenas prácticas:',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                'Protección de cuenta:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green),
              ),
              const Text(
                '• Usa contraseñas seguras: Incluye mayúsculas, minúsculas, números y símbolos especiales. Evita usar datos obvios como tu nombre o fecha de nacimiento.\n'
                '• No compartas tus credenciales: Nunca entregues tu usuario o contraseña a otras personas, ni siquiera si te lo piden por mensaje o correo.\n'
                '• Cierra sesión en dispositivos compartidos: Si usas un celular o tablet que no es tuyo, asegúrate de cerrar sesión al finalizar.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                'Protección de datos personales:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green),
              ),
              const Text(
                '• Tus datos se almacenan localmente: Esto significa que la información no se sube a servidores externos. Sin embargo, sigue siendo importante proteger el acceso físico a tu dispositivo.\n'
                '• Actualiza regularmente tu sistema operativo: Las actualizaciones corrigen errores de seguridad que pueden afectar otras aplicaciones también.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sobre la privacidad',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
              ),
              const Text(
                'La app no comparte tus datos con terceros.\n'
                'Toda la información ingresada queda almacenada únicamente en el dispositivo del usuario.\n'
                'El uso de Bogoclothes implica la aceptación de estas condiciones. Si no estás de acuerdo, te recomendamos no continuar con la instalación o uso del aplicativo.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 18),
              const Text(
                'Contacto para dudas sobre privacidad:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'RobotoSlab'),
                  children: [
                    TextSpan(
                      text: 'Si tienes inquietudes sobre la privacidad de tus datos, escríbenos a ',
                    ),
                    TextSpan(
                      text: 'bogoclothes.soporte@gmail.com',
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}