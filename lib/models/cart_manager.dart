import 'package:flutter/material.dart';
import 'product_model.dart';

class CartManager extends ChangeNotifier {
  final Map<Product, int> _items = {};

  Map<Product, int> get items => _items;

  void add(Product product) {
    if (_items.containsKey(product)) {
      _items[product] = _items[product]! + 1;
    } else {
      _items[product] = 1;
    }
    notifyListeners();
  }

  void remove(Product product) {
    if (_items.containsKey(product)) {
      if (_items[product]! > 1) {
        _items[product] = _items[product]! - 1;
      } else {
        _items.remove(product);
      }
      notifyListeners();
    }
  }

  void delete(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  double get subtotal =>
      _items.entries.fold(0, (sum, e) => sum + e.key.precio * e.value);

  double get iva => subtotal * 0.19;
  double get total => subtotal + iva;
}

// Instancia global:
final cartManager = CartManager();