import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/favorites_manager.dart';
import '../models/cart_manager.dart';
import '../core/colors.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({required this.product, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: AppColors.card,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Image.asset(product.imagen, fit: BoxFit.contain)),
                  const SizedBox(height: 8),
                  Text(product.nombre,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'RobotoSlab')),
                  const SizedBox(height: 4),
                  Text('\$${product.precio.toStringAsFixed(0)}',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'RobotoSlab')),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        cartManager.add(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Producto añadido al carrito'),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Agregar al carrito',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'RobotoSlab',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: ValueListenableBuilder<Set<Product>>(
                valueListenable: favoritesManager,
                builder: (context, favorites, child) {
                  final isFav = favorites.contains(product);
                  return GestureDetector(
                    onTap: () {
                      favoritesManager.toggleFavorite(product);
                    },
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.grey,
                      size: 28,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}