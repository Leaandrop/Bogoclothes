import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../data/products_data.dart';
import '../widgets/product_card.dart';
import '../models/product_model.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  String selectedMarca = 'Todas';
  String selectedCategory = 'todas';

  List<String> getMarcas() {
    final marcas = products.map((p) => p.marca).toSet().toList();
    marcas.insert(0, 'Todas');
    return marcas;
  }

  @override
  Widget build(BuildContext context) {
    // Filtrar productos por marca y por si es oferta
    List<Product> filteredProducts = products;
    if (selectedMarca != 'Todas') {
      filteredProducts = filteredProducts.where((p) => p.marca == selectedMarca).toList();
    }
    // Puedes filtrar por categoría si quieres también, por ahora solo marca

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Tienda', style: TextStyle(fontFamily: 'RobotoSlab')),
        backgroundColor: AppColors.backgroundLight,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
            tooltip: 'Favoritos',
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            tooltip: 'Carrito',
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // OFERTAS
          if (products.any((p) => p.oferta))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.local_offer, color: Colors.white, size: 32),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        '¡Ofertas especiales! Productos seleccionados con descuento.',
                        style: TextStyle(color: Colors.white, fontSize: 17, fontFamily: 'RobotoSlab'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 20),

          // Filtro de marcas
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: getMarcas().map((marca) {
                final selected = marca == selectedMarca;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ChoiceChip(
                    label: Text(marca,
                        style: TextStyle(
                            color: selected ? Colors.black : Colors.white,
                            fontFamily: 'RobotoSlab')),
                    selected: selected,
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.backgroundLight,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onSelected: (_) => setState(() => selectedMarca = marca),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 14),

          // Catálogo
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                itemCount: filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ProductCard(
                    product: product,
                    onTap: () {
                      Navigator.pushNamed(context, '/productDetail', arguments: product);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
