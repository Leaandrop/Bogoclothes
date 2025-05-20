import 'package:flutter/material.dart';
import '../core/colors.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Términos y Condiciones'),
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
                'Términos y Condiciones',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.green,
                  fontFamily: 'RobotoSlab',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Al utilizar Bogoclothes, aceptas los siguientes términos de uso y condiciones generales del servicio:',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 14),
              const Text(
                'Sobre el uso del sistema',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
              ),
              const Text(
                'Esta aplicación está diseñada con fines educativos y de demostración. No se realizan compras reales ni se solicitan datos bancarios válidos.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'El usuario es responsable de la información que proporciona durante el registro y en su perfil. Bogoclothes no se hace responsable por datos mal ingresados.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sobre la funcionalidad del sistema',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
              ),
              const Text(
                'Las funciones de favoritos, pedidos, métodos de pago y direcciones son simuladas y no se conectan con servicios reales de entrega ni de cobro.\n'
                'El contenido visual y los productos mostrados son ficticios o de referencia, usados con fines de prueba.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Manejo seguro de formularios y compras simuladas',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
              ),
              const Text(
                'Aunque no hay transacciones reales, evita ingresar datos financieros reales en campos de prueba.\n'
                'Toda la información que ingreses debe ser verídica para evitar errores en la navegación de tu perfil o historial de pedidos.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Contacto y Soporte Técnico',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'RobotoSlab'),
                  children: [
                    TextSpan(
                      text: 'Si presentas dificultades técnicas, errores persistentes o tienes sugerencias para mejorar la aplicación, puedes contactarnos. Nuestro equipo está disponible para brindarte ayuda o recibir tus comentarios.\n\n'
                    ),
                    TextSpan(
                      text: 'Correo de soporte: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'bogoclothes.soporte@gmail.com\n',
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Horario de atención: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Lunes a viernes de 9:00 a.m. a 5:00 p.m.\n',
                    ),
                    TextSpan(
                      text: 'Tiempo estimado de respuesta: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'entre 1 y 2 días hábiles.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Qué incluir en tu mensaje',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
              ),
              const Text(
                '• El tipo de problema que estás experimentando.\n'
                '• La versión del sistema operativo de tu dispositivo.\n'
                '• El modelo de tu celular o tablet.\n'
                '• Capturas de pantalla si es posible.\n'
                'Nuestro equipo agradece tus aportes. Tu experiencia nos ayuda a seguir mejorando Bogoclothes.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}