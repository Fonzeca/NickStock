import 'dart:convert';

List<Historial> historialFromMap(String str) =>
    List<Historial>.from(json.decode(str).map((x) => Historial.fromMap(x)));

String historialToMap(List<Historial> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Historial {
  Historial({
    required this.id,
    required this.idProducto,
    required this.fecha,
    required this.cantidad,
    required this.tipo,
  });

  final int id;
  final int idProducto;
  final DateTime fecha;
  final int cantidad;
  final String tipo;

  factory Historial.fromMap(Map<String, dynamic> json) => Historial(
        id: json["id"],
        idProducto: json["id_producto"],
        fecha: DateTime.parse(json["fecha"]),
        cantidad: json["cantidad"],
        tipo: json["tipo"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_producto": idProducto,
        "fecha": fecha.toIso8601String(),
        "cantidad": cantidad,
        "tipo": tipo,
      };
}
