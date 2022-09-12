import 'dart:convert';

List<Producto> productoFromMap(String str) =>
    List<Producto>.from(json.decode(str).map((x) => Producto.fromMap(x)));

String productoToMap(List<Producto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Producto {
  Producto({
    required this.id,
    required this.nombre,
    required this.cantidad,
    required this.idContenedor,
  });

  final int id;
  final String nombre;
  final int cantidad;
  final int? idContenedor;

  factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        id: json["id"],
        nombre: json["nombre"],
        cantidad: json["cantidad"],
        idContenedor: json["id_contenedor"] ?? null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "cantidad": cantidad,
        "id_contenedor": idContenedor ?? null,
      };
}
