import 'package:flutter/material.dart';
import 'product_model.dart';

class FavoritesManager extends ValueNotifier<Set<Product>> {
  FavoritesManager() : super(<Product>{});

  bool isFavorite(Product product) => value.contains(product);

  void toggleFavorite(Product product) {
    final newSet = Set<Product>.from(value);
    if (newSet.contains(product)) {
      newSet.remove(product);
    } else {
      newSet.add(product);
    }
    value = newSet;
  }
}

// Instancia global sencilla:
final favoritesManager = FavoritesManager();