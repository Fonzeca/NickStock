import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDetails extends StatelessWidget {
  final String label;
  final String labelValue;
  final Icon icon;

  const CustomDetails({
    Key? key,
    required this.labelValue,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.black54),
            ),
            Text(
              labelValue,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }
}
