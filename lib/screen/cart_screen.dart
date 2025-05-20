import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../models/cart_manager.dart';
import '../models/product_model.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController discountController = TextEditingController();
  double descuento = 0;

  @override
  void dispose() {
    discountController.dispose();
    super.dispose();
  }

  void aplicarDescuento() {
    if (discountController.text.trim().toUpperCase() == "ALEJANDRO") {
      setState(() {
        descuento = cartManager.subtotal * 0.2; // 20% descuento
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Descuento Alejandro aplicado!', style: TextStyle(color: Colors.white)), backgroundColor: Colors.green),
      );
    } else {
      setState(() {
        descuento = 0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Código no válido', style: TextStyle(color: Colors.white)), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = cartManager.items.entries.toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Carrito de Compras', style: TextStyle(fontFamily: 'RobotoSlab')),
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white),
            tooltip: 'Vaciar carrito',
            onPressed: () {
              cartManager.clear();
              setState(() {});
            },
          ),
        ],
      ),
      body: items.isEmpty
          ? const Center(
              child: Text(
                'Tu carrito está vacío.',
                style: TextStyle(color: Colors.white70, fontFamily: 'RobotoSlab'),
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          ...items.map((entry) {
                            final Product product = entry.key;
                            final int cantidad = entry.value;
                            return Card(
                              color: Colors.white,
                              margin: const EdgeInsets.only(top: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                child: Row(
                                  children: [
                                    Image.asset(product.imagen, width: 55),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(product.nombre, style: const TextStyle(fontFamily: 'RobotoSlab', color: Colors.black, fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 2),
                                          Text(product.marca, style: const TextStyle(color: Colors.black87, fontFamily: 'RobotoSlab', fontSize: 13)),
                                          Text('\$${product.precio.toStringAsFixed(0)} x $cantidad', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove, color: Colors.redAccent),
                                          onPressed: () {
                                            cartManager.remove(product);
                                            setState(() {});
                                          },
                                        ),
                                        Text(
                                          '$cantidad',
                                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add, color: Colors.green),
                                          onPressed: () {
                                            cartManager.add(product);
                                            setState(() {});
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete, color: Colors.red),
                                          onPressed: () {
                                            cartManager.delete(product);
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),

                          const SizedBox(height: 20),

                          // Label separado
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Código de Descuento', style: TextStyle(fontFamily: 'RobotoSlab', color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 8),

                          // Caja y botón blanco
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: discountController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'Ingresa tu código',
                                    hintStyle: TextStyle(color: Colors.black54),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: aplicarDescuento,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                ),
                                child: const Text('Aplicar', style: TextStyle(color: Colors.black)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Resumen de Compra', style: TextStyle(fontFamily: 'RobotoSlab', color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 6),
                          _resumenCompra(context),

                          const Spacer(),

                          // Botón finalizar compra
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => CheckoutScreen(carrito: items.expand((e) => List.generate(e.value, (_) => e.key)).toList())),
                                );
                              },
                              child: const Text(
                                'Proceder al Pago',
                                style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'RobotoSlab'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _resumenCompra(BuildContext context) {
    final subtotal = cartManager.subtotal;
    final iva = cartManager.iva;
    final total = subtotal + cartManager.iva - descuento;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Subtotal', style: TextStyle(color: Colors.white, fontFamily: 'RobotoSlab')),
          Text('\$${subtotal.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontFamily: 'RobotoSlab')),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Descuento', style: TextStyle(color: Colors.white, fontFamily: 'RobotoSlab')),
          Text('-\$${descuento.toStringAsFixed(0)}', style: const TextStyle(color: Colors.green, fontFamily: 'RobotoSlab')),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('IVA (19%)', style: TextStyle(color: Colors.white, fontFamily: 'RobotoSlab')),
          Text('\$${iva.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontFamily: 'RobotoSlab')),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'RobotoSlab', fontSize: 17)),
          Text('\$${total.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.greenAccent, fontFamily: 'RobotoSlab', fontSize: 17)),
        ]),
        const SizedBox(height: 10),
      ],
    );
  }
}
