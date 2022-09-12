import 'dart:convert';

List<Contenedor> contenedorFromMap(String str) =>
    List<Contenedor>.from(json.decode(str).map((x) => Contenedor.fromMap(x)));

String contenedorToMap(List<Contenedor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Contenedor {
  Contenedor(
      {required this.id,
      required this.nombre,
      required this.categoria,
      required this.cantidad});

  final int id;
  final String nombre;
  final String categoria;
  final int cantidad;

  factory Contenedor.fromMap(Map<String, dynamic> json) => Contenedor(
      id: json["id"],
      nombre: json["nombre"],
      categoria: json["categoria"],
      cantidad: json["cantidad"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "categoria": categoria,
        "cantidad": cantidad
      };
}
