import 'product_model.dart';

class Order {
  final List<Product> productos;
  final String direccion;
  final String metodoPago;
  final DateTime fecha;

  Order({
    required this.productos,
    required this.direccion,
    required this.metodoPago,
    required this.fecha,
  });

  Map<String, dynamic> toJson() => {
        'productos': productos.map((p) => p.toJson()).toList(),
        'direccion': direccion,
        'metodoPago': metodoPago,
        'fecha': fecha.toIso8601String(),
      };

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        productos: (json['productos'] as List)
            .map((e) => Product.fromJson(e))
            .toList(),
        direccion: json['direccion'],
        metodoPago: json['metodoPago'],
        fecha: DateTime.parse(json['fecha']),
      );
}