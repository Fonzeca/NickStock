import 'dart:convert';

List<Historial> historialFromMap(String str) => List<Historial>.from(json.decode(str).map((x) => Historial.fromMap(x)));

String historialToMap(List<Historial> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Historial {
  Historial(
      {required this.id,
      required this.fecha,
      required this.cantidad,
      required this.tipo,
      required this.contenedor_id,
      required this.nombre_producto});

  final int id;
  final DateTime fecha;
  final int cantidad;
  final String tipo;
  final int contenedor_id;
  final String nombre_producto;

  factory Historial.fromMap(Map<String, dynamic> json) => Historial(
        id: json["id"],
        fecha: DateTime.parse(json["fecha"]),
        cantidad: json["cantidad"],
        tipo: json["tipo"],
        contenedor_id: json["contenedor_id"],
        nombre_producto: json["nombre_producto"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "fecha": fecha.toIso8601String(),
        "cantidad": cantidad,
        "tipo": tipo,
        "contenedor_id": contenedor_id,
        "nombre_producto": nombre_producto
      };
}
