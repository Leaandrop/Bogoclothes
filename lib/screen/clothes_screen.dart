import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../data/products_data.dart';
import '../widgets/product_card.dart';
import '../widgets/custom_app_bar.dart';

class ClothesScreen extends StatelessWidget {
  const ClothesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsRopa = products.where((p) => p.categoria == 'Ropa').toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Ropa'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          itemCount: productsRopa.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.67,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final product = productsRopa[index];
            return ProductCard(
              product: product,
              onTap: () {
                Navigator.pushNamed(context, '/productDetail', arguments: product);
              },
            );
          },
        ),
      ),
    );
  }
}