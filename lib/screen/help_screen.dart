import 'package:flutter/material.dart';
import '../core/colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        title: const Text('Centro de Ayuda', style: TextStyle(fontFamily: 'RobotoSlab')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('PREGUNTAS FRECUENTES',
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Text(
                '¿Cómo hago un pedido?\n'
                'Selecciona tus productos y agrégalos al carrito. Luego sigue el proceso de pago.\n\n'
                '¿Cuánto tarda el envío?\n'
                'Generalmente entre 2 y 5 días hábiles según tu ubicación.\n\n'
                '¿Qué métodos de pago aceptan?\n'
                'Tarjeta de crédito/débito y transferencias con entidades aliadas.\n\n'
                '¿Cómo rastreo mi pedido?\n'
                'Recibirás un correo con tu número de seguimiento una vez despachemos tu compra.',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              SizedBox(height: 22),
              Text('¿Tienes más dudas? Escríbenos a soporte@bogoclothes.com',
                  style: TextStyle(color: Colors.green)),
            ],
          ),
        ),
      ),
    );
  }
}