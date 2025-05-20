import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../models/cart_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showFavorites;
  const CustomAppBar({Key? key, required this.title, this.showFavorites = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundLight,
      title: Text(title, style: const TextStyle(fontFamily: 'RobotoSlab', color: Colors.white)),
      foregroundColor: Colors.white,
      elevation: 0,
      actions: [
        if (showFavorites) ...[
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
            tooltip: 'Favoritos',
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
          ),
        ],
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              tooltip: 'Carrito',
              onPressed: () => Navigator.pushNamed(context, '/cart'),
            ),
            // El contador animado:
            AnimatedBuilder(
              animation: cartManager,
              builder: (context, _) {
                final count = cartManager.items.values.fold(0, (a, b) => a + b);
                if (count == 0) return const SizedBox.shrink();
                return Positioned(
                  right: 8,
                  top: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      '$count',
                      style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}