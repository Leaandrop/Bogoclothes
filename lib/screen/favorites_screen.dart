import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../models/favorites_manager.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Favoritos', style: TextStyle(fontFamily: 'RobotoSlab')),
        backgroundColor: AppColors.backgroundLight,
      ),
      body: ValueListenableBuilder<Set<Product>>(
        valueListenable: favoritesManager,
        builder: (context, favorites, _) {
          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                'No tienes productos favoritos aún.',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final product = favorites.elementAt(index);
              return ProductCard(
                product: product,
                onTap: () {
                  Navigator.pushNamed(context, '/productDetail', arguments: product);
                },
              );
            },
          );
        },
      ),
    );
  }
}