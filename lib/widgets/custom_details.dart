import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDetails extends StatelessWidget {
  final String label;
  final String labelValue;
  final Icon icon;
  final double? containerWidth;

  const CustomDetails({
    Key? key,
    required this.labelValue,
    required this.label,
    required this.icon,
    this.containerWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: containerWidth ?? 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                overflow: TextOverflow.clip,
                softWrap: true,
                maxLines: 1,
                style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.black54),
              ),
              Text(
                labelValue,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 1,
                style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
