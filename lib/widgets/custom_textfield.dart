import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/home/home.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelValue;
  final bool isAmount;
  final bool? isValidAmount;
  final bool enabled;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelValue,
    required this.isAmount,
    this.isValidAmount,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: controller,
      cursorColor: Colors.indigo,
      keyboardType: (isAmount) ? TextInputType.number : TextInputType.name,
      decoration: buildinputdecoration(labelValue, isValidAmount: isValidAmount),
      onTap: isAmount
          ? () {
              if (!isValidAmount!) {
                BlocProvider.of<CreateDialogBloc>(context).add(ChangeAmountInputErrorEvent(isValidAmount: true));
                return;
              }
            }
          : null,
    );
  }
}

InputDecoration buildinputdecoration(String? labelValue, {bool? isValidAmount}) {
  return InputDecoration(
    disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.indigo[200]!, width: 1, style: BorderStyle.solid)),
    hintStyle: GoogleFonts.roboto(color: Colors.black54),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(color: Colors.indigo[200]!, width: 1, style: BorderStyle.solid),
    ),
    errorBorder: isValidAmount != null && !isValidAmount
        ? const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)), borderSide: BorderSide(color: Colors.red, width: 1, style: BorderStyle.solid))
        : null,
    errorText: isValidAmount != null && !isValidAmount ? 'Cantidad inválida' : null,
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.indigo[400]!, width: 2),
    ),
    labelText: labelValue,
    labelStyle: const TextStyle(color: Colors.black54),
    contentPadding: const EdgeInsets.all(10),
    counterText: '',
  );
}
