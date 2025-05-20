import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../core/colors.dart';
import '../models/cart_manager.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({required this.product, Key? key})
    : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? selectedTalla;

  @override
  void initState() {
    super.initState();
    if (widget.product.tallas.isNotEmpty) {
      selectedTalla = widget.product.tallas.first;
    }
  }

  void addToCart() {
    cartManager.add(widget.product); // <--- ¡AGREGA!
    String tallaMsg = '';
    if (widget.product.tallas.isNotEmpty && selectedTalla != null) {
      tallaMsg = ' (Talla $selectedTalla)';
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Producto añadido al carrito$tallaMsg'),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        title: Text(
          product.nombre,
          style: const TextStyle(fontFamily: 'RobotoSlab'),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(product.imagen, height: 160),
            const SizedBox(height: 16),
            Text(
              product.nombre,
              style: const TextStyle(
                color: AppColors.primary,
                fontFamily: 'RobotoSlab',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Solo mostrar la marca si no hay tallas
            if (product.tallas.isEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Chip(
                  backgroundColor: Colors.white,
                  label: Text(
                    product.marca,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'RobotoSlab',
                    ),
                  ),
                ),
              ),
            // Mostrar las tallas si existen (solo para ropa)
            if (product.tallas.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Talla:',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'RobotoSlab',
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    dropdownColor: AppColors.backgroundLight,
                    value: selectedTalla,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'RobotoSlab',
                    ),
                    items:
                        product.tallas.map((talla) {
                          return DropdownMenuItem(
                            value: talla,
                            child: Text(
                              talla,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedTalla = value!;
                      });
                    },
                  ),
                ],
              ),
            const SizedBox(height: 10),
            Text(
              '\$${product.precio.toStringAsFixed(0)}',
              style: TextStyle(
                color: AppColors.primary,
                fontFamily: 'RobotoSlab',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.descripcion,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'RobotoSlab',
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.shopping_cart, color: Colors.black),
                onPressed: addToCart,
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                label: const Text(
                  'Agregar al carrito',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'RobotoSlab',
                    fontSize: 18,
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
