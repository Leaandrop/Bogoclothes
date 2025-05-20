import '../models/product_model.dart';

// Marcas por categoría
final List<String> marcasRopa = [
  'Zara', 'H&M', 'Koaj', 'Bershka', 'Shein', 'Totto', 'Nike', 'Adidas', 'Levi\'s',
  'Americanino', 'Pull&Bear', 'Stradivarius', 'Lacoste', 'Diesel', 'Polo',
  'Studio F', 'Gef', 'Arturo Calle', 'Fila', 'Reebok'
];

final List<String> marcasPerfume = [
  'Hugo Boss', 'Dior', 'Paco Rabanne', 'Natura', 'Channel', 'Lacoste', 'Armani',
  'Carolina Herrera', 'CK', 'Givenchy', 'Versace', 'Tommy Hilfiger'
];

final List<String> marcasAccesorio = [
  'Totto', 'Gef', 'Mango', 'Studio F', 'Swatch', 'Casio', 'Daniel Wellington',
  'Rolex', 'Ray-Ban', 'Oakley', 'Fossil', 'Victorinox'
];

final List<String> imagenesPorCategoria = [
  'assets/images/categoria_ropa.png',         // Ropa
  'assets/images/categoria_perfumes.png',     // Perfumes
  'assets/images/categoria_accesorios.png',   // Accesorios
];

final List<String> tallasRopa = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

// Nombres realistas para accesorios y perfumes
final List<String> nombresAccesorios = [
  'Mochila', 'Reloj', 'Gorra', 'Cinturón', 'Bufanda', 'Gafas de Sol', 'Billetera',
  'Pulsera', 'Bolso', 'Maletín', 'Riñonera', 'Portadocumentos', 'Aretes', 'Collar'
];

final List<String> nombresPerfumes = [
  'Eau de Parfum', 'Colonia Fresh', 'Perfume Intense', 'Body Spray', 'Fragancia Classic',
  'Mist for Her', 'Aqua Man', 'Aromatics', 'Night Essence', 'Citrus Splash'
];

// GENERADOR AUTOMÁTICO MEJORADO
List<Product> generateProducts() {
  final List<Product> result = [];
  // ----------- ROPA -----------
  for (int i = 0; i < 1000; i++) {
    final marca = marcasRopa[i % marcasRopa.length];
    final double precio = 40000 + (i % 10) * 3000;
    final bool esOferta = i % 3 == 0;
    final nombre = 'Camiseta ${marca} ${i + 1}';
    final descripcion = 'Camiseta cómoda de algodón, ideal para uso diario y exclusiva de $marca.';

    result.add(Product(
      nombre: nombre,
      descripcion: descripcion,
      imagen: imagenesPorCategoria[0],
      precio: precio,
      marca: marca,
      categoria: 'Ropa',
      oferta: esOferta,
      tallas: List.from(tallasRopa),
    ));
  }

  // ----------- PERFUMES -----------
  for (int i = 0; i < 1000; i++) {
    final marca = marcasPerfume[i % marcasPerfume.length];
    final nombre = '${nombresPerfumes[i % nombresPerfumes.length]} $marca';
    final double precio = 90000 + (i % 15) * 6000;
    final bool esOferta = i % 4 == 0;
    final descripcion = 'Perfume original $marca: aroma sofisticado, presentación de 100ml.';

    result.add(Product(
      nombre: nombre,
      descripcion: descripcion,
      imagen: imagenesPorCategoria[1],
      precio: precio,
      marca: marca,
      categoria: 'Perfumes',
      oferta: esOferta,
      tallas: [], // NO tiene tallas
    ));
  }

  // ----------- ACCESORIOS -----------
  for (int i = 0; i < 1000; i++) {
    final marca = marcasAccesorio[i % marcasAccesorio.length];
    final nombreBase = nombresAccesorios[i % nombresAccesorios.length];
    final nombre = '$nombreBase $marca';
    final double precio = 35000 + (i % 14) * 3500;
    final bool esOferta = i % 5 == 0;
    final descripcion = '$nombreBase de la marca $marca. Elegante, práctico y con garantía.';

    result.add(Product(
      nombre: nombre,
      descripcion: descripcion,
      imagen: imagenesPorCategoria[2],
      precio: precio,
      marca: marca,
      categoria: 'Accesorios',
      oferta: esOferta,
      tallas: [], // NO tiene tallas
    ));
  }

  return result;
}

final List<Product> products = generateProducts();