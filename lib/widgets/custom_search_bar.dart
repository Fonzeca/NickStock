import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    Key? key,
    required TextEditingController controller,
    required this.onChanged,
    required this.hintText,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final void Function(String) onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.indigo,
      controller: _controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintStyle: GoogleFonts.roboto(color: Colors.black54),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.indigo[200]!, width: 2, style: BorderStyle.solid),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.indigo[400]!, width: 2),
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.all(10),
        counterText: '',
        suffixIcon: Icon(Icons.search_outlined, color: Colors.indigo[200]),
      ),
      maxLength: 15,
      maxLines: 1,
    );
  }
}
