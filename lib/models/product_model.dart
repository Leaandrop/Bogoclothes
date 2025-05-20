class Product {
  final String nombre;
  final String descripcion;
  final String imagen;
  final double precio;
  final String marca;
  final String categoria;
  final bool oferta;
  final List<String> tallas; // Puede ser vacío si no aplica

  Product({
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.precio,
    required this.marca,
    required this.categoria,
    this.oferta = false,
    List<String>? tallas,
  }) : tallas = tallas ?? [];

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'descripcion': descripcion,
    'imagen': imagen,
    'precio': precio,
    'marca': marca,
    'categoria': categoria,
    'oferta': oferta,
    'tallas': tallas,
  };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    nombre: json['nombre'],
    descripcion: json['descripcion'],
    imagen: json['imagen'],
    precio: (json['precio'] as num).toDouble(),
    marca: json['marca'],
    categoria: json['categoria'],
    oferta: json['oferta'] ?? false,
    tallas: (json['tallas'] as List<dynamic>?)?.cast<String>() ?? [],
  );
}