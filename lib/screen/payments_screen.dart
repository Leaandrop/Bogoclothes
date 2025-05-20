import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/colors.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final TextEditingController _cardController = TextEditingController();
  List<String> payments = [];

  @override
  void initState() {
    super.initState();
    _loadPayments();
  }

  Future<void> _loadPayments() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      payments = prefs.getStringList('user_payments') ?? [];
    });
  }

  Future<void> _savePayments() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('user_payments', payments);
  }

  void _addPayment() {
    if (_cardController.text.trim().isEmpty) return;
    setState(() {
      payments.add(_cardController.text.trim());
      _cardController.clear();
    });
    _savePayments();
  }

  void _removePayment(int idx) {
    setState(() {
      payments.removeAt(idx);
    });
    _savePayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(title: const Text('Métodos de Pago')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _cardController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Añadir tarjeta (ej: Tarjeta 1234)',
                labelStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white10,
              ),
              onSubmitted: (_) => _addPayment(),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: _addPayment,
              child: const Text('Agregar'),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: payments.isEmpty
                  ? const Text('No hay métodos de pago guardados.', style: TextStyle(color: Colors.white70))
                  : ListView.separated(
                      itemCount: payments.length,
                      separatorBuilder: (_, __) => const Divider(color: Colors.white24),
                      itemBuilder: (ctx, i) => ListTile(
                        title: Text(payments[i], style: const TextStyle(color: Colors.white)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removePayment(i),
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