import 'dart:convert';

List<Producto> productoFromMap(String str) => List<Producto>.from(json.decode(str).map((x) => Producto.fromMap(x)));

String productoToMap(List<Producto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Producto {
  Producto({this.id, required this.nombre, required this.cantidad, required this.idContenedor, this.nombreContenedor});

  final int? id;
  final String nombre;
  final int cantidad;
  final int? idContenedor;
  final String? nombreContenedor;

  factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        id: json["id"],
        nombre: json["nombre"],
        cantidad: json["cantidad"],
        idContenedor: json["id_contenedor"],
        nombreContenedor: json["nombreContenedor"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "cantidad": cantidad,
        "id_contenedor": idContenedor,
        "nombre_contenedor": nombreContenedor,
      };
}
