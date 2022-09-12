import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/api/models/models.dart';
import 'package:stock_app/widgets/widgets.dart';

class ProductCard extends StatelessWidget {
  final Producto product;
  final double height;

  const ProductCard({super.key, required this.product, required this.height});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.indigo[50]!.withOpacity(0.4),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Container(
            alignment: Alignment.center,
            height: height,
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  width: 130,
                  child: Text(
                    product.nombre,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 22),
                CustomDetails(
                    label: "Contenedor",
                    labelValue: product.nombre,
                    icon: const Icon(
                      Icons.business_center_outlined,
                      color: Colors.black38,
                      size: 30,
                    )),
                const SizedBox(
                  width: 20,
                ),
                CustomDetails(
                    label: "Cantidad",
                    labelValue: product.cantidad.toString(),
                    icon: const Icon(
                      Icons.inventory_2_outlined,
                      color: Colors.black38,
                      size: 30,
                    )),
              ],
            )));
  }
}
