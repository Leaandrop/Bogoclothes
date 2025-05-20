import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';
import '../core/colors.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Product> orders = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList('orders') ?? [];
    setState(() {
      orders = jsonList
          .map((e) => Product.fromJson(jsonDecode(e)))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(title: const Text('Mis Pedidos')),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: orders.isEmpty
            ? const Center(child: Text('No hay pedidos guardados.', style: TextStyle(color: Colors.white70)))
            : ListView.separated(
                itemCount: orders.length,
                separatorBuilder: (_, __) => const Divider(color: Colors.white24),
                itemBuilder: (ctx, i) {
                  final p = orders[i];
                  return ListTile(
                    leading: Image.asset(p.imagen, width: 50, height: 50),
                    title: Text(p.nombre, style: const TextStyle(color: Colors.white, fontFamily: 'RobotoSlab')),
                    subtitle: Text('\$${p.precio.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white70)),
                  );
                },
              ),
      ),
    );
  }
}