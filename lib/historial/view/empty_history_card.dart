import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyHistoryCard extends StatelessWidget {
  final double height;

  const EmptyHistoryCard({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.indigo[50]!.withOpacity(0.4),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Container(
            alignment: Alignment.topCenter,
            height: height,
            padding: const EdgeInsets.all(15),
            child: Text(
              "No hay historial",
              style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black54),
            )));
  }
}
