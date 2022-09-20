import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyContainerCard extends StatelessWidget {
  final double width;

  const EmptyContainerCard({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(top: 32, bottom: 10, left: 10),
      color: Colors.indigo[50],
      child: Container(
        width: width,
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "No hay ningún contenedor, añade uno tocando en el botón de '+'",
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black54),
          ),
        ]),
      ),
    );
  }
}
