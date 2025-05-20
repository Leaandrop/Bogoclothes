import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'product_model.dart';

class UserLocalData {
  static const _favoritesKey = 'favorites';
  static const _ordersKey = 'orders';

  // Guardar favoritos
  static Future<void> saveFavorites(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = products.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList(_favoritesKey, jsonList);
  }

  static Future<List<Product>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_favoritesKey) ?? [];
    return jsonList.map((e) => Product.fromJson(jsonDecode(e))).toList();
  }

  // Guardar pedidos
  static Future<void> saveOrders(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = products.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList(_ordersKey, jsonList);
  }

  static Future<List<Product>> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_ordersKey) ?? [];
    return jsonList.map((e) => Product.fromJson(jsonDecode(e))).toList();
  }

  // Limpiar todo (opcional, para cerrar sesión)
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}