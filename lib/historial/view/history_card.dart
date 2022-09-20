import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/api/models/models.dart';
import 'package:stock_app/widgets/widgets.dart';

class HistoryCard extends StatelessWidget {
  final Historial history;
  final double height;

  const HistoryCard({super.key, required this.history, required this.height});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: (history.tipo == "entrada") ? Colors.green[50]!.withOpacity(0.7) : Colors.red[50]!.withOpacity(0.7),
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
                  width: 60,
                  child: Text(
                    history.nombre_producto,
                    style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 5),
                CustomDetails(
                    label: "Fecha",
                    labelValue: DateFormat("yyyy-MM-dd HH:mm:ss").format(history.fecha),
                    icon: const Icon(
                      Icons.date_range_outlined,
                      color: Colors.black38,
                      size: 30,
                    )),
                const SizedBox(
                  width: 20,
                ),
                CustomDetails(
                    label: "Cantidad",
                    labelValue: history.cantidad.toString(),
                    icon: const Icon(
                      Icons.inventory_2_outlined,
                      color: Colors.black38,
                      size: 30,
                    )),
              ],
            )));
  }
}
