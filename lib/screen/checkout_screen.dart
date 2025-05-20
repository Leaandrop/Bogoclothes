import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/product_model.dart';
import '../models/order_model.dart';
import '../core/colors.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Product> carrito;

  const CheckoutScreen({Key? key, required this.carrito}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<String> direcciones = [];
  List<String> pagos = ['Efectivo', 'Nequi', 'Tarjeta'];
  String? direccionSeleccionada;
  String? pagoSeleccionado;
  final TextEditingController direccionController = TextEditingController();

  // Para adjuntar imagen de comprobante NEQUI
  File? comprobanteNequi;

  @override
  void initState() {
    super.initState();
    _loadDirecciones();
    pagoSeleccionado = pagos.first;
  }

  Future<void> _loadDirecciones() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      direcciones = prefs.getStringList('user_addresses') ?? [];
      if (direcciones.isNotEmpty) direccionSeleccionada = direcciones.first;
    });
  }

  Future<void> _agregarDireccion() async {
    final direccion = direccionController.text.trim();
    if (direccion.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      direcciones.add(direccion);
      prefs.setStringList('user_addresses', direcciones);
      direccionSeleccionada = direccion;
      direccionController.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dirección agregada correctamente', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
    );
  }

  Future<void> _pickComprobanteNequi() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        comprobanteNequi = File(picked.path);
      });
    }
  }

  Future<void> _finalizarCompra() async {
    if (direccionSeleccionada == null || pagoSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Seleccione dirección y método de pago', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if (pagoSeleccionado == 'Nequi' && comprobanteNequi == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Adjunte comprobante de pago NEQUI', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ));
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    List<String> pedidos = prefs.getStringList('orders') ?? [];
    final order = Order(
      productos: widget.carrito,
      direccion: direccionSeleccionada!,
      metodoPago: pagoSeleccionado!,
      fecha: DateTime.now(),
    );
    pedidos.add(jsonEncode(order.toJson()));
    await prefs.setStringList('orders', pedidos);

    // Muestra mensaje de cargo realizado (solo para tarjeta)
    if (pagoSeleccionado == 'Tarjeta') {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: AppColors.backgroundLight,
          title: const Text('¡Pago realizado!',
              style: TextStyle(color: Colors.white, fontFamily: 'RobotoSlab')),
          content: const Text(
            'El cargo se realizó exitosamente a tu tarjeta guardada. Recibirás confirmación en tu correo.',
            style: TextStyle(color: Colors.white70, fontFamily: 'RobotoSlab'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el dialog
                Navigator.pop(context); // Regresa a pantalla anterior
              },
              child: const Text('OK', style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      );
      return;
    }

    // Para los demás métodos de pago, mensaje de compra exitosa
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.backgroundLight,
        title: const Text('¡Compra exitosa!', style: TextStyle(color: Colors.white, fontFamily: 'RobotoSlab')),
        content: const Text(
          'Tu pedido ha sido registrado exitosamente. Pronto recibirás confirmación.',
          style: TextStyle(color: Colors.white70, fontFamily: 'RobotoSlab'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cierra el dialog
              Navigator.pop(context); // Regresa a pantalla anterior
            },
            child: const Text('OK', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    direccionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carrito = widget.carrito;
    final total = carrito.fold<double>(0, (s, p) => s + p.precio);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Finalizar Compra', style: TextStyle(fontFamily: 'RobotoSlab')),
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: [
            const Text('Productos:', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'RobotoSlab', fontWeight: FontWeight.bold)),
            ...carrito.map((p) => ListTile(
              leading: Image.asset(p.imagen, width: 48),
              title: Text(p.nombre, style: const TextStyle(color: Colors.white)),
              subtitle: Text(p.marca, style: const TextStyle(color: Colors.white70)),
              trailing: Text('\$${p.precio.toStringAsFixed(0)}', style: const TextStyle(color: Colors.greenAccent)),
            )),
            const Divider(color: Colors.white24, height: 36),

            Text('Total: \$${total.toStringAsFixed(0)}',
              style: const TextStyle(color: Colors.greenAccent, fontFamily: 'RobotoSlab', fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 24),

            // SELECCIÓN DE DIRECCIÓN
            const Text('Dirección de Envío:', style: TextStyle(color: Colors.white, fontFamily: 'RobotoSlab', fontWeight: FontWeight.bold)),
            if (direcciones.isEmpty)
              const Text('No tienes direcciones guardadas. Agrega una debajo.', style: TextStyle(color: Colors.redAccent)),
            if (direcciones.isNotEmpty)
              DropdownButton<String>(
                value: direccionSeleccionada,
                dropdownColor: AppColors.backgroundLight,
                style: const TextStyle(color: Colors.white, fontFamily: 'RobotoSlab'),
                items: direcciones.map((dir) {
                  return DropdownMenuItem(
                    value: dir,
                    child: Text(dir, style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (v) => setState(() => direccionSeleccionada = v),
              ),

            // BOTÓN AGREGAR DIRECCIÓN
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: direccionController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Nueva dirección',
                      hintStyle: const TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _agregarDireccion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Agregar dirección', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // SELECCIÓN DE MÉTODO DE PAGO
            const Text('Método de Pago:', style: TextStyle(color: Colors.white, fontFamily: 'RobotoSlab', fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: pagoSeleccionado,
              dropdownColor: AppColors.backgroundLight,
              style: const TextStyle(color: Colors.white, fontFamily: 'RobotoSlab'),
              items: pagos.map((pago) {
                return DropdownMenuItem(
                  value: pago,
                  child: Text(pago, style: const TextStyle(color: Colors.white)),
                );
              }).toList(),
              onChanged: (v) => setState(() => pagoSeleccionado = v),
            ),

            // Si es NEQUI, mostrar botón para adjuntar comprobante
            if (pagoSeleccionado == 'Nequi') ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _pickComprobanteNequi,
                      icon: const Icon(Icons.attach_file, color: Colors.black),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      label: Text(
                        comprobanteNequi == null ? 'Adjuntar comprobante' : 'Comprobante adjuntado',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  if (comprobanteNequi != null)
                    const Icon(Icons.check_circle, color: Colors.green, size: 26),
                ],
              ),
            ],

            const SizedBox(height: 36),

            // BOTÓN FINALIZAR COMPRA
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.shopping_bag, color: Colors.black),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: _finalizarCompra,
                label: const Text(
                  'Finalizar Compra',
                  style: TextStyle(
                    color: Colors.black, 
                    fontFamily: 'RobotoSlab',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}