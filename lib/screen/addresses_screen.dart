import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/colors.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  final TextEditingController _addressController = TextEditingController();
  List<String> addresses = [];

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      addresses = prefs.getStringList('user_addresses') ?? [];
    });
  }

  Future<void> _saveAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('user_addresses', addresses);
  }

  void _addAddress() {
    if (_addressController.text.trim().isEmpty) return;
    setState(() {
      addresses.add(_addressController.text.trim());
      _addressController.clear();
    });
    _saveAddresses();
  }

  void _removeAddress(int idx) {
    setState(() {
      addresses.removeAt(idx);
    });
    _saveAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(title: const Text('Mis Direcciones')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _addressController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Agregar dirección',
                labelStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white10,
              ),
              onSubmitted: (_) => _addAddress(),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: _addAddress,
              child: const Text('Agregar'),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: addresses.isEmpty
                  ? const Text('No hay direcciones guardadas.', style: TextStyle(color: Colors.white70))
                  : ListView.separated(
                      itemCount: addresses.length,
                      separatorBuilder: (_, __) => const Divider(color: Colors.white24),
                      itemBuilder: (ctx, i) => ListTile(
                        title: Text(addresses[i], style: const TextStyle(color: Colors.white)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeAddress(i),
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